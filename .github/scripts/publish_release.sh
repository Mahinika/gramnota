#!/usr/bin/env bash
# Publish this platform's files on the shared "latest" release.
# The other platform's assets and version line are left in place.
# Usage: publish_release.sh android|windows <file> [file...]
set -euo pipefail

PLATFORM="${1:?android or windows}"
shift
if [ "$#" -lt 1 ]; then
  echo "Pass the files to upload."
  exit 1
fi
PRIMARY="$1"

case "$PLATFORM" in
  android | windows) ;;
  *)
    echo "Platform must be android or windows."
    exit 1
    ;;
esac

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT"
PY_SCRIPT="$ROOT/.github/scripts/release_notes.py"
MANIFEST_PY="$ROOT/.github/scripts/release_manifest.py"
TEMPLATE="$ROOT/.github/release-notes/latest.md"
REPO="${GITHUB_REPOSITORY:?GITHUB_REPOSITORY is required}"
SHA="${GITHUB_SHA:?GITHUB_SHA is required}"
SHORT_SHA="${SHA:0:7}"

if command -v python3 >/dev/null 2>&1; then
  PY=(python3)
else
  PY=(python)
fi

py() {
  "${PY[@]}" "$PY_SCRIPT" "$@"
}

TITLE="$(py title)"
read -r VERSION BUILD < <(py version "$ROOT/pubspec.yaml")
if [ -n "${RELEASE_BUILD:-}" ]; then
  case "$RELEASE_BUILD" in
    *[!0-9]*)
      echo "RELEASE_BUILD must be a number."
      exit 1
      ;;
  esac
  BUILD="$RELEASE_BUILD"
fi
DATE="$(py today)"
PRIMARY_SHA="$("${PY[@]}" "$MANIFEST_PY" sha256 "$PRIMARY")"
WORKDIR="$(mktemp -d)"
trap 'rm -rf "$WORKDIR"' EXIT

py section-text \
  --platform "$PLATFORM" \
  --version "$VERSION" \
  --build "$BUILD" \
  --date "$DATE" \
  --sha "$SHORT_SHA" >"$WORKDIR/section.txt"

ensure_release() {
  if gh release view latest --repo "$REPO" >/dev/null 2>&1; then
    return 0
  fi
  gh release create latest \
    --repo "$REPO" \
    --title "$TITLE" \
    --notes-file "$TEMPLATE" \
    --target "$SHA" \
    --latest || true
  local i
  for i in 1 2 3 4 5 6 7 8 9 10; do
    if gh release view latest --repo "$REPO" >/dev/null 2>&1; then
      return 0
    fi
    sleep 2
  done
  echo "The latest release was not created."
  return 1
}

fetch_release() {
  gh api "repos/${REPO}/releases/tags/latest" >"$1"
}

patch_release_file() {
  local release_json="$1"
  local body_file="$2"
  local id
  id="$("${PY[@]}" -c 'import json,sys; print(json.load(open(sys.argv[1], encoding="utf-8"))["id"])' "$release_json")"
  py patch-json \
    --body-file "$body_file" \
    --title "$TITLE" \
    --target "$SHA" \
    --make-latest \
    --out "$WORKDIR/payload.json"
  gh api --method PATCH "repos/${REPO}/releases/${id}" --input "$WORKDIR/payload.json" >/dev/null
}

# Write body only if the release body is still the one we merged from.
commit_body() {
  local base_json="$1"
  local body_file="$2"
  fetch_release "$WORKDIR/now.json"
  if ! py same-source --before-json "$base_json" --after-json "$WORKDIR/now.json"; then
    return 1
  fi
  patch_release_file "$WORKDIR/now.json" "$body_file"
  fetch_release "$WORKDIR/after.json"
  py same-body --release-json "$WORKDIR/after.json" --body-file "$body_file"
}

update_notes() {
  local attempt
  for attempt in $(seq 1 12); do
    fetch_release "$WORKDIR/base.json"
    local now
    now="$(date +%s)"
    set +e
    py prepare \
      --template "$TEMPLATE" \
      --release-json "$WORKDIR/base.json" \
      --platform "$PLATFORM" \
      --content-file "$WORKDIR/section.txt" \
      --now "$now" \
      --out "$WORKDIR/locked.md"
    local prepared=$?
    set -e
    if [ "$prepared" -eq 10 ]; then
      echo "The other publish holds the release notes. Waiting."
      sleep $((2 + attempt))
      continue
    fi
    if [ "$prepared" -ne 0 ]; then
      echo "Could not prepare the release notes."
      return 1
    fi
    if ! commit_body "$WORKDIR/base.json" "$WORKDIR/locked.md"; then
      echo "Release notes changed while publishing. Retrying."
      sleep $((1 + (attempt % 3)))
      continue
    fi
    if ! publish_manifest; then
      echo "Could not publish latest.json. Retrying."
      sleep 2
      continue
    fi
    fetch_release "$WORKDIR/locked-live.json"
    set +e
    py unlock \
      --release-json "$WORKDIR/locked-live.json" \
      --platform "$PLATFORM" \
      --out "$WORKDIR/unlocked.md"
    local unlocked=$?
    set -e
    if [ "$unlocked" -ne 0 ]; then
      echo "Lost the publish lock before it was cleared. Retrying."
      sleep 2
      continue
    fi
    if ! commit_body "$WORKDIR/locked-live.json" "$WORKDIR/unlocked.md"; then
      echo "Could not clear the publish lock. Retrying."
      sleep 2
      continue
    fi
    sleep 2
    fetch_release "$WORKDIR/settled.json"
    if py has-section \
      --release-json "$WORKDIR/settled.json" \
      --platform "$PLATFORM" \
      --content-file "$WORKDIR/section.txt"; then
      return 0
    fi
    echo "The version line was overwritten. Retrying."
  done
  echo "Gave up updating the release notes."
  return 1
}

