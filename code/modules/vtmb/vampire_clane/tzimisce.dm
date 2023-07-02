/datum/vampireclane/tzimisce
	name = "Tzimisce"
	desc = "If someone were to call a Tzimisce inhuman and sadistic, the Tzimisce would probably commend them for their perspicacity, and then demonstrate that their mortal definition of sadism was laughably inadequate. The Tzimisce have left the human condition behind gladly, and now focus on transcending the limitations of the vampiric state. At a casual glance or a brief conversation, a Tzimisce appears to be one of the more pleasant vampires. Polite, intelligent, and inquisitive, they seem a stark contrast to the howling Sabbat mobs or even the apparently more humane Brujah or Nosferatu. However, upon closer inspection, it becomes clear that this is merely a mask hiding something alien and monstrous."
	curse = "Grounded to material domain."
	alt_sprite = "tzi"
	no_hair = TRUE
	no_facial = TRUE
	clane_disciplines = list(/datum/discipline/auspex = 1,
														/datum/discipline/dominate = 2,
														/datum/discipline/vicissitude = 3)
	violating_appearance = TRUE
	male_clothes = "/obj/item/clothing/under/vampire/sport"
	female_clothes = "/obj/item/clothing/under/vampire/red"

/datum/vampireclane/tzimisce/on_gain(mob/living/carbon/human/H)
	..()
	H.add_quirk(/datum/quirk/ground_heirloom)
	H.teach_crafting_recipe(/datum/crafting_recipe/skeleton_key)
	faction |= "Tzimisce"

/obj/item/ground_heir
	name = "bag of ground"
	desc = "Boghatyrskaya sila taitsa zdies'..."
	icon_state = "dirt"
	icon = 'code/modules/ziggers/icons.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	w_class = WEIGHT_CLASS_SMALL

/datum/material/flesh
	name = "flesh"
	desc = "What the fuck..."
	color = "#948369"
	categories = list(MAT_CATEGORY_RIGID = TRUE, MAT_CATEGORY_BASE_RECIPES = FALSE, MAT_CATEGORY_ITEM_MATERIAL = TRUE)
	sheet_type = /obj/item/stack/sheet/human_flesh
	value_per_unit = 0.05
	beauty_modifier = 0.1
	strength_modifier = 0.7
	armor_modifiers = list(MELEE = 0.3, BULLET = 0.3, LASER = 1.2, ENERGY = 1.2, BOMB = 0.3, BIO = 0, RAD = 0.7, FIRE = 1, ACID = 1)
	item_sound_override = 'sound/effects/meatslap.ogg'
	turf_sound_override = FOOTSTEP_MEAT
	texture_layer_icon_state = "human"

/datum/material/flesh/on_removed(atom/source, amount, material_flags)
	. = ..()
	qdel(source.GetComponent(/datum/component/edible))

/datum/material/flesh/on_applied_obj(obj/O, amount, material_flags)
	. = ..()
	make_edible(O, amount, material_flags)

/datum/material/flesh/on_applied_turf(turf/T, amount, material_flags)
	. = ..()
	make_edible(T, amount, material_flags)

/datum/material/flesh/proc/make_edible(atom/source, amount, material_flags)
	var/nutriment_count = 3 * (amount / MINERAL_MATERIAL_AMOUNT)
	var/oil_count = 2 * (amount / MINERAL_MATERIAL_AMOUNT)
	source.AddComponent(/datum/component/edible, list(/datum/reagent/consumable/nutriment = nutriment_count, /datum/reagent/consumable/cooking_oil = oil_count), null, GROSS | MEAT, null, 30, list("flesh", "meat"))

/obj/item/stack/sheet/human_flesh
	name = "human flesh"
	desc = "What the fuck..."
	singular_name = "human flesh"
	icon_state = "human"
	mats_per_unit = list(/datum/material/pizza = MINERAL_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/sheet/human_flesh
	material_type = /datum/material/flesh
	material_modifier = 1

/obj/item/stack/sheet/human_flesh/fifty
	amount = 50
/obj/item/stack/sheet/human_flesh/twenty
	amount = 20
/obj/item/stack/sheet/human_flesh/ten
	amount = 10
/obj/item/stack/sheet/human_flesh/five
	amount = 5