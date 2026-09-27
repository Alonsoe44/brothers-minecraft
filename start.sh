#!/bin/zsh
# Starts the Fabric Minecraft server (26.3) with the bundled Java 25.
# Before starting, it copies our datapacks and our mod into the server.
ROOT="$(cd "$(dirname "$0")" && pwd)"
JAVA="$(ls -d "$ROOT"/runtime/jdk-*/Contents/Home/bin/java | head -1)"
cd "$ROOT/server"

if ! grep -qs "eula=true" eula.txt; then
  echo "Minecraft requires you to accept the EULA: https://aka.ms/MinecraftEULA"
  read "ans?Do you accept it? (yes/no) "
  [[ "$ans" == "yes" ]] || { echo "Not starting."; exit 1; }
  echo "eula=true" > eula.txt
fi

# Sync our datapacks (edit them in ../datapacks, never in world/datapacks)
mkdir -p world/datapacks
for pack in "$ROOT"/datapacks/*(/N); do
  rsync -a --delete "$pack/" "world/datapacks/${pack:t}/"
done

# Install our latest mod build, if one exists
MOD_JAR=$(ls "$ROOT"/brothers-mod/build/libs/brothersmod-*.jar 2>/dev/null | grep -v sources | head -1)
if [[ -n "$MOD_JAR" ]]; then
  rm -f mods/brothersmod-*.jar(N)
  cp "$MOD_JAR" mods/
fi

exec "$JAVA" -Xms2G -Xmx4G -jar fabric-server-launch.jar nogui
