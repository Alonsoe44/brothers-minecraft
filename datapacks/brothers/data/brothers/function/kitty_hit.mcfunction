# Runs as the player who hit Kitty. Makes the Kitty that just got hit hop.
advancement revoke @s only brothers:hit_kitty
execute as @e[type=minecraft:cat,tag=kitty,distance=..8,nbt=!{HurtTime:0s}] at @s run function brothers:kitty_hop
