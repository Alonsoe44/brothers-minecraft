effect give @s minecraft:levitation 1 40 true
effect give @s minecraft:slow_falling 12 0 true
playsound minecraft:entity.firework_rocket.launch player @a ~ ~ ~ 1 1
particle minecraft:cloud ~ ~ ~ 0.5 0.1 0.5 0.1 40
scoreboard players set @s brothers.cooldown 60
