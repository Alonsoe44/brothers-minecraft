#!/bin/zsh
# Builds prism/BrothersPack.zip: a Prism Launcher instance that auto-downloads the mod pack from GitHub on every launch.
# Import it in Prism: Add Instance -> Import -> pick the zip. Only needs to be done once per computer.
ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"
REMOTE=$(git remote get-url origin 2>/dev/null) || { echo "No GitHub remote yet."; exit 1; }
REPO=$(echo "$REMOTE" | sed -E 's#(git@github.com:|https://github.com/)##; s#\.git$##')
PACK_URL="https://raw.githubusercontent.com/$REPO/main/modpack/pack.toml"

TMP=$(mktemp -d)
mkdir -p "$TMP/minecraft"
cp prism/packwiz-installer-bootstrap.jar "$TMP/minecraft/"
cat > "$TMP/instance.cfg" <<CFG
InstanceType=OneSix
name=Brothers Pack
OverrideCommands=true
PreLaunchCommand="\$INST_JAVA" -jar packwiz-installer-bootstrap.jar $PACK_URL
CFG
cat > "$TMP/mmc-pack.json" <<JSON
{
  "formatVersion": 1,
  "components": [
    { "uid": "net.minecraft", "version": "26.3", "important": true },
    { "uid": "net.fabricmc.fabric-loader", "version": "0.19.5" }
  ]
}
JSON
rm -f prism/BrothersPack.zip
(cd "$TMP" && zip -qr "$ROOT/prism/BrothersPack.zip" .)
rm -rf "$TMP"
echo "Created prism/BrothersPack.zip (pack URL: $PACK_URL)"
