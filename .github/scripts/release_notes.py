"""Merge the shared release notes and keep a short publish lock.

Android and Windows publish on the same GitHub release. Each job replaces
only its own version line. A lock comment stops one job from saving a stale
body over the other job's line.
"""

from __future__ import annotations

import argparse
import json
import re
import sys
from datetime import datetime, timezone
from pathlib import Path

RELEASE_TITLE = "Gramnota – latest version"
LOCK_TTL_SECONDS = 180
LOCK_RE = re.compile(r"<!-- publish-lock:([a-z]+):(\d+) -->\n?")
VERSION_RE = re.compile(r"^version:\s*(\d+\.\d+\.\d+)\+(\d+)\s*$", re.MULTILINE)


def section_pattern(platform: str) -> re.Pattern[str]:
    start = re.escape(f"<!-- platform:{platform} -->")
    end = re.escape(f"<!-- /platform:{platform} -->")
    return re.compile(start + r"\n?(.*?)\n?" + end, re.DOTALL)


def normalize(body: str) -> str:
    return body.replace("\r\n", "\n").strip()


def other_platform(platform: str) -> str:
    if platform == "android":
        return "windows"
    if platform == "windows":
        return "android"
    raise ValueError(f"unknown platform {platform}")


def extract_section(body: str, platform: str) -> str | None:
    match = section_pattern(platform).search(body.replace("\r\n", "\n"))
    if not match:
        return None
    return match.group(1).strip("\n")


def replace_section(body: str, platform: str, content: str) -> str:
    block = (
        f"<!-- platform:{platform} -->\n"
        f"{content.strip()}\n"
        f"<!-- /platform:{platform} -->"
    )
    pattern = section_pattern(platform)
    if pattern.search(body):
        return pattern.sub(lambda _match: block, body, count=1)
    return body.rstrip() + "\n\n" + block + "\n"


def merge_notes(template: str, current: str, platform: str, content: str) -> str:
    """Start from the template, keep the other platform's live line, set ours."""
    other = other_platform(platform)
    body = template.replace("\r\n", "\n")
    preserved = extract_section(strip_lock(current), other)
    if preserved is not None:
        body = replace_section(body, other, preserved)
    merged = replace_section(body, platform, content)
    if not merged.endswith("\n"):
        merged += "\n"
    return merged


def section_text(
    platform: str, version: str, build: str, date: str, sha: str
) -> str:
    label = "Android" if platform == "android" else "Windows"
    return f"**{label}:** {version} (build {build}) · {date} · `{sha}`"


def get_lock(body: str) -> tuple[str, int] | None:
    match = LOCK_RE.search(body.replace("\r\n", "\n"))
    if not match:
        return None
    return match.group(1), int(match.group(2))


def strip_lock(body: str) -> str:
    return LOCK_RE.sub("", body.replace("\r\n", "\n"), count=1)


def with_lock(body: str, owner: str, now: int) -> str:
    unlocked = strip_lock(body).lstrip("\n")
    return f"<!-- publish-lock:{owner}:{now} -->\n{unlocked}"


def lock_is_busy(body: str, owner: str, now: int, ttl: int = LOCK_TTL_SECONDS) -> bool:
    lock = get_lock(body)
    if lock is None:
        return False
    holder, stamped = lock
    if holder == owner:
        return False
    return now - stamped < ttl


def prepare_body(
    template: str, current: str, platform: str, content: str, now: int
) -> str | None:
    """Locked body to write, or None when the other job holds a fresh lock."""
    if lock_is_busy(current, platform, now):
        return None
    merged = merge_notes(template, current, platform, content)
    return with_lock(merged, platform, now)


def unlock_body(current: str, owner: str) -> str | None:
    """Remove our lock. None when the other job holds the lock."""
    lock = get_lock(current)
    if lock is not None and lock[0] != owner:
        return None
    return strip_lock(current).lstrip("\n")


def pubspec_version(text: str) -> tuple[str, str]:
    match = VERSION_RE.search(text)
    if not match:
        raise ValueError("pubspec.yaml version must look like 1.0.0+1")
    return match.group(1), match.group(2)


def stockholm_today(now: datetime | None = None) -> str:
    moment = now or datetime.now(timezone.utc)
    try:
        from zoneinfo import ZoneInfo

        local = moment.astimezone(ZoneInfo("Europe/Stockholm"))
    except Exception:
        local = moment.astimezone(timezone.utc)
    return local.strftime("%Y-%m-%d")


