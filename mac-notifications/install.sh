#!/bin/zsh
# Enable Mac morning/evening nudges. Optional — macOS only.
# Usage: ./install.sh [morningHour] [eveningHour]   (defaults: 9 and 20)
emulate -L zsh
set -e

DIR=${0:A:h}
MH="${1:-9}"
EH="${2:-20}"
LA="$HOME/Library/LaunchAgents"
mkdir -p "$LA"

make_plist () {
  local slot="$1" hour="$2"
  local label="com.usama.founderdashboard.$slot"
  cat > "$LA/$label.plist" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key><string>$label</string>
  <key>ProgramArguments</key>
  <array>
    <string>/bin/zsh</string>
    <string>$DIR/notify.sh</string>
    <string>$slot</string>
  </array>
  <key>StartCalendarInterval</key>
  <dict><key>Hour</key><integer>$hour</integer><key>Minute</key><integer>0</integer></dict>
  <key>StandardOutPath</key><string>$DIR/launchd.log</string>
  <key>StandardErrorPath</key><string>$DIR/launchd.log</string>
</dict>
</plist>
PLIST
  launchctl unload -w "$LA/$label.plist" 2>/dev/null || true
  launchctl load  -w "$LA/$label.plist"
  echo "  loaded $label (fires at ${hour}:00)"
}

chmod +x "$DIR/notify.sh"
echo "Installing Founder Dashboard nudges..."
make_plist morning "$MH"
make_plist evening "$EH"
echo ""
echo "Done. Firing a test notification now — you should see one appear."
/bin/zsh "$DIR/notify.sh" morning
echo ""
echo "If nothing appeared: open System Settings > Notifications, find 'Script Editor'"
echo "(or 'osascript'), and allow notifications. Then it'll work on schedule."
echo "To change times: ./install.sh 8 21   (8am and 9pm).  To turn off: ./uninstall.sh"
