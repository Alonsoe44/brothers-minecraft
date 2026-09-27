package com.brothers.item;

import com.brothers.BrothersMod;
import net.fabricmc.fabric.api.creativetab.v1.CreativeModeTabEvents;
import net.minecraft.core.Registry;
import net.minecraft.core.registries.BuiltInRegistries;
import net.minecraft.core.registries.Registries;
import net.minecraft.resources.Identifier;
import net.minecraft.resources.ResourceKey;
import net.minecraft.world.item.CreativeModeTab;
import net.minecraft.world.item.Item;
import net.minecraft.world.item.Rarity;

import java.util.function.Function;

public final class ModItems {
	public static final Item YOGURT_DE_FRESA = register("yogurt_de_fresa", YogurtDeFresaItem::new,
			new Item.Properties().stacksTo(1).rarity(Rarity.UNCOMMON));

	private static final ResourceKey<CreativeModeTab> FOOD_AND_DRINKS =
			ResourceKey.create(Registries.CREATIVE_MODE_TAB, Identifier.withDefaultNamespace("food_and_drinks"));

	private ModItems() {
	}

	private static Item register(String name, Function<Item.Properties, Item> factory, Item.Properties properties) {
		ResourceKey<Item> key = ResourceKey.create(Registries.ITEM, BrothersMod.id(name));
		return Registry.register(BuiltInRegistries.ITEM, key, factory.apply(properties.setId(key)));
	}

	public static void init() {
		CreativeModeTabEvents.modifyOutputEvent(FOOD_AND_DRINKS).register(output -> output.accept(YOGURT_DE_FRESA));
	}
}
