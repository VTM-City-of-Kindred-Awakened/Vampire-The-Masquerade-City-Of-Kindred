/obj/item/melee/vampirearms
	lefthand_file = 'code/modules/ziggers/righthand.dmi'
	righthand_file = 'code/modules/ziggers/lefthand.dmi'
	worn_icon = 'code/modules/ziggers/worn.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'

/obj/item/melee/vampirearms/fireaxe
	icon = 'code/modules/ziggers/48x32weapons.dmi'
	icon_state = "fireaxe0"
	name = "fire axe"
	desc = "Truly, the weapon of a madman. Who would think to fight fire with an axe?"
	force = 5
	throwforce = 25
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BACK
	attack_verb_continuous = list("attacks", "chops", "cleaves", "tears", "lacerates", "cuts")
	attack_verb_simple = list("attack", "chop", "cleave", "tear", "lacerate", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = SHARP_EDGED
	max_integrity = 200
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 30)
	resistance_flags = FIRE_PROOF
	wound_bonus = -15
	bare_wound_bonus = 20
	armour_penetration = 30
	pixel_w = -8
	var/wielded = FALSE

/obj/item/melee/vampirearms/fireaxe/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, .proc/on_wield)
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, .proc/on_unwield)

/obj/item/melee/vampirearms/fireaxe/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 100, 80, 0 , hitsound)
	AddComponent(/datum/component/two_handed, force_unwielded=5, force_wielded=35, icon_wielded="fireaxe1")

/obj/item/melee/vampirearms/fireaxe/proc/on_wield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	wielded = TRUE

/obj/item/melee/vampirearms/fireaxe/proc/on_unwield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	wielded = FALSE

/obj/item/melee/vampirearms/fireaxe/update_icon_state()
	icon_state = "fireaxe0"

/obj/item/melee/vampirearms/fireaxe/afterattack(atom/A, mob/user, proximity)
	. = ..()
	if(!proximity)
		return
	if(wielded)
		if(istype(A, /obj/structure/window) || istype(A, /obj/structure/grille))
			var/obj/structure/W = A
			W.obj_destruction("fireaxe")

/obj/item/melee/vampirearms/katana
	name = "katana"
	desc = "An elegant weapon, its tiny edge is capable of cutting through flesh and bone with ease."
	icon = 'code/modules/ziggers/48x32weapons.dmi'
	icon_state = "katana"
	flags_1 = CONDUCT_1
	force = 45
	throwforce = 10
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_BELT
	block_chance = 50
	armour_penetration = 50
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("slashes", "cuts")
	attack_verb_simple = list("slash", "cut")
	hitsound = 'sound/weapons/rapierhit.ogg'
	wound_bonus = 10
	bare_wound_bonus = 25
	pixel_w = -8
	resistance_flags = FIRE_PROOF

/obj/item/melee/vampirearms/baseball
	name = "baseball bat"
	desc = "There ain't a skull in the league that can withstand a swatter."
	icon = 'code/modules/ziggers/weapons.dmi'
	icon_state = "baseball"
	force = 20
	wound_bonus = -10
	throwforce = 10
	attack_verb_continuous = list("beats", "smacks")
	attack_verb_simple = list("beat", "smack")
	w_class = WEIGHT_CLASS_BULKY

/obj/item/melee/vampirearms/baseball/attack(mob/living/target, mob/living/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		return
	var/atom/throw_target = get_edge_target_turf(target, user.dir)
	if(!target.anchored && !HAS_TRAIT(target, TRAIT_TOUGH_FLESH))
		var/whack_speed = (prob(60) ? 1 : 4)
		target.throw_at(throw_target, rand(1, 2), whack_speed, user)

/obj/item/melee/vampirearms/baseball/hand
	name = "ripped arm"
	desc = "Wow, that was someone's arm."
	icon_state = "hand"
	force = 50

/obj/item/melee/vampirearms/tire
	name = "tire iron"
	desc = "Can be used as a tool or as a weapon."
	icon = 'code/modules/ziggers/weapons.dmi'
	icon_state = "pipe"
	force = 15
	wound_bonus = -10
	throwforce = 10
	attack_verb_continuous = list("beats", "smacks")
	attack_verb_simple = list("beat", "smack")
	w_class = WEIGHT_CLASS_NORMAL
	resistance_flags = FIRE_PROOF

/obj/item/melee/vampirearms/knife
	name = "knife"
	desc = "Don't cut yourself accidentely."
	icon = 'code/modules/ziggers/weapons.dmi'
	icon_state = "knife"
	force = 25
	wound_bonus = -10
	throwforce = 10
	attack_verb_continuous = list("slashes", "cuts")
	attack_verb_simple = list("slash", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	armour_penetration = 20
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_SMALL
	resistance_flags = FIRE_PROOF

/obj/item/melee/vampirearms/chainsaw
	name = "chainsaw"
	desc = "A versatile power tool. Useful for limbing trees and delimbing humans."
	icon = 'code/modules/ziggers/weapons.dmi'
	icon_state = "chainsaw"
	flags_1 = CONDUCT_1
	force = 15
	var/force_on = 55
	w_class = WEIGHT_CLASS_BULKY
	throwforce = 10
	throw_speed = 2
	throw_range = 4
	attack_verb_continuous = list("saws", "tears", "lacerates", "cuts", "chops", "dices")
	attack_verb_simple = list("saw", "tear", "lacerate", "cut", "chop", "dice")
	hitsound = "swing_hit"
	sharpness = SHARP_EDGED
	actions_types = list(/datum/action/item_action/startchainsaw)
	tool_behaviour = TOOL_SAW
	toolspeed = 0.5
	resistance_flags = FIRE_PROOF
	var/on = FALSE
	var/wielded = FALSE

/obj/item/melee/vampirearms/chainsaw/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_TWOHANDED_WIELD, .proc/on_wield)
	RegisterSignal(src, COMSIG_TWOHANDED_UNWIELD, .proc/on_unwield)

/obj/item/melee/vampirearms/chainsaw/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/butchering, 30, 100, 0, 'sound/weapons/chainsawhit.ogg', TRUE)
	AddComponent(/datum/component/two_handed, require_twohands=TRUE)

/obj/item/melee/vampirearms/chainsaw/proc/on_wield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	wielded = TRUE

/obj/item/melee/vampirearms/chainsaw/proc/on_unwield(obj/item/source, mob/user)
	SIGNAL_HANDLER

	wielded = FALSE

/obj/item/melee/vampirearms/chainsaw/attack_self(mob/user)
	on = !on
	to_chat(user, "As you pull the starting cord dangling from [src], [on ? "it begins to whirr." : "the chain stops moving."]")
	force = on ? force_on : initial(force)
	throwforce = on ? force_on : initial(force)
	var/datum/component/butchering/butchering = src.GetComponent(/datum/component/butchering)
	butchering.butchering_enabled = on

	if(on)
		hitsound = 'sound/weapons/chainsawhit.ogg'
	else
		hitsound = "swing_hit"

	if(src == user.get_active_held_item())
		user.update_inv_hands()
	for(var/X in actions)
		var/datum/action/A = X
		A.UpdateButtonIcon()

/obj/item/melee/vampirearms/stake
	name = "stake"
	desc = "Paralyzes blank-bodies if aimed straight to the heart."
	icon = 'code/modules/ziggers/weapons.dmi'
	icon_state = "stake"
	force = 10
	wound_bonus = -10
	throwforce = 10
	attack_verb_continuous = list("pierces", "cuts")
	attack_verb_simple = list("pierce", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	armour_penetration = 50
	sharpness = SHARP_EDGED
	w_class = WEIGHT_CLASS_SMALL

/obj/item/melee/vampirearms/stake/attack(mob/living/target, mob/living/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		return
	if(!target.IsParalyzed() && iskindred(target) && !target.stakeimmune)
		visible_message("<span class='warning'>[user] aims [src] straight to the [target]'s heart!</span>", "<span class='warning'>You aim [src] straight to the [target]'s heart!</span>")
		if(do_after(user, 10, target))
			user.do_attack_animation(target)
			visible_message("<span class='warning'>[user] pierces [target]'s torso!</span>", "<span class='warning'>You pierce [target]'s torso!</span>")
			target.Paralyze(1200)
			qdel(src)

/obj/item/melee/vampirearms/shovel
	icon = 'code/modules/ziggers/weapons.dmi'
	icon_state = "shovel"
	name = "shovel"
	desc = "Great weapon against mortal or immortal."
	force = 15
	throwforce = 10
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("attacks", "chops", "tears", "beats")
	attack_verb_simple = list("attack", "chop", "tear", "beat")
	armor = list(MELEE = 25, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 0, ACID = 0)
	resistance_flags = FIRE_PROOF

/obj/item/melee/vampirearms/shovel/attack(mob/living/target, mob/living/user)
	. = ..()
	if(HAS_TRAIT(user, TRAIT_PACIFISM))
		return
	if(!target.IsStun() && prob(25))
		visible_message("<span class='warning'>[user] bonks [src]'s head!</span>", "<span class='warning'>You bonk[target]'s head!</span>")
		target.Stun(5)
		target.drop_all_held_items()

/obj/item/melee/vampirearms/katana/kosa
	name = "scythe"
	desc = "More instrument, than a weapon. Instrumentally cuts heads..."
	icon = 'code/modules/ziggers/weapons.dmi'
	icon_state = "kosa"
	force = 35
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = null
	block_chance = 30
	armour_penetration = 20
	sharpness = SHARP_EDGED
	attack_verb_continuous = list("slashes", "cuts")
	attack_verb_simple = list("slash", "cut")
	hitsound = 'sound/weapons/rapierhit.ogg'
	wound_bonus = 5
	bare_wound_bonus = 10
	resistance_flags = FIRE_PROOF

/obj/item/melee/vampirearms/katana/kosa/egorium
	name = "demonic scythe"
	icon_state = "egorium"
	force = 45

/obj/item/melee/vampirearms/katana/kosa/egorium/Initialize()
	. = ..()
	set_light(3, 2, "#ff0000")