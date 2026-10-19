import json
import unittest
from pathlib import Path

import release_notes

TEMPLATE = """\
Gramnota räknar ut ett försäljningspris för en 3D-utskrift.

<!-- platform:android -->
**Android:** inte publicerad än.
<!-- /platform:android -->

<!-- platform:windows -->
**Windows:** inte publicerad än.
<!-- /platform:windows -->
"""

ANDROID = "**Android:** 1.0.0 (build 4) · 2026-10-19 · `abc1234`"
WINDOWS = "**Windows:** 1.0.0 (build 9) · 2026-10-19 · `def5678`"


class ReleaseNotesTest(unittest.TestCase):
    def test_merge_keeps_the_other_platform(self) -> None:
        current = release_notes.merge_notes(TEMPLATE, TEMPLATE, "windows", WINDOWS)
        merged = release_notes.merge_notes(TEMPLATE, current, "android", ANDROID)
        self.assertEqual(release_notes.extract_section(merged, "android"), ANDROID)
        self.assertEqual(release_notes.extract_section(merged, "windows"), WINDOWS)
        self.assertIn("försäljningspris", merged)

    def test_merge_replaces_only_own_line(self) -> None:
        current = release_notes.merge_notes(TEMPLATE, TEMPLATE, "android", ANDROID)
        newer = "**Android:** 1.0.0 (build 5) · 2026-10-20 · `ffff000`"
        merged = release_notes.merge_notes(TEMPLATE, current, "android", newer)
        self.assertEqual(release_notes.extract_section(merged, "android"), newer)
        self.assertIn("inte publicerad än", release_notes.extract_section(merged, "windows") or "")

    def test_crlf_template_still_merges(self) -> None:
        template = TEMPLATE.replace("\n", "\r\n")
        merged = release_notes.merge_notes(template, template, "android", ANDROID)
        self.assertEqual(release_notes.extract_section(merged, "android"), ANDROID)

    def test_lock_blocks_the_other_job_until_it_expires(self) -> None:
        locked = release_notes.with_lock(TEMPLATE, "android", 1_000)
        self.assertTrue(release_notes.lock_is_busy(locked, "windows", 1_100))
        self.assertFalse(release_notes.lock_is_busy(locked, "android", 1_100))
        self.assertFalse(release_notes.lock_is_busy(locked, "windows", 1_000 + 180))

    def test_prepare_writes_lock_and_preserves_windows(self) -> None:
        current = release_notes.merge_notes(TEMPLATE, TEMPLATE, "windows", WINDOWS)
        prepared = release_notes.prepare_body(TEMPLATE, current, "android", ANDROID, 50)
        self.assertIsNotNone(prepared)
        assert prepared is not None
        self.assertEqual(release_notes.get_lock(prepared), ("android", 50))
        self.assertEqual(release_notes.extract_section(prepared, "android"), ANDROID)
        self.assertEqual(release_notes.extract_section(prepared, "windows"), WINDOWS)

    def test_prepare_waits_when_the_other_lock_is_fresh(self) -> None:
        current = release_notes.with_lock(
            release_notes.merge_notes(TEMPLATE, TEMPLATE, "windows", WINDOWS),
            "windows",
            1_000,
        )
        self.assertIsNone(
            release_notes.prepare_body(TEMPLATE, current, "android", ANDROID, 1_020)
        )

    def test_stale_lock_can_be_taken_over(self) -> None:
        current = release_notes.with_lock(TEMPLATE, "windows", 1_000)
        prepared = release_notes.prepare_body(
            TEMPLATE, current, "android", ANDROID, 1_000 + 180
        )
        self.assertIsNotNone(prepared)
        assert prepared is not None
        self.assertEqual(release_notes.get_lock(prepared), ("android", 1_180))
        self.assertEqual(release_notes.extract_section(prepared, "android"), ANDROID)

    def test_unlock_removes_our_lock_only(self) -> None:
        locked = release_notes.prepare_body(TEMPLATE, TEMPLATE, "android", ANDROID, 9)
        assert locked is not None
        unlocked = release_notes.unlock_body(locked, "android")
        self.assertIsNone(release_notes.get_lock(unlocked or ""))
        self.assertEqual(release_notes.extract_section(unlocked or "", "android"), ANDROID)
        self.assertIsNone(release_notes.unlock_body(locked, "windows"))

    def test_pubspec_version(self) -> None:
        self.assertEqual(
            release_notes.pubspec_version("name: gramnota\nversion: 1.0.0+1\n"),
            ("1.0.0", "1"),
        )
        with self.assertRaises(ValueError):
            release_notes.pubspec_version("version: 1.0\n")

    def test_section_text_and_patch_payload(self) -> None:
        text = release_notes.section_text("windows", "1.0.0", "12", "2026-10-19", "abc1234")
        self.assertIn("**Windows:**", text)
        self.assertIn("`abc1234`", text)
        payload = release_notes.patch_payload(
            "hej",
            title=release_notes.RELEASE_TITLE,
            target="abc",
            make_latest=True,
        )
        self.assertEqual(payload["name"], "Gramnota – senaste versionen")
        self.assertEqual(payload["make_latest"], "true")
        self.assertEqual(payload["target_commitish"], "abc")
        legacy = release_notes.patch_payload("pekare", title="äldre")
        self.assertNotIn("make_latest", legacy)
        self.assertNotIn("target_commitish", legacy)

    def test_repo_template_has_both_markers(self) -> None:
        template = Path(__file__).resolve().parents[1].joinpath(
            "release-notes", "latest.md"
        ).read_text(encoding="utf-8")
        self.assertIsNotNone(release_notes.extract_section(template, "android"))
        self.assertIsNotNone(release_notes.extract_section(template, "windows"))
        self.assertNotIn("inloggad", template.lower())

    def test_release_json_body_roundtrip(self) -> None:
        raw = json.dumps({"body": TEMPLATE})
        self.assertTrue(
            release_notes.bodies_equal(release_notes.release_body(raw), TEMPLATE)
        )


if __name__ == "__main__":
    unittest.main()
