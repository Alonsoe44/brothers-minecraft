# Brothers' Minecraft Server

Two brothers play on this server. One brother is the game designer (describes absurd ideas); Claude does the engineering.
Keep explanations short and fun, and get ideas into the game fast.

## Versions (verified 2026-09-27; don't use older APIs from memory)
- Minecraft Java **26.3** (data pack format 121, resource pack format 97)
- Fabric Loader 0.19.5, Fabric API 0.161.0+26.3, Loom 1.18-SNAPSHOT
- Java 25 — portable JDK in `runtime/` (the system Java is 17 and too old; always use the one in `runtime/`)
- Minecraft 26.x ships **unobfuscated** with official Mojang names (`Identifier`, `net.minecraft.world.item.Item`, etc.). No Yarn mappings, no remapping.
- Predicates/loot conditions use `"type"` (not `"condition"`), and entity sub-predicates are namespaced: `"predicate": {"minecraft:flags": {"is_sneaking": true}}`. When unsure of a format, check vanilla files in `server/versions/26.3/server-26.3.jar` (`data/minecraft/...`) instead of guessing.
- Java API gotchas in 26.3: entity types live in `EntityTypes` (not `EntityType`), `Entity.snapTo` replaces `moveTo`, `Item.use` returns `InteractionResult`, entity data such as cat variant is set with `entity.setComponent(DataComponents.X, ...)`. Verify signatures with `javap` against `~/.gradle/caches/fabric-loom/minecraftMaven/net/minecraft/minecraft-common-deobf/26.3/*.jar` before writing code.
- Mod updates reach players via packwiz: `modpack/` (on GitHub Alonsoe44/brothers-minecraft) is downloaded by each Prism instance on launch. Flow: `./build-mod.sh` → `./publish.sh "msg"` → restart server.
- Mod items tagged `kitty` share behavior with the datapack (hop when hit, never sit). `build-mod.sh` refreshes `client-mods/` (jars each player installs).
- Item data uses **components** (`item[minecraft:custom_data={...}]`), text is SNBT (`{text:"Hi",color:"aqua"}`), not JSON strings or old NBT tags.

## Layout
- `server/` — Fabric server. `server/mods/` holds server mods. The world is `server/world/`.
- `datapacks/<name>/` — datapack sources. `start.sh` syncs them into `server/world/datapacks/` (anything edited directly there is overwritten).
- `brothers-mod/` — Fabric mod (mod id `brothersmod`, package `com.brothers`). Split source sets: `src/main` (common/server), `src/client` (client-only).
- `start.sh` — accepts EULA once, syncs datapacks + mod jar, launches the server (4 GB RAM).
- `build-mod.sh` — builds the mod with the bundled JDK.

## Workflow: "invent an item"
1. **Prefer a datapack** (functions, predicates, advancements, custom item components). No client install needed, changes apply with `/reload` in-game after running the sync (restart with `./start.sh`, or copy the pack into `server/world/datapacks/` and `/reload`).
2. **Use the mod** only when a datapack can't do it (new blocks/items with textures, new entities, custom behavior in Java). Remember: a mod that adds items/blocks must also be installed on **both players' clients** (Fabric Loader + Fabric API + brothersmod jar), with matching versions.
3. After building, test: start the server, run the give/summon function, check `server/logs/latest.log` for errors.

Every datapack feature should have a `give_*` or `summon_*` function so it's easy to try: `/function brothers:give_sky_sword`.
