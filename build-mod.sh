#!/bin/zsh
# Compiles the Fabric mod in brothers-mod/. Restart the server afterwards (./start.sh copies the jar in).
# Also refreshes client-mods/: the jars both players put in their own Minecraft "mods" folder.
ROOT="$(cd "$(dirname "$0")" && pwd)"
export JAVA_HOME="$(ls -d "$ROOT"/runtime/jdk-*/Contents/Home | head -1)"
cd "$ROOT/brothers-mod" && ./gradlew build --console=plain || exit 1

mkdir -p "$ROOT/client-mods"
rm -f "$ROOT"/client-mods/*.jar(N)
cp "$ROOT"/server/mods/fabric-api-*.jar "$ROOT/client-mods/"
cp $(ls build/libs/brothersmod-*.jar | grep -v sources) "$ROOT/client-mods/"
echo "\nClient mods ready in client-mods/:" && ls -1 "$ROOT/client-mods"

# Update the synced mod pack (Prism downloads it on every launch once it's pushed to GitHub)
rm -f "$ROOT"/modpack/mods/brothersmod-*.jar(N)
cp $(ls build/libs/brothersmod-*.jar | grep -v sources) "$ROOT/modpack/mods/"
cd "$ROOT/modpack" && "$ROOT/tools/packwiz" refresh >/dev/null && echo "Mod pack updated. Run ./publish.sh to send it to your brother."
