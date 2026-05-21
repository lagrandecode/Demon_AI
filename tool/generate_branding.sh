#!/usr/bin/env bash
# Generates all launcher, splash, and notification assets from assets/images/logo.png
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LOGO="$ROOT/assets/images/logo.png"
SPLASH="$ROOT/assets/images/logo_splash.png"

if [[ ! -f "$LOGO" ]]; then
  echo "Missing logo at $LOGO"
  exit 1
fi

echo "→ Scaling logo.png for native splash (288×288)…"
sips -z 288 288 "$LOGO" --out "$SPLASH" >/dev/null

echo "→ Generating Android notification icons (ic_notification)…"
generate_notification() {
  local dpi="$1"
  local size="$2"
  local dir="$ROOT/android/app/src/main/res/drawable-${dpi}"
  mkdir -p "$dir"
  sips -z "$size" "$size" "$LOGO" --out "$dir/ic_notification.png" >/dev/null
}

generate_notification mdpi 24
generate_notification hdpi 36
generate_notification xhdpi 48
generate_notification xxhdpi 72
generate_notification xxxhdpi 96

cd "$ROOT"
echo "→ flutter pub get"
flutter pub get

echo "→ App launcher icons (Android mipmap + iOS AppIcon + web/macos/windows)"
dart run flutter_launcher_icons

echo "→ Native splash screens (Android + iOS + web)"
dart run flutter_native_splash:create

echo "✅ Branding generated from assets/images/logo.png"
