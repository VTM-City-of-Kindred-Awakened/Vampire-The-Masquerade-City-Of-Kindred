/datum/discipline
	var/name = "Shit Aggresively"
	var/desc = "Shit with blood, cope and seethe"
	var/icon_state
	var/cost = 2
	var/active = FALSE
	var/ranged = FALSE

/mob/living/carbon/human
	var/datum/discipline/active_discipline

/atom/Click()
	if(ishuman(usr))
		var/mob/living/carbon/human/BD = usr
		if(BD.active_discipline)
			if(isliving(src))
				var/mob/living/TRGT = src
				BD.active_discipline.activate(TRGT, BD)
			else
				BD.active_discipline.active = FALSE
				BD.active_discipline = null
			BD.update_discipline_icons()
	..()

/datum/discipline/proc/activate(var/mob/living/target, var/mob/living/caster)
	if(!target)
		return
	caster.bloodpool -= cost
//	if(!target)
//		var/choice = input(caster, "Choose your target", "Available Targets") as mob in oviewers(4, caster)
//		if(choice)
//			target = choice
//		else
//			return

/datum/discipline/animalism
	name = "Animalism"
	desc = "Summons Spectral Wolf over your targets."
	icon_state = "animalism"
	cost = 2
	ranged = TRUE

/obj/effect/spectral_wolf
	name = "Spectral Wolf"
	desc = "Bites enemies in other dimensions."
	icon = 'code/modules/ziggers/icons.dmi'
	icon_state = "wolf"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER

/datum/discipline/animalism/activate(mob/living/target, mob/living/caster)
	..()
	var/obj/effect/spectral_wolf/W = new(target.loc)
	target.Stun(5)
	target.apply_damage(25, BRUTE, BODY_ZONE_CHEST)
	spawn(5)
		qdel(W)