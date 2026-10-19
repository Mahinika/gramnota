import json
import unittest

import release_manifest

SHA_A = "a" * 64
SHA_B = "b" * 64


class ReleaseManifestTest(unittest.TestCase):
    def test_merge_keeps_the_other_platform(self) -> None:
        windows = release_manifest.artifact(
            platform="windows",
            version="1.0.0",
            build=3,
            commit="ccc",
            date="2026-10-19",
            sha256=SHA_B,
        )
        current = release_manifest.merge_manifest({}, "windows", windows, "1.0.0")
        android = release_manifest.artifact(
            platform="android",
            version="1.0.0",
            build=9,
            commit="aaa",
            date="2026-10-19",
            sha256=SHA_A,
        )
        merged = release_manifest.merge_manifest(current, "android", android, "1.0.0")
        self.assertEqual(merged["android"], android)
        self.assertEqual(merged["windows"], windows)
        self.assertEqual(merged["android"]["url"], f"{release_manifest.DOWNLOAD_ROOT}/Gramnota.apk")
        self.assertEqual(
            merged["windows"]["url"],
            f"{release_manifest.DOWNLOAD_ROOT}/Gramnota-Setup.exe",
        )
        self.assertIn("built 2026-10-19", merged["android"]["notes"])

    def test_second_android_publish_does_not_drop_windows(self) -> None:
        windows = release_manifest.artifact(
            platform="windows",
            version="1.0.0",
            build=3,
            commit="ccc",
            date="2026-10-18",
            sha256=SHA_B,
        )
        android = release_manifest.artifact(
            platform="android",
            version="1.0.0",
            build=4,
            commit="old",
            date="2026-10-18",
            sha256=SHA_A,
        )
        current = {"version": "1.0.0", "android": android, "windows": windows}
        newer = release_manifest.artifact(
            platform="android",
            version="1.0.0",
            build=5,
            commit="new",
            date="2026-10-19",
            sha256="c" * 64,
        )
        merged = release_manifest.merge_manifest(current, "android", newer, "1.0.0")
        self.assertEqual(merged["windows"]["build"], 3)
        self.assertEqual(merged["android"]["build"], 5)
        self.assertTrue(release_manifest.manifests_match(merged, merged, "android"))

    def test_check_fails_when_the_other_platform_disappears(self) -> None:
        expected = {
            "version": "1.0.0",
            "android": {"build": 2},
            "windows": {"build": 3},
        }
        live = {"version": "1.0.0", "android": {"build": 2}}
        self.assertFalse(release_manifest.manifests_match(live, expected, "android"))

    def test_rejects_a_short_checksum(self) -> None:
        with self.assertRaises(ValueError):
            release_manifest.artifact(
                platform="android",
                version="1.0.0",
                build=1,
                commit="abc",
                date="2026-10-19",
                sha256="abcd",
            )

    def test_roundtrip_json(self) -> None:
        section = release_manifest.artifact(
            platform="windows",
            version="1.0.0",
            build=8,
            commit="def",
            date="2026-10-19",
            sha256=SHA_B,
        )
        merged = release_manifest.merge_manifest({}, "windows", section, "1.0.0")
        encoded = json.dumps(merged)
        self.assertEqual(json.loads(encoded)["windows"]["sha256"], SHA_B)


if __name__ == "__main__":
    unittest.main()