def release_body(release_json: str) -> str:
    data = json.loads(release_json)
    body = data.get("body") or ""
    if not isinstance(body, str):
        raise ValueError("release body is not text")
    return body


def bodies_equal(left: str, right: str) -> bool:
    return normalize(left) == normalize(right)


def patch_payload(
    body: str,
    *,
    title: str | None = None,
    target: str | None = None,
    make_latest: bool = False,
) -> dict[str, object]:
    payload: dict[str, object] = {"body": body}
    if title is not None:
        payload["name"] = title
    if target is not None:
        payload["target_commitish"] = target
    if make_latest:
        payload["make_latest"] = "true"
        payload["draft"] = False
        payload["prerelease"] = False
    return payload


def _read(path: str) -> str:
    return Path(path).read_text(encoding="utf-8")


def _write(path: str, text: str) -> None:
    Path(path).write_text(text, encoding="utf-8")


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser()
    sub = parser.add_subparsers(dest="cmd", required=True)

    sub.add_parser("title")

    version = sub.add_parser("version")
    version.add_argument("pubspec")

    sub.add_parser("today")

    section = sub.add_parser("section-text")
    section.add_argument("--platform", required=True)
    section.add_argument("--version", required=True)
    section.add_argument("--build", required=True)
    section.add_argument("--date", required=True)
    section.add_argument("--sha", required=True)
    section.add_argument("--out")

    prepare = sub.add_parser("prepare")
    prepare.add_argument("--template", required=True)
    prepare.add_argument("--release-json", required=True)
    prepare.add_argument("--platform", required=True)
    prepare.add_argument("--content-file", required=True)
    prepare.add_argument("--now", type=int, required=True)
    prepare.add_argument("--out", required=True)

    same = sub.add_parser("same-body")
    same.add_argument("--release-json", required=True)
    same.add_argument("--body-file", required=True)

    same_source = sub.add_parser("same-source")
    same_source.add_argument("--before-json", required=True)
    same_source.add_argument("--after-json", required=True)

    unlock = sub.add_parser("unlock")
    unlock.add_argument("--release-json", required=True)
    unlock.add_argument("--platform", required=True)
    unlock.add_argument("--out", required=True)

    has = sub.add_parser("has-section")
    has.add_argument("--release-json", required=True)
    has.add_argument("--platform", required=True)
    has.add_argument("--content-file", required=True)

    patch = sub.add_parser("patch-json")
    patch.add_argument("--body-file", required=True)
    patch.add_argument("--out", required=True)
    patch.add_argument("--title")
    patch.add_argument("--target")
    patch.add_argument("--make-latest", action="store_true")

    args = parser.parse_args(argv)
    if args.cmd == "title":
        print(RELEASE_TITLE)
        return 0
    if args.cmd == "version":
        name, build = pubspec_version(_read(args.pubspec))
        print(f"{name} {build}")
        return 0
    if args.cmd == "today":
        print(stockholm_today())
        return 0
    if args.cmd == "section-text":
        text = section_text(
            args.platform, args.version, args.build, args.date, args.sha
        )
        if args.out:
            _write(args.out, text + "\n")
        else:
            print(text)
        return 0
    if args.cmd == "prepare":
        body = prepare_body(
            _read(args.template),
            release_body(_read(args.release_json)),
            args.platform,
            _read(args.content_file),
            args.now,
        )
        if body is None:
            return 10
        _write(args.out, body)
        return 0
    if args.cmd == "same-body":
        live = release_body(_read(args.release_json))
        return 0 if bodies_equal(live, _read(args.body_file)) else 1
    if args.cmd == "same-source":
        before = release_body(_read(args.before_json))
        after = release_body(_read(args.after_json))
        return 0 if bodies_equal(before, after) else 1
    if args.cmd == "unlock":
        body = unlock_body(release_body(_read(args.release_json)), args.platform)
        if body is None:
            return 11
        _write(args.out, body)
        return 0
    if args.cmd == "has-section":
        live = extract_section(release_body(_read(args.release_json)), args.platform)
        wanted = _read(args.content_file).strip()
        return 0 if live == wanted else 1
    if args.cmd == "patch-json":
        payload = patch_payload(
            _read(args.body_file),
            title=args.title,
            target=args.target,
            make_latest=args.make_latest,
        )
        _write(args.out, json.dumps(payload))
        return 0
    raise AssertionError(args.cmd)


if __name__ == "__main__":
    sys.exit(main())
