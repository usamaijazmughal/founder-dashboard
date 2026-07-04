#!/bin/zsh
# Turn off the Mac nudges and remove the LaunchAgents.
emulate -L zsh
LA="$HOME/Library/LaunchAgents"
for slot in morning evening; do
  label="com.usama.founderdashboard.$slot"
  launchctl unload -w "$LA/$label.plist" 2>/dev/null || true
  rm -f "$LA/$label.plist"
  echo "removed $label"
done
echo "Mac nudges are off."
