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
	if(ranged)
		if(isnpc(target))
			var/mob/living/carbon/human/npc/NPC = target
			NPC.danger_source = caster
			NPC.last_danger_meet = world.time
	caster.bloodpool -= cost
	if(violates_masquerade)
		if(CheckEyewitness(target, caster, 7, TRUE))
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
	target.Stun(20)
	spawn(20)
	target.Knockdown(10)
	W.forceMove(target.loc)
	playsound(W, 'code/modules/ziggers/volk.ogg', 80, TRUE)
	target.apply_damage(25*damagemod, BRUTE, BODY_ZONE_CHEST)
	target.visible_message("<span class='warning'><b>[W] bites [target]!</b></span>", "<span class='warning'><b>[W] bites you!</b></span>")
	spawn(10)
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

/datum/discipline/celerity
	name = "Celerity"
	desc = "Boosts your speed."
	icon_state = "celerity"
	cost = 1
	ranged = FALSE
	delay = 140
	violates_masquerade = TRUE

/obj/effect/celerity
	name = "Damn"
	desc = "..."
	anchored = 1

/obj/effect/celerity/Initialize()
	..()
	spawn(5)
		qdel(src)

/mob/living/carbon/human
	var/celerity_visual = FALSE

/mob/living/carbon/human/Move(atom/newloc, direct, glide_size_override)
	..()
	if(celerity_visual)
		var/obj/effect/celerity/C = new(loc)
		C.name = name
		C.appearance = appearance
		C.dir = dir
		animate(C, pixel_x = rand(-16, 16), pixel_y = rand(-16, 16), alpha = 0, time = 5)

/datum/discipline/celerity/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	target.add_movespeed_modifier(/datum/movespeed_modifier/reagent/methamphetamine)
	caster.celerity_visual = TRUE
	spawn(14 SECONDS)
		target.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/methamphetamine)
		caster.celerity_visual = FALSE

/datum/discipline/dominate
	name = "Dominate"
	desc = "Suggests your targets to kill themselfs."
	icon_state = "dominate"
	cost = 2
	ranged = TRUE

/datum/discipline/dominate/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	to_chat(target, "<span class='userdanger'><b>YOU SHOULD KILL YOURSELF NOW</b></span>")
	if(iskindred(target))
		target.Knockdown(30)
		return
	target.drop_all_held_items()
	target.Stun(10)
	spawn(10)
		target.visible_message("<span class='warning'><b>[target] wrings \his neck!</b></span>", "<span class='warning'><b>You wring your own neck!</b></span>")
		playsound(target, 'code/modules/ziggers/suicide.ogg', 80, TRUE)
		target.apply_damage(50, BRUTE, BODY_ZONE_HEAD)
		target.death()

/datum/discipline/dementation
	name = "Dementation"
	desc = "Makes all humans in radius mentally ill for a second."
	icon_state = "dementation"
	cost = 2
	ranged = FALSE
	delay = 100

proc/dancefirst(mob/living/M)
	var/matrix/initial_matrix = matrix(M.transform)
	for (var/i in 1 to 75)
		if (!M)
			return
		switch(i)
			if (1 to 15)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(0,1)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
			if (16 to 30)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(1,-1)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
			if (31 to 45)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(-1,-1)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
			if (46 to 60)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(-1,1)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
			if (61 to 75)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(1,0)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
		M.setDir(turn(M.dir, 90))
		switch (M.dir)
			if (NORTH)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(0,3)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
			if (SOUTH)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(0,-3)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
			if (EAST)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(3,0)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
			if (WEST)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(-3,0)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
		sleep(1)
	M.lying_fix()

proc/dancesecond(mob/living/M)
	animate(M, transform = matrix(180, MATRIX_ROTATE), time = 1, loop = 0)
	var/matrix/initial_matrix = matrix(M.transform)
	for (var/i in 1 to 60)
		if (!M)
			return
		if (i<31)
			initial_matrix = matrix(M.transform)
			initial_matrix.Translate(0,1)
			animate(M, transform = initial_matrix, time = 1, loop = 0)
		if (i>30)
			initial_matrix = matrix(M.transform)
			initial_matrix.Translate(0,-1)
			animate(M, transform = initial_matrix, time = 1, loop = 0)
		M.setDir(turn(M.dir, 90))
		switch (M.dir)
			if (NORTH)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(0,3)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
			if (SOUTH)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(0,-3)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
			if (EAST)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(3,0)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
			if (WEST)
				initial_matrix = matrix(M.transform)
				initial_matrix.Translate(-3,0)
				animate(M, transform = initial_matrix, time = 1, loop = 0)
		sleep(1)
	M.lying_fix()

/datum/discipline/dementation/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	for(var/mob/living/carbon/human/H in viewers(5, caster))
		if(H != caster)
			H.emote("laugh")
			H.Stun(30)
			target.drop_all_held_items()
			if(stat <= 2 && !IsSleeping() && !IsUnconscious() && !IsParalyzed() && !IsKnockdown() && !HAS_TRAIT(src, TRAIT_RESTRAINED))
				if(prob(50))
					dancefirst(H)
				else
					dancesecond(H)