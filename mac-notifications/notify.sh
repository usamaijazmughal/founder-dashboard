#!/bin/zsh
# Founder Dashboard — daily nudge (macOS only, optional)
# Usage: notify.sh [morning|evening]
# Fires a native macOS notification. No dependencies (uses osascript).
emulate -L zsh

SCRIPT_DIR=${0:A:h}
SLOT="${1:-morning}"
TITLE="Not Lost. Building."

typeset -a MORNING EVENING
MORNING=(
  "What's the one thing that would make today a win? Open your dashboard."
  "You didn't come this far to only come this far. Set today's move."
  "Founders act before they feel ready. Pick today's one thing."
  "Five years from now starts with today. Open the dashboard."
  "Small is fine. Zero is not. What's today's win?"
  "Your future company is built on ordinary days like this one."
  "The gap wasn't wasted — it was training. Go build."
  "Don't break the chain. One thing today."
  "Employee by day is fine. Do one founder-thing before you clock in."
)
EVENING=(
  "Did you move it forward today? Log it before you sleep."
  "What did you learn today? One line in the dashboard."
  "Close the loop — mark today done, or note honestly why not."
  "Even a small win counts. Log it so tomorrow-you can see it."
  "How did today go? Your dashboard is waiting for one sentence."
  "Progress only compounds if you track it. Log today."
  "Keep the streak alive. Thirty seconds, then rest."
  "One honest line about today. Then you're done."
  "Tomorrow's momentum is decided by whether you log tonight."
)

if [[ "$SLOT" == "evening" ]]; then
  set -A ARR "${EVENING[@]}"
else
  set -A ARR "${MORNING[@]}"
fi

N=${#ARR[@]}
DOY=$(date +%j)
IDX=$(( (10#$DOY % N) + 1 ))   # zsh arrays are 1-indexed
MSG="${ARR[$IDX]}"
MSG=${MSG//\"/\\\"}            # escape quotes for AppleScript

/usr/bin/osascript -e "display notification \"$MSG\" with title \"$TITLE\" sound name \"Ping\"" 2>>"$SCRIPT_DIR/notify.log"
