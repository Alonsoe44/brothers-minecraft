package com.brothers.item;

import net.minecraft.ChatFormatting;
import net.minecraft.core.component.DataComponents;
import net.minecraft.core.registries.Registries;
import net.minecraft.network.chat.Component;
import net.minecraft.server.level.ServerLevel;
import net.minecraft.world.InteractionHand;
import net.minecraft.world.InteractionResult;
import net.minecraft.world.effect.MobEffectInstance;
import net.minecraft.world.effect.MobEffects;
import net.minecraft.world.entity.EntitySpawnReason;
import net.minecraft.world.entity.EntityTypes;
import net.minecraft.world.entity.LightningBolt;
import net.minecraft.world.entity.animal.feline.Cat;
import net.minecraft.world.entity.animal.feline.CatVariants;
import net.minecraft.world.entity.player.Player;
import net.minecraft.world.item.DyeColor;
import net.minecraft.world.item.Item;
import net.minecraft.world.level.Level;
import net.minecraft.world.phys.Vec3;

import java.util.List;

/**
 * Right-click to summon your Kitty with a lightning strike. Right-click again to send Kitty away.
 * Kitty gets the "kitty" tag, so the datapack's hop-when-hit and always-follow rules apply to it too.
 */
public class YogurtDeFresaItem extends Item {
	public static final String KITTY_TAG = "kitty";
	private static final int COOLDOWN_TICKS = 20;
	private static final double SEARCH_RADIUS = 128;

	public YogurtDeFresaItem(Properties properties) {
		super(properties);
	}

	@Override
	public InteractionResult use(Level level, Player player, InteractionHand hand) {
		if (level instanceof ServerLevel serverLevel) {
			List<Cat> kitties = serverLevel.getEntitiesOfClass(Cat.class, player.getBoundingBox().inflate(SEARCH_RADIUS),
					cat -> cat.entityTags().contains(KITTY_TAG) && cat.isOwnedBy(player));

			if (kitties.isEmpty()) {
				Vec3 look = player.getLookAngle();
				Vec3 pos = player.position().add(look.x * 2, 0, look.z * 2);
				strikeLightning(serverLevel, pos);
				summonKitty(serverLevel, player, pos);
				player.sendOverlayMessage(Component.literal("¡Kitty ha llegado!").withStyle(ChatFormatting.LIGHT_PURPLE));
			} else {
				for (Cat kitty : kitties) {
					strikeLightning(serverLevel, kitty.position());
					kitty.discard();
				}
				player.sendOverlayMessage(Component.literal("¡Adiós, Kitty!").withStyle(ChatFormatting.LIGHT_PURPLE));
			}
			player.getCooldowns().addCooldown(player.getItemInHand(hand), COOLDOWN_TICKS);
		}
		return InteractionResult.SUCCESS;
	}

	private static void strikeLightning(ServerLevel level, Vec3 pos) {
		LightningBolt bolt = EntityTypes.LIGHTNING_BOLT.create(level, EntitySpawnReason.MOB_SUMMONED);
		if (bolt == null) return;
		bolt.setVisualOnly(true); // all the flash and thunder, no fire or damage
		bolt.snapTo(pos);
		level.addFreshEntity(bolt);
	}

	private static void summonKitty(ServerLevel level, Player player, Vec3 pos) {
		Cat kitty = EntityTypes.CAT.create(level, EntitySpawnReason.MOB_SUMMONED);
		if (kitty == null) return;
		kitty.snapTo(pos.x, pos.y, pos.z, player.getYRot(), 0);
		kitty.setComponent(DataComponents.CAT_VARIANT,
				level.registryAccess().lookupOrThrow(Registries.CAT_VARIANT).getOrThrow(CatVariants.BLACK));
		kitty.setComponent(DataComponents.CAT_COLLAR, DyeColor.PINK);
		kitty.tame(player);
		kitty.setCustomName(Component.literal("Kitty").withStyle(ChatFormatting.LIGHT_PURPLE));
		kitty.setCustomNameVisible(true);
		kitty.setPersistenceRequired();
		kitty.addTag(KITTY_TAG);
		kitty.addEffect(new MobEffectInstance(MobEffects.RESISTANCE, -1, 4, false, false));
		level.addFreshEntity(kitty);
	}
}
