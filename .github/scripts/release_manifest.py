"""Merge latest.json without dropping the other platform's build."""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
from pathlib import Path

DOWNLOAD_ROOT = "https://github.com/Mahinika/gramnota/releases/download/latest"
ASSET_NAMES = {"android": "Gramnota.apk", "windows": "Gramnota-Setup.exe"}
SHA_RE = re.compile(r"^[0-9a-fA-F]{64}$")


def other_platform(platform: str) -> str:
    if platform == "android":
        return "windows"
    if platform == "windows":
        return "android"
    raise ValueError(f"unknown platform {platform}")


def notes(platform: str, version: str, build: int, date: str) -> str:
    label = "Android" if platform == "android" else "Windows"
    return f"{label} {version} (build {build}), bygge {date}."


def artifact(
    *,
    platform: str,
    version: str,
    build: int,
    commit: str,
    date: str,
    sha256: str,
) -> dict[str, object]:
    if not SHA_RE.fullmatch(sha256):
        raise ValueError("sha256 must be 64 hex characters")
    return {
        "build": build,
        "commit": commit,
        "date": date,
        "notes": notes(platform, version, build, date),
        "url": f"{DOWNLOAD_ROOT}/{ASSET_NAMES[platform]}",
        "sha256": sha256.lower(),
    }


def merge_manifest(
    current: dict[str, object],
    platform: str,
    section: dict[str, object],
    version: str,
) -> dict[str, object]:
    other = other_platform(platform)
    merged: dict[str, object] = {"version": version}
    preserved = current.get(other)
    if isinstance(preserved, dict):
        merged[other] = preserved
    merged[platform] = section
    ordered: dict[str, object] = {"version": version}
    for name in ("android", "windows"):
        if name in merged:
            ordered[name] = merged[name]
    return ordered


def manifests_match(live: dict[str, object], expected: dict[str, object], platform: str) -> bool:
    other = other_platform(platform)
    return (
        live.get("version") == expected.get("version")
        and live.get(platform) == expected.get(platform)
        and live.get(other) == expected.get(other)
    )


def file_sha256(path: str) -> str:
    digest = hashlib.sha256()
    with Path(path).open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def _load(path: str) -> dict[str, object]:
    data = json.loads(Path(path).read_text(encoding="utf-8"))
    if not isinstance(data, dict):
        raise ValueError("manifest must be an object")
    return data


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser()
    sub = parser.add_subparsers(dest="cmd", required=True)

    sha = sub.add_parser("sha256")
    sha.add_argument("path")

    merge = sub.add_parser("merge")
    merge.add_argument("--current", required=True)
    merge.add_argument("--platform", required=True)
    merge.add_argument("--version", required=True)
    merge.add_argument("--build", required=True)
    merge.add_argument("--commit", required=True)
    merge.add_argument("--date", required=True)
    merge.add_argument("--sha256", required=True)
    merge.add_argument("--out", required=True)

    check = sub.add_parser("check")
    check.add_argument("--file", required=True)
    check.add_argument("--expected", required=True)
    check.add_argument("--platform", required=True)

    args = parser.parse_args(argv)
    if args.cmd == "sha256":
        print(file_sha256(args.path))
        return 0
    if args.cmd == "merge":
        section = artifact(
            platform=args.platform,
            version=args.version,
            build=int(args.build),
            commit=args.commit,
            date=args.date,
            sha256=args.sha256,
        )
        merged = merge_manifest(_load(args.current), args.platform, section, args.version)
        Path(args.out).write_text(
            json.dumps(merged, indent=2, ensure_ascii=False) + "\n",
            encoding="utf-8",
        )
        return 0
    if args.cmd == "check":
        ok = manifests_match(_load(args.file), _load(args.expected), args.platform)
        return 0 if ok else 1
    raise AssertionError(args.cmd)


if __name__ == "__main__":
    sys.exit(main())
