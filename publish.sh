#!/bin/zsh
# Sends the latest mod pack (and all project changes) to GitHub.
# Both players' Prism instances download the update the next time they press Play.
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"
git add -A
git commit -m "${1:-Update mod pack}" || { echo "Nothing new to publish."; exit 0; }
git push && echo "Published! Restart the server (stop, then ./start.sh) and both of you relaunch Prism."
