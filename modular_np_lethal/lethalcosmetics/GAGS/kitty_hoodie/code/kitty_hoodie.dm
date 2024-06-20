/obj/item/clothing/suit/hooded/lethal_kitty_hoodie
	name = "disconcertingly twee hoodie"
	desc = "A design that originates in cheap novelty clothing, but this time made in a high quality sweatshirt fleece. The \
	way the ears were cut and sewn makes them stand up in a striking and sculptural way, which helps a playful design look \
	a little more sophisticated. This one is pleasantly scented."
	icon_state = "kitty_hoodie"
	greyscale_config = /datum/greyscale_config/kitty_hoodie
	greyscale_config_worn = /datum/greyscale_config/kitty_hoodie/worn
	greyscale_colors = "#666633"
	flags_1 = IS_PLAYER_COLORABLE_1
	slot_flags = ITEM_SLOT_OCLOTHING|ITEM_SLOT_NECK
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	armor_type = /datum/armor/hooded_wintercoat
	hood_down_overlay_suffix = "_hood"
	hoodtype = /obj/item/clothing/head/hooded/lethal_kitty_hood

/obj/item/clothing/suit/hooded/lethal_kitty_hoodie/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/flashlight,
		/obj/item/lighter,
		/obj/item/modular_computer/pda,
		/obj/item/radio,
		/obj/item/storage/bag/books,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tank/internals/emergency_oxygen,
		/obj/item/tank/internals/plasmaman,
		/obj/item/toy,
	)


/obj/item/clothing/suit/hooded/lethal_kitty_hoodie/set_greyscale(list/colors, new_config, new_worn_config)
	. = ..()
	if(!hood)
		return
	var/list/coat_colors = SSgreyscale.ParseColorString(greyscale_colors)
	var/list/new_coat_colors = coat_colors.Copy(1)
	hood.set_greyscale(new_coat_colors)
	hood.update_slot_icon()

/obj/item/clothing/suit/hooded/lethal_kitty_hoodie/on_hood_created(obj/item/clothing/head/hooded/hood)
	. = ..()
	var/list/coat_colors = (SSgreyscale.ParseColorString(greyscale_colors))
	var/list/new_coat_colors = coat_colors.Copy(1)
	hood.set_greyscale(new_coat_colors) //Adopt the suit's grayscale coloring for visual clarity.

/obj/item/clothing/head/hooded/lethal_kitty_hood
	name = "disconcertingly twee hood"
	desc = "It makes you look smaller and cuter, but it takes a bold personality to wear it outside."
	greyscale_config = /datum/greyscale_config/kitty_hood
	greyscale_config_worn = /datum/greyscale_config/kitty_hood/worn
