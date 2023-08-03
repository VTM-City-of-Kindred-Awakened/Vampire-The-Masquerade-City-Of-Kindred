/*
Experienced Driver
Bone Key
Anonymous
Bloody Lover
Tough Flesh
Slowpoke
\"Blood\" Sucker
One Handed
Non Intellectual
Coffin Therapy
Not Crossing the Rubicon
Hungry
Fenix
Dwarf
Homosexual
Dancer
*/

/datum/quirk/experienced_driver
	name = "Experienced Driver"
	desc = "Driving, repairing and sustaining a car is much easier to you."
	mob_trait = TRAIT_EXP_DRIVER
	value = 2
	gain_text = "<span class='notice'>You feel more experienced about cars.</span>"
	lose_text = "<span class='warning'>You feel more clueless about cars.</span>"

/datum/quirk/bone_key
	name = "Bone Key"
	desc = "You know much more about door locks, and always have a tool for them."
	mob_trait = TRAIT_BONE_KEY
	value = 3
	gain_text = "<span class='notice'>You feel more experienced in lockery.</span>"
	lose_text = "<span class='warning'>You feel more clueless in lockery.</span>"

/datum/quirk/annonymus
	name = "Anonymous"
	desc = "You always bring a mask."
	value = 1
	gain_text = "<span class='notice'>You feel more anonymus.</span>"
	lose_text = "<span class='warning'>You don't feel anonymous anymore.</span>"

/datum/quirk/annonymus/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	H.equip_to_slot_or_del(new /obj/item/clothing/mask/vampire/balaclava(H), ITEM_SLOT_MASK)

/datum/quirk/bloody_lover
	name = "Bloody Lover"
	desc = "Your bites feel more like a kiss."
	mob_trait = TRAIT_BLOODY_LOVER
	value = 2
	gain_text = "<span class='notice'>You feel more experienced in love.</span>"
	lose_text = "<span class='warning'>You feel more clueless in love.</span>"

/datum/quirk/tough_flesh
	name = "Tough Flesh"
	desc = "Your flesh is much sturdier than normal. You are much better in resisting stuns, bumps and hits."
	mob_trait = TRAIT_TOUGH_FLESH
	value = 3
	gain_text = "<span class='notice'>You feel tough.</span>"
	lose_text = "<span class='warning'>You feel fragile again.</span>"

/datum/movespeed_modifier/slowpoke
	multiplicative_slowdown = 1

/datum/quirk/slowpoke
	name = "Slowpoke"
	desc = "You move slower."
	value = -3
	gain_text = "<span class='warning'>You feel slo-o-o-o-o-o-o-o-o-o-o-o-ow.</span>"
	lose_text = "<span class='notice'>You can feel a normal speed again.</span>"

/datum/quirk/slowpoke/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	H.add_movespeed_modifier(/datum/movespeed_modifier/slowpoke)

/datum/quirk/bloody_sucker
	name = "Addicted"
	desc = "You just can't stop sucking, before your victim dies."
	mob_trait = TRAIT_BLOODY_SUCKER
	value = -2
	gain_text = "<span class='warning'>You feel anxious about the way you feed.</span>"
	lose_text = "<span class='warning'>You can feed normal again.</span>"

/datum/quirk/lazy
	name = "Lazy"
	desc = "You do things much more slowly than others."
	mob_trait = TRAIT_LAZY
	value = -2
	gain_text = "<span class='warning'>You feel anxious about the way you feed.</span>"
	lose_text = "<span class='warning'>You can feed normal again.</span>"

/datum/quirk/one_hand
	name = "One Handed"
	desc = "You've lost an arm before the embrace, and it's still unhealed."
	value = -3
	gain_text = "<span class='warning'>You don't feel one of your arms.</span>"
	lose_text = "<span class='notice'>You feel both of your arms again.</span>"

/datum/quirk/one_hand/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/obj/item/bodypart/B1 = H.get_bodypart(BODY_ZONE_R_ARM)
	var/obj/item/bodypart/B2 = H.get_bodypart(BODY_ZONE_L_ARM)
	if(prob(50))
		B1.drop_limb()
		qdel(B1)
	else
		B2.drop_limb()
		qdel(B2)