publish_manifest() {
  local download_dir="$WORKDIR/manifest-dl"
  rm -rf "$download_dir"
  mkdir -p "$download_dir"
  if ! gh release download latest --repo "$REPO" --pattern latest.json --dir "$download_dir"; then
    printf '%s\n' '{}' >"$download_dir/latest.json"
  fi
  "${PY[@]}" "$MANIFEST_PY" merge \
    --current "$download_dir/latest.json" \
    --platform "$PLATFORM" \
    --version "$VERSION" \
    --build "$BUILD" \
    --commit "$SHORT_SHA" \
    --date "$DATE" \
    --sha256 "$PRIMARY_SHA" \
    --out "$WORKDIR/latest.json"
  local i
  for i in 1 2 3 4 5; do
    if gh release upload latest "$WORKDIR/latest.json" --clobber --repo "$REPO"; then
      break
    fi
    if [ "$i" -eq 5 ]; then
      echo "Upload of latest.json failed."
      return 1
    fi
    sleep $((i * 2))
  done
  local check
  for check in 1 2 3 4 5 6; do
    local live="$WORKDIR/manifest-check"
    rm -rf "$live"
    mkdir -p "$live"
    if gh release download latest --repo "$REPO" --pattern latest.json --dir "$live" \
      && "${PY[@]}" "$MANIFEST_PY" check \
        --file "$live/latest.json" \
        --expected "$WORKDIR/latest.json" \
        --platform "$PLATFORM"; then
      return 0
    fi
    sleep 2
  done
  echo "latest.json did not keep this platform's build."
  return 1
}

upload_assets() {
  local file
  for file in "$@"; do
    if [ ! -s "$file" ]; then
      echo "Missing release file: $file"
      return 1
    fi
    local i
    for i in 1 2 3 4 5; do
      if gh release upload latest "$file" --clobber --repo "$REPO"; then
        break
      fi
      if [ "$i" -eq 5 ]; then
        echo "Upload failed: $file"
        return 1
      fi
      sleep $((i * 2))
    done
  done
}

should_delete() {
  local name="$1"
  case "$PLATFORM" in
    android)
      [[ "$name" == *.apk && "$name" != "Gramnota.apk" ]]
      ;;
    windows)
      [[ ( "$name" == *.exe && "$name" != "Gramnota-Setup.exe" ) || ( "$name" == *.zip && "$name" != "Gramnota-windows.zip" ) ]]
      ;;
  esac
}

delete_renamed_assets() {
  local id name
  while IFS=$'\t' read -r id name; do
    if [ -z "$id" ] || [ -z "$name" ]; then
      continue
    fi
    if [ "$name" = "latest.json" ]; then
      continue
    fi
    if should_delete "$name"; then
      echo "Removing old asset $name"
      gh api --method DELETE "repos/${REPO}/releases/assets/${id}" >/dev/null
    fi
  done < <(gh api "repos/${REPO}/releases/tags/latest" --jq '.assets[] | [.id, .name] | @tsv')
}

update_legacy_notes() {
  local tag notes title
  case "$PLATFORM" in
    android)
      tag="android"
      notes="$ROOT/.github/release-notes/android-legacy.md"
      title="Gramnota för Android (äldre länk)"
      ;;
    windows)
      tag="windows"
      notes="$ROOT/.github/release-notes/windows-legacy.md"
      title="Gramnota för Windows (äldre länk)"
      ;;
  esac
  if ! gh release view "$tag" --repo "$REPO" >/dev/null 2>&1; then
    echo "No $tag release to point at the new downloads."
    return 0
  fi
  local id
  id="$(gh api "repos/${REPO}/releases/tags/${tag}" --jq .id)"
  py patch-json --body-file "$notes" --title "$title" --out "$WORKDIR/legacy.json"
  gh api --method PATCH "repos/${REPO}/releases/${id}" --input "$WORKDIR/legacy.json" >/dev/null
}

ensure_release
upload_assets "$@"
delete_renamed_assets
update_notes
update_legacy_notes
echo "Published $PLATFORM on ${TITLE}."
