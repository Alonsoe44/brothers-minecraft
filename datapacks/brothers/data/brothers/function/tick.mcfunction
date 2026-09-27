# Runs 20 times per second.

# --- Sky Sword: sneak while holding it to launch into the sky ---
scoreboard players remove @a[scores={brothers.cooldown=1..}] brothers.cooldown 1
execute as @a[predicate=brothers:is_sneaking] if items entity @s weapon.mainhand *[minecraft:custom_data~{sky_sword:1b}] unless score @s brothers.cooldown matches 1.. run function brothers:sky_launch

# --- Diamond Chicken: about once every 30 seconds it lays a diamond ---
execute as @e[type=minecraft:chicken,tag=diamond_chicken] at @s if predicate brothers:chance_1_in_600 run function brothers:lay_diamond

# --- Kitty: never stays sitting, so Kitty always follows its owner ---
execute as @e[type=minecraft:cat,tag=kitty,nbt={Sitting:1b}] run data modify entity @s Sitting set value 0b