/datum/quirk/non_int
	name = "Non Intellectual"
	desc = "You are far more special than other beings from your kind, so you gain experience slower."
	mob_trait = TRAIT_NON_INT
	value = -5
	gain_text = "<span class='warning'>You feel dumb.</span>"
	lose_text = "<span class='notice'>You don't feel dumb anymore.</span>"

/datum/quirk/coffin_therapy
	name = "Coffin Therapy"
	desc = "Your wounds heal only in a coffin."
	mob_trait = TRAIT_COFFIN_THERAPY
	value = -2
	gain_text = "<span class='warning'>You feel like you need a coffin.</span>"
	lose_text = "<span class='notice'>You don't need a coffin anymore.</span>"

/datum/quirk/rubicon
	name = "Crossing the Rubicon"
	desc = "You are afraid of water, so you can't cross it."
	mob_trait = TRAIT_RUBICON
	value = -1
	gain_text = "<span class='warning'>You feel afraid of water.</span>"
	lose_text = "<span class='notice'>You aren't afraid of water anymore.</span>"

/datum/quirk/hungry
	name = "Hungry"
	desc = "You need more food to feed your hunger."
	mob_trait = TRAIT_HUNGRY
	value = -3
	gain_text = "<span class='warning'>You feel extra <b>HUNGRY</b>.</span>"
	lose_text = "<span class='notice'>You don't feel extra <b>HUNGRY</b> anymore.</span>"

/datum/quirk/phoenix
	name = "Phoenix"
	desc = "You don't loose gained experience after the Final Death."
	mob_trait = TRAIT_PHOENIX
	value = 5
	gain_text = "<span class='notice'>You feel like you can burn without permanent consequences.</span>"
	lose_text = "<span class='warning'>You don't feel like you can burn without consequences anymore.</span>"

/datum/quirk/acrobatic
	name = "Acrobatic"
	desc = "You know a couple of acrobatic moves."
	value = 3
	gain_text = "<span class='notice'>You feel like you can jump higher.</span>"
	lose_text = "<span class='warning'>Now you aren't as agile as you were.</span>"

/datum/quirk/acrobatic/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/action/acrobate/DA = new()
	DA.Grant(H)

/datum/action/acrobate
	name = "Dodge"
	desc = "Jump over something and dodge a projectile."
	button_icon_state = "acrobate"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	var/last_acrobate = 0

/datum/action/acrobate/Trigger()
	if(last_acrobate+15 > world.time)
		return
	last_acrobate = world.time

	if(!isturf(owner.loc))
		return

	if(owner.pulledby)
		return

	if(isclosedturf(get_step(owner, owner.dir)))
		return

	if(isclosedturf(get_step(get_step(owner, owner.dir), owner.dir)))
		return

	for(var/atom/movable/A in get_step(owner, owner.dir))
		if(istype(A, /obj/structure/vampdoor))
			return
		if(istype(A, /obj/matrix))
			return
		if(istype(A, /obj/structure/window))
			return
		if(istype(A, /turf/open/floor/plating/vampocean))
			return
		if(istype(A, /obj/elevator_door))
			return
		if(istype(A, /obj/machinery/door/poddoor/shutters))
			return

	for(var/atom/movable/A in get_step(get_step(owner, owner.dir), owner.dir))
		if(istype(A, /obj/structure/vampdoor))
			return
		if(istype(A, /obj/matrix))
			return
		if(istype(A, /obj/structure/window))
			return
		if(istype(A, /turf/open/floor/plating/vampocean))
			return
		if(istype(A, /obj/elevator_door))
			return
		if(istype(A, /obj/machinery/door/poddoor/shutters))
			return

	var/turf/open/LO = get_step(get_step(owner, owner.dir), owner.dir)

	var/mob/living/carbon/human/H = owner
	if(H.dancing)
		return
	H.dance_flip()
	H.Immobilize(2, TRUE)
	animate(H, pixel_z = 32, time = 2)
	spawn(2)
		H.forceMove(LO)
		animate(H, pixel_z = 0, time = 2)

