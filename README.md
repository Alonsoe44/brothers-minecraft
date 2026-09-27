# The Brothers' Server

Minecraft Java **26.3** + Fabric, running on this Mac.

## Start the server
```
./start.sh
```
The first time, it asks you to accept the Minecraft EULA. Stop the server by typing `stop` in its window.

Then, in the server window, add both of you (only whitelisted players can join) and make yourselves admins:
```
whitelist add YourName
whitelist add BrotherName
op YourName
op BrotherName
```

## How your brother joins
In Minecraft: **Multiplayer → Add Server**, with this address:

| Where is he?              | Address                                                     |
|---------------------------|-------------------------------------------------------------|
| You (same Mac)            | `localhost`                                                 |
| Same Wi‑Fi / same house   | `192.168.0.15` (this Mac's IP — can change after a restart) |
| Different house           | Use a free tunnel: [playit.gg](https://playit.gg) (easiest) or [Tailscale](https://tailscale.com) (both of you install it, then use the Tailscale IP) |

Both of you need Minecraft **Java Edition 26.3**.

## Try the demo items (datapack, works in the normal game)
- `/function brothers:give_sky_sword` — sneak while holding it to launch into the sky
- `/function brothers:summon_diamond_chicken` — a chicken that lays diamonds
- `/function brothers:summon_kitty` — Kitty, a black-and-white cat that follows whoever summoned it and hops when you hit it (it never gets hurt)

## Mod items (you both need the mod installed, see below)
- **Yogurt de Fresa**: `/give @s brothersmod:yogurt_de_fresa`, or craft it (milk bucket + sweet berries + sugar + bowl). Right-click to summon your Kitty with a lightning strike; right-click again to send Kitty away.

## Installing the mod in your Minecraft (both of you, once)
1. Download the Fabric installer from https://fabricmc.net/use/installer/ and run it. Pick **Client**, Minecraft **26.3**, then Install.
2. Open your Minecraft `mods` folder (create it if missing):
   - Mac: `~/Library/Application Support/minecraft/mods`
   - Windows: press Win+R, type `%appdata%\.minecraft\mods`
3. Copy both jars from this project's `client-mods/` folder into it.
4. In the Minecraft Launcher, pick the **fabric-loader-26.3** profile and press Play.

Every time the mod changes, copy the new `client-mods/brothersmod-*.jar` over the old one (on both computers).

## Making new stuff with Claude
Your brother describes an idea, you tell Claude Code, and Claude builds it.

- **Datapacks** (`datapacks/brothers/`): most ideas. No installs on your computers. After a change, type `/reload` in-game (or restart the server).
- **Mod** (`brothers-mod/`): for new blocks, textures, or mobs. Build it with `./build-mod.sh`, then restart. Both of you then need the [Fabric Loader](https://fabricmc.net/use/installer/) for 26.3 on your Minecraft, with Fabric API and `brothersmod-*.jar` in your `mods` folder.

If something breaks, paste the error from the chat or `server/logs/latest.log` to Claude, or send it a screenshot.
