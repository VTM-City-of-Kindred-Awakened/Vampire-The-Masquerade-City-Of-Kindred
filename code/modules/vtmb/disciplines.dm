/datum/discipline
	var/name = "Shit Aggresively"
	var/desc = "Shit with blood, cope and seethe"
	var/icon_state
	var/cost = 2
	var/ranged = FALSE
	var/delay = 5
	var/violates_masquerade = FALSE

/datum/discipline/proc/activate(var/mob/living/target, var/mob/living/carbon/human/caster)
	if(!target)
		return
	if(caster.bloodpool < cost)
		return
	caster.bloodpool -= cost
	if(violates_masquerade)
		if(CheckEyewitness(target, caster, 5, TRUE))
			AdjustMasquerade(caster, -1)
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
	violates_masquerade = TRUE

/obj/effect/spectral_wolf
	name = "Spectral Wolf"
	desc = "Bites enemies in other dimensions."
	icon = 'code/modules/ziggers/icons.dmi'
	icon_state = "wolf"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER

/datum/discipline/animalism/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	var/damagemod = 1
	if(caster.client)
		damagemod = max(1, round((13-caster.client.prefs.generation)/2))
	var/antidir = NORTH
	switch(target.dir)
		if(NORTH)
			antidir = SOUTH
		if(SOUTH)
			antidir = NORTH
		if(WEST)
			antidir = EAST
		if(EAST)
			antidir = WEST
	var/obj/effect/spectral_wolf/W = new(get_step(target, antidir))
	W.dir = target.dir
	W.set_light(2, 2, "#6eeeff")
	target.Stun(10)
	spawn(10)
	target.Knockdown(5)
	W.forceMove(target.loc)
	playsound(W, 'code/modules/ziggers/volk.ogg', 80, TRUE)
	target.apply_damage(25*damagemod, BRUTE, BODY_ZONE_CHEST)
	target.visible_message("<span class='warning'><b>[W] bites [target]!</b></span>", "<span class='warning'><b>[W] bites you!</b></span>")
	spawn(5)
		qdel(W)

/datum/discipline/auspex
	name = "Auspex"
	desc = "Allows to see auras."
	icon_state = "auspex"
	cost = 1
	ranged = FALSE
	delay = 100

//Smooth sdelai auspex, eto wallhack na auri

/datum/discipline/auspex/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	ADD_TRAIT(target, TRAIT_THERMAL_VISION, TRAIT_GENERIC)
	target.update_sight()
	target.add_client_colour(/datum/client_colour/glass_colour/blue)
	spawn(10 SECONDS)
		REMOVE_TRAIT(caster, TRAIT_THERMAL_VISION, TRAIT_GENERIC)
		target.remove_client_colour(/datum/client_colour/glass_colour/blue)
		target.update_sight()