/datum/quirk/dancer
	name = "Dancer"
	desc = "You know a couple of dance moves."
	value = 2
	gain_text = "<span class='notice'>You want to dance.</span>"
	lose_text = "<span class='warning'>You don't want to dance anymore.</span>"

/datum/quirk/dancer/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/action/dance/DA = new()
	DA.Grant(H)

/datum/action/dance
	name = "Dance"
	desc = "Dance from dusck till dawn!"
	button_icon_state = "dance"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	var/last_added_humanity = 0

/datum/action/dance/Trigger()
	var/mob/living/carbon/human/H = owner
	if(prob(50))
		dancefirst(owner)
	else
		dancesecond(owner)

	if(last_added_humanity+6000 < world.time)
		for(var/obj/machinery/jukebox/J in range(7, owner))
			if(J)
				if(J.active)
					H.AdjustHumanity(1, 8)
					last_added_humanity = world.time

/mob/living
	var/isdwarfy = FALSE

/datum/quirk/dwarf
	name = "Dwarf"
	desc = "You are short."
	value = 0
	gain_text = "<span class='notice'>You feel short.</span>"
	lose_text = "<span class='notice'>You don't feel short anymore.</span>"

/datum/quirk/dwarf/on_spawn()
	var/mob/living/carbon/human/H = quirk_holder
	H.AddElement(/datum/element/dwarfism, COMSIG_PARENT_PREQDELETED, src)
	H.isdwarfy = TRUE

#define SHORT 4/5
#define TALL 5/4

///Very similar to squish, but for dwarves and shorties
/datum/element/dwarfism
	element_flags = ELEMENT_DETACH|ELEMENT_BESPOKE
	id_arg_index = 2
	var/comsig
	var/list/attached_targets = list()

/datum/element/dwarfism/Attach(datum/target, comsig, comsig_target)
	. = ..()
	if(!ishuman(target))
		return ELEMENT_INCOMPATIBLE

	src.comsig = comsig

	var/mob/living/carbon/human/L = target
	if(L.lying_angle != 0)
		L.transform = L.transform.Scale(SHORT, 1)
		L.transform = L.transform.Translate(L.lying_angle == 90 ? 16*(SHORT-1) : -(16*(SHORT-1)), 0) //Makes sure you stand on the tile no matter the size - sand
	else
		L.transform = L.transform.Scale(1, SHORT)
		L.transform = L.transform.Translate(0, 16*(SHORT-1)) //Makes sure you stand on the tile no matter the size - sand
	attached_targets[target] = comsig_target
	RegisterSignal(target, comsig, .proc/check_loss) //Second arg of the signal will be checked against the comsig_target.

/datum/element/dwarfism/proc/check_loss(mob/living/L, comsig_target)
	if(attached_targets[L] == comsig_target)
		Detach(L)

/datum/element/dwarfism/Detach(mob/living/L)
	. = ..()
	if(QDELETED(L))
		return
	if(L.lying_angle != 0)
		L.transform = L.transform.Scale(TALL, 1)
		L.transform = L.transform.Translate(L.lying_angle == 90 ? 16*(TALL-1) : -(16*(TALL-1)), 0) //Makes sure you stand on the tile no matter the size - sand
	else
		L.transform = L.transform.Scale(1, TALL)
		L.transform = L.transform.Translate(0, 16*(TALL-1)) //Makes sure you stand on the tile no matter the size - sand
	UnregisterSignal(L, comsig)
	attached_targets -= L

#undef SHORT
#undef TALL

/datum/quirk/homosexual
	name = "Homosexual"
	desc = "You love your gender more than the opposite."
	value = 0
	mob_trait = TRAIT_HOMOSEXUAL
	gain_text = "<span class='notice'>You feel gay.</span>"
	lose_text = "<span class='notice'>You don't feel gay anymore.</span>"