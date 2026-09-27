# Summons Kitty: a black-and-white (tuxedo) cat that belongs to whoever runs this.
summon minecraft:cat ~ ~ ~ {variant:"minecraft:black",CustomName:{text:"Kitty",color:"light_purple"},CustomNameVisible:1b,PersistenceRequired:1b,CollarColor:6b,Tags:["kitty","kitty_new"],active_effects:[{id:"minecraft:resistance",amplifier:4b,duration:-1,show_particles:0b}]}
data modify entity @e[type=minecraft:cat,tag=kitty_new,limit=1] Owner set from entity @s UUID
tag @e[type=minecraft:cat,tag=kitty_new] remove kitty_new
particle minecraft:heart ~ ~1 ~ 0.4 0.4 0.4 0 8
