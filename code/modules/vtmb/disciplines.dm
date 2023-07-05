/datum/discipline
	var/name = "Shit Aggresively"
	var/desc = "Shit with blood, cope and seethe"
	var/icon_state
	var/cost = 2
	var/ranged = FALSE
	var/range = 8
	var/delay = 5
	var/violates_masquerade = FALSE
	var/level = 1
	var/activate_sound = 'code/modules/ziggers/sounds/bloodhealing.ogg'
	var/leveldelay = FALSE

	var/level_casting = 1	//which level we want to cast

/mob/living
	var/resistant_to_disciplines = FALSE

/datum/discipline/proc/activate(var/mob/living/target, var/mob/living/carbon/human/caster)
	if(!target)
		return
	if(!caster)
		return
	var/plus = 0
	if(HAS_TRAIT(caster, TRAIT_HUNGRY))
		plus = 1
	if(caster.bloodpool < cost+plus)
		return
	if(target.stat == DEAD)
		return
	if(ranged && get_dist(caster, target) > range)
		return
	caster.bloodpool = max(0, caster.bloodpool-(cost+plus))
	caster.update_blood_hud()
	if(ranged)
		to_chat(caster, "<span class='notice'>You activate the [name] on [target].</span>")
	else
		to_chat(caster, "<span class='notice'>You activate the [name].</span>")
	if(ranged)
		if(isnpc(target))
			var/mob/living/carbon/human/npc/NPC = target
			NPC.Aggro(caster, TRUE)
	if(activate_sound)
		playsound(caster, activate_sound, 50, FALSE)
	if(caster.client)
		if(caster.client.prefs)
			if(!HAS_TRAIT(caster, TRAIT_NON_INT))
				caster.client.prefs.exper = min(calculate_mob_max_exper(caster), caster.client.prefs.exper+5)
			caster.client.prefs.save_preferences()
			caster.client.prefs.save_character()
			caster.last_experience = world.time
	if(violates_masquerade)
		if(CheckEyewitness(target, caster, 7, TRUE))
			AdjustMasquerade(caster, -1)
	if(target.resistant_to_disciplines)
		to_chat(caster, "<span class='danger'>You failed to activate the [name].</span>")
		return
	switch(caster.generation-target.generation)
		if(10)
			if(prob(90))
				to_chat(caster, "<span class='danger'>You failed to activate the [name].</span>")
				return
		if(7 to 9)
			if(prob(50))
				to_chat(caster, "<span class='danger'>You failed to activate the [name].</span>")
				return
		if(4 to 6)
			if(prob(10))
				to_chat(caster, "<span class='danger'>You failed to activate the [name].</span>")
				return
//	if(!target)
//		var/choice = input(caster, "Choose your target", "Available Targets") as mob in oviewers(4, caster)
//		if(choice)
//			target = choice
//		else
//			return

/datum/discipline/animalism
	name = "Animalism"
	desc = "Summons Spectral Animals over your targets. Violates Masquerade."
	icon_state = "animalism"
	cost = 2
	ranged = TRUE
	violates_masquerade = TRUE
	activate_sound = 'code/modules/ziggers/sounds/wolves.ogg'

/obj/effect/spectral_wolf
	name = "Spectral Wolf"
	desc = "Bites enemies in other dimensions."
	icon = 'code/modules/ziggers/icons.dmi'
	icon_state = "wolf"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER

/datum/discipline/animalism/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
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
		W.forceMove(target.loc)
		playsound(W.loc, 'code/modules/ziggers/sounds/volk.ogg', 80, TRUE)
		target.apply_damage(5*level_casting, BRUTE, BODY_ZONE_CHEST)
		target.visible_message("<span class='warning'><b>[W] bites [target]!</b></span>", "<span class='warning'><b>[W] bites you!</b></span>")
		spawn(20)
			qdel(W)

/datum/discipline/auspex
	name = "Auspex"
	desc = "Allows to see auras."
	icon_state = "auspex"
	cost = 1
	ranged = FALSE
	delay = 50
	leveldelay = TRUE

/datum/discipline/auspex/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	var/sound/auspexbeat = sound('code/modules/ziggers/sounds/auspex.ogg', repeat = TRUE)
	caster.playsound_local(caster, auspexbeat, 75, 0, channel = CHANNEL_DISCIPLINES, use_reverb = FALSE)
	ADD_TRAIT(caster, TRAIT_THERMAL_VISION, TRAIT_GENERIC)
	var/loh = FALSE
	if(!HAS_TRAIT(caster, TRAIT_NIGHT_VISION))
		ADD_TRAIT(caster, TRAIT_NIGHT_VISION, TRAIT_GENERIC)
		loh = TRUE
	caster.update_sight()
	caster.add_client_colour(/datum/client_colour/glass_colour/blue)
	spawn(delay*level_casting)
		if(caster)
			caster.stop_sound_channel(CHANNEL_DISCIPLINES)
			playsound(caster.loc, 'code/modules/ziggers/sounds/auspex_deactivate.ogg', 50, FALSE)
			REMOVE_TRAIT(caster, TRAIT_THERMAL_VISION, TRAIT_GENERIC)
			if(loh)
				REMOVE_TRAIT(caster, TRAIT_NIGHT_VISION, TRAIT_GENERIC)
			caster.remove_client_colour(/datum/client_colour/glass_colour/blue)
			caster.update_sight()

/datum/discipline/celerity
	name = "Celerity"
	desc = "Boosts your speed. Violates Masquerade."
	icon_state = "celerity"
	cost = 1
	ranged = FALSE
	delay = 50
	violates_masquerade = TRUE
	activate_sound = 'code/modules/ziggers/sounds/celerity_activate.ogg'
	leveldelay = TRUE

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
	caster.add_movespeed_modifier(/datum/movespeed_modifier/reagent/methamphetamine)
	caster.celerity_visual = TRUE
	spawn(delay*level_casting)
		if(caster)
			playsound(caster.loc, 'code/modules/ziggers/sounds/celerity_deactivate.ogg', 50, FALSE)
			caster.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/methamphetamine)
			caster.celerity_visual = FALSE

/datum/discipline/dominate
	name = "Dominate"
	desc = "Supresses will of your targets. More effects on higher levels."
	icon_state = "dominate"
	cost = 2
	ranged = TRUE
	delay = 50
	activate_sound = 'code/modules/ziggers/sounds/dominate.ogg'

/datum/discipline/dominate/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	var/mob/living/carbon/human/TRGT
	if(ishuman(target))
		TRGT = target
		TRGT.remove_overlay(MUTATIONS_LAYER)
		var/mutable_appearance/dominate_overlay = mutable_appearance('code/modules/ziggers/icons.dmi', "dominate", -MUTATIONS_LAYER)
		dominate_overlay.pixel_z = 2
		TRGT.overlays_standing[MUTATIONS_LAYER] = dominate_overlay
		TRGT.apply_overlay(MUTATIONS_LAYER)
	switch(level_casting)
		if(1)
			target.Stun(5)
			if(target.body_position == STANDING_UP)
				to_chat(target, "<span class='userdanger'><b>GET DOWN</b></span>")
				target.toggle_resting()
			else
				to_chat(target, "<span class='userdanger'><b>STAY DOWN</b></span>")
		if(2)
			to_chat(target, "<span class='userdanger'><b>FORGET ABOUT IT</b></span>")
			target.drop_all_held_items()
			target.Stun(10)
		if(3)
			to_chat(target, "<span class='userdanger'><b>FALL ASLEEP</b></span>")
			target.Sleeping(20)
		if(4 to 5)
			to_chat(target, "<span class='userdanger'><b>YOU SHOULD KILL YOURSELF NOW</b></span>")
			if(iskindred(target))
				target.Knockdown(5*level_casting)
				target.visible_message("<span class='warning'><b>[target] tries to wring \his neck!</b></span>", "<span class='warning'><b>You try to wring your own neck!</b></span>")
				playsound(target.loc, 'code/modules/ziggers/sounds/suicide.ogg', 80, TRUE)
				target.apply_damage(5*level_casting, BRUTE, BODY_ZONE_HEAD)
			else
				target.drop_all_held_items()
				target.Stun(10)
				spawn(10)
					target.visible_message("<span class='warning'><b>[target] wrings \his neck!</b></span>", "<span class='warning'><b>You wring your own neck!</b></span>")
					playsound(target.loc, 'code/modules/ziggers/sounds/suicide.ogg', 80, TRUE)
					target.death()
	spawn(20)
		if(TRGT)
			TRGT.remove_overlay(MUTATIONS_LAYER)

/datum/discipline/dementation
	name = "Dementation"
	desc = "Makes all humans in radius mentally ill for a second."
	icon_state = "dementation"
	cost = 2
	ranged = FALSE
	delay = 100
	activate_sound = 'code/modules/ziggers/sounds/insanity.ogg'

/mob/living
	var/dancing = FALSE

/proc/dancefirst(mob/living/M)
	if(M.dancing)
		return
	M.dancing = TRUE
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
	M.dancing = FALSE

/proc/dancesecond(mob/living/M)
	if(M.dancing)
		return
	M.dancing = TRUE
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
	M.dancing = FALSE

/datum/discipline/dementation/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	for(var/mob/living/carbon/human/H in viewers(5, caster))
		if(H != caster)
			if(H.generation > caster.generation)
				return
			H.emote("laugh")
			H.Stun(10*level_casting)
			if(H.stat <= 2 && !H.IsSleeping() && !H.IsUnconscious() && !H.IsParalyzed() && !H.IsKnockdown() && !HAS_TRAIT(H, TRAIT_RESTRAINED))
				if(prob(50))
					dancefirst(H)
				else
					dancesecond(H)

/datum/discipline/potence
	name = "Potence"
	desc = "Boosts melee and unarmed damage."
	icon_state = "potence"
	cost = 1
	ranged = FALSE
	delay = 100
	activate_sound = 'code/modules/ziggers/sounds/potence_activate.ogg'

/datum/discipline/potence/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	caster.dna.species.punchdamagelow = caster.dna.species.punchdamagelow+10
	caster.dna.species.punchdamagehigh = caster.dna.species.punchdamagehigh+10
	caster.dna.species.meleemod = caster.dna.species.meleemod+(0.5*level_casting)
	caster.dna.species.attack_sound = 'code/modules/ziggers/sounds/heavypunch.ogg'
	spawn(delay)
		if(caster)
			playsound(caster.loc, 'code/modules/ziggers/sounds/potence_deactivate.ogg', 50, FALSE)
			caster.dna.species.punchdamagelow = caster.dna.species.punchdamagelow-10
			caster.dna.species.punchdamagehigh = caster.dna.species.punchdamagehigh-10
			caster.dna.species.meleemod = caster.dna.species.meleemod-(0.5*level_casting)
			caster.dna.species.attack_sound = initial(caster.dna.species.attack_sound)

/datum/discipline/fortitude
	name = "Fortitude"
	desc = "Boosts armor."
	icon_state = "fortitude"
	cost = 1
	ranged = FALSE
	delay = 100
	activate_sound = 'code/modules/ziggers/sounds/fortitude_activate.ogg'

/datum/discipline/fortitude/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	var/mod = min(3, level_casting)
	caster.physiology.armor.melee = caster.physiology.armor.melee+(15*mod)
	caster.physiology.armor.bullet = caster.physiology.armor.bullet+(15*mod)
	spawn(delay)
		if(caster)
			playsound(caster.loc, 'code/modules/ziggers/sounds/fortitude_deactivate.ogg', 50, FALSE)
			caster.physiology.armor.melee = caster.physiology.armor.melee-(15*mod)
			caster.physiology.armor.bullet = caster.physiology.armor.bullet-(15*mod)

/datum/discipline/obfuscate
	name = "Obfuscate"
	desc = "Makes you less noticable."
	icon_state = "obfuscate"
	cost = 1
	ranged = FALSE
	delay = 100
	activate_sound = 'code/modules/ziggers/sounds/obfuscate_activate.ogg'
	leveldelay = TRUE

/datum/discipline/obfuscate/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	for(var/mob/living/carbon/human/npc/NPC in GLOB.npc_list)
		if(NPC)
			if(NPC.danger_source == caster)
				NPC.danger_source = null
	caster.alpha = 32
	spawn(delay*level_casting)
		if(caster)
			playsound(caster.loc, 'code/modules/ziggers/sounds/obfuscate_deactivate.ogg', 50, FALSE)
			caster.alpha = 255

/datum/discipline/presence
	name = "Presence"
	desc = "Makes targets in radius more vulnerable to damages, can hypnotize."
	icon_state = "presence"
	cost = 1
	ranged = FALSE
	delay = 50
	activate_sound = 'code/modules/ziggers/sounds/presence_activate.ogg'
	leveldelay = FALSE

/datum/discipline/presence/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	var/mod = level_casting/2
	for(var/mob/living/carbon/human/L in viewers(6, caster))
		if(L != caster)
			var/mob/living/carbon/human/H = L
			H.dna.species.brutemod = H.dna.species.brutemod+mod
			H.dna.species.burnmod = H.dna.species.burnmod+mod
			H.remove_overlay(MUTATIONS_LAYER)
			var/mutable_appearance/presence_overlay = mutable_appearance('code/modules/ziggers/icons.dmi', "presence", -MUTATIONS_LAYER)
			presence_overlay.pixel_z = 1
			H.overlays_standing[MUTATIONS_LAYER] = presence_overlay
			H.apply_overlay(MUTATIONS_LAYER)
			spawn(delay)
				if(H)
					H.dna.species.brutemod = H.dna.species.brutemod-mod
					H.dna.species.burnmod = H.dna.species.burnmod-mod
					H.remove_overlay(MUTATIONS_LAYER)
	if(caster)
		playsound(caster.loc, 'code/modules/ziggers/sounds/presence_deactivate.ogg', 50, FALSE)

/datum/discipline/protean
	name = "Protean"
	desc = "Lets your beast out, making you stronger and faster. Violates Masquerade."
	icon_state = "protean"
	cost = 1
	ranged = FALSE
	delay = 150
	violates_masquerade = TRUE
	activate_sound = 'code/modules/ziggers/sounds/protean_activate.ogg'

/datum/movespeed_modifier/protean2
	multiplicative_slowdown = -0.15

/datum/movespeed_modifier/protean3
	multiplicative_slowdown = -0.25

/datum/movespeed_modifier/protean4
	multiplicative_slowdown = -0.35

/datum/movespeed_modifier/protean5
	multiplicative_slowdown = -0.45

/datum/discipline/protean/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	var/mod = min(4, level_casting)
	var/mutable_appearance/protean_overlay = mutable_appearance('code/modules/ziggers/icons.dmi', "protean[mod]", -PROTEAN_LAYER)
	switch(mod)
		if(1)
			caster.drop_all_held_items()
			caster.dna.species.attack_verb = "slash"
			caster.dna.species.attack_sound = 'sound/weapons/slash.ogg'
			caster.dna.species.punchdamagelow = caster.dna.species.punchdamagelow+10
			caster.dna.species.punchdamagehigh = caster.dna.species.punchdamagehigh+10
			caster.remove_overlay(PROTEAN_LAYER)
			caster.overlays_standing[PROTEAN_LAYER] = protean_overlay
			caster.apply_overlay(PROTEAN_LAYER)
			spawn(delay)
				if(caster)
					playsound(caster.loc, 'code/modules/ziggers/sounds/protean_deactivate.ogg', 50, FALSE)
					caster.dna.species.attack_verb = initial(caster.dna.species.attack_verb)
					caster.dna.species.attack_sound = initial(caster.dna.species.attack_sound)
					caster.dna.species.punchdamagelow = caster.dna.species.punchdamagelow-10
					caster.dna.species.punchdamagehigh = caster.dna.species.punchdamagehigh-10
					caster.remove_overlay(PROTEAN_LAYER)
		if(2)
			caster.drop_all_held_items()
			caster.dna.species.attack_verb = "slash"
			caster.dna.species.attack_sound = 'sound/weapons/slash.ogg'
			caster.dna.species.punchdamagelow = caster.dna.species.punchdamagelow+15
			caster.dna.species.punchdamagehigh = caster.dna.species.punchdamagehigh+15
			caster.add_movespeed_modifier(/datum/movespeed_modifier/protean2)
			caster.remove_overlay(PROTEAN_LAYER)
			caster.overlays_standing[PROTEAN_LAYER] = protean_overlay
			caster.apply_overlay(PROTEAN_LAYER)
			spawn(delay)
				if(caster)
					playsound(caster.loc, 'code/modules/ziggers/sounds/protean_deactivate.ogg', 50, FALSE)
					caster.dna.species.attack_verb = initial(caster.dna.species.attack_verb)
					caster.dna.species.attack_sound = initial(caster.dna.species.attack_sound)
					caster.dna.species.punchdamagelow = caster.dna.species.punchdamagelow-15
					caster.dna.species.punchdamagehigh = caster.dna.species.punchdamagehigh-15
					caster.remove_movespeed_modifier(/datum/movespeed_modifier/protean2)
					caster.remove_overlay(PROTEAN_LAYER)
		if(3)
			caster.drop_all_held_items()
			caster.dna.species.attack_verb = "slash"
			caster.dna.species.attack_sound = 'sound/weapons/slash.ogg'
			caster.dna.species.punchdamagelow = caster.dna.species.punchdamagelow+20
			caster.dna.species.punchdamagehigh = caster.dna.species.punchdamagehigh+20
			caster.add_movespeed_modifier(/datum/movespeed_modifier/protean3)
			caster.remove_overlay(PROTEAN_LAYER)
			caster.overlays_standing[PROTEAN_LAYER] = protean_overlay
			caster.apply_overlay(PROTEAN_LAYER)
			spawn(delay)
				if(caster)
					playsound(caster, 'code/modules/ziggers/sounds/protean_deactivate.ogg', 50, FALSE)
					caster.dna.species.attack_verb = initial(caster.dna.species.attack_verb)
					caster.dna.species.attack_sound = initial(caster.dna.species.attack_sound)
					caster.dna.species.punchdamagelow = caster.dna.species.punchdamagelow-20
					caster.dna.species.punchdamagehigh = caster.dna.species.punchdamagehigh-20
					caster.remove_movespeed_modifier(/datum/movespeed_modifier/protean3)
					caster.remove_overlay(PROTEAN_LAYER)
		if(4)
			caster.drop_all_held_items()
			caster.dna.species.attack_verb = "slash"
			caster.dna.species.attack_sound = 'sound/weapons/slash.ogg'
			caster.dna.species.punchdamagelow = caster.dna.species.punchdamagelow+25
			caster.dna.species.punchdamagehigh = caster.dna.species.punchdamagelow+25
			if(level_casting == 5)
				caster.add_movespeed_modifier(/datum/movespeed_modifier/protean5)
			else
				caster.add_movespeed_modifier(/datum/movespeed_modifier/protean4)
			caster.remove_overlay(PROTEAN_LAYER)
			caster.overlays_standing[PROTEAN_LAYER] = protean_overlay
			caster.apply_overlay(PROTEAN_LAYER)
			spawn(delay)
				if(caster)
					playsound(caster, 'code/modules/ziggers/sounds/protean_deactivate.ogg', 50, FALSE)
					caster.dna.species.attack_verb = initial(caster.dna.species.attack_verb)
					caster.dna.species.attack_sound = initial(caster.dna.species.attack_sound)
					caster.dna.species.punchdamagelow = caster.dna.species.punchdamagelow-25
					caster.dna.species.punchdamagehigh = caster.dna.species.punchdamagehigh-25
					if(level_casting == 5)
						caster.remove_movespeed_modifier(/datum/movespeed_modifier/protean5)
					else
						caster.remove_movespeed_modifier(/datum/movespeed_modifier/protean4)
					caster.remove_overlay(PROTEAN_LAYER)


/mob/living/proc/tremere_gib()
	Stun(50)
	new /obj/effect/temp_visual/tremere(loc, "gib")
	animate(src, pixel_y = 16, color = "#ff0000", time = 50, loop = 1)

	spawn(50)
		if(stat != DEAD)
			death()
		var/list/items = list()
		items |= get_equipped_items(TRUE)
		for(var/obj/item/I in items)
			dropItemToGround(I)
		drop_all_held_items()
		spawn_gibs()
		spawn_gibs()
		spawn_gibs()
		qdel(src)

/obj/effect/projectile/tracer/thaumaturgy
	name = "blood beam"
	icon_state = "cult"

/obj/effect/projectile/muzzle/thaumaturgy
	name = "blood beam"
	icon_state = "muzzle_cult"

/obj/effect/projectile/impact/thaumaturgy
	name = "blood beam"
	icon_state = "impact_cult"

/obj/projectile/thaumaturgy
	name = "blood beam"
	icon_state = "thaumaturgy"
	pass_flags = PASSTABLE | PASSGLASS | PASSGRILLE
	damage = 10
	damage_type = BURN
	hitsound = 'code/modules/ziggers/sounds/drinkblood1.ogg'
	hitsound_wall = 'sound/weapons/effects/searwall.ogg'
	flag = LASER
	light_system = MOVABLE_LIGHT
	light_range = 1
	light_power = 1
	light_color = COLOR_SOFT_RED
	ricochets_max = 0
	ricochet_chance = 0
	tracer_type = /obj/effect/projectile/tracer/thaumaturgy
	muzzle_type = /obj/effect/projectile/muzzle/thaumaturgy
	impact_type = /obj/effect/projectile/impact/thaumaturgy
	var/level = 1

/obj/projectile/thaumaturgy/on_hit(atom/target, blocked = FALSE, pierce_hit)
	if(ishuman(firer))
		var/mob/living/carbon/human/VH = firer
		if(isliving(target))
			var/mob/living/VL = target
			if(!iskindred(target))
				if(VL.bloodpool >= 1 && VL.stat != DEAD)
					var/sucked = min(VL.bloodpool, 2)
					VL.bloodpool = VL.bloodpool-sucked
					VL.blood_volume = max(VL.blood_volume-10, 0)
					if(ishuman(VL))
						var/mob/living/carbon/human/VHL = VL
						VHL.blood_volume = max(VHL.blood_volume-10*sucked, 0)
						if(VL.bloodpool == 0)
							VHL.blood_volume = 0
							VL.death()
//							if(isnpc(VL))
//								AdjustHumanity(VH, -1, 3)
					else
						if(VL.bloodpool == 0)
							VL.death()
					VH.bloodpool = VH.bloodpool+(sucked*max(1, VL.bloodquality-1))
					VH.bloodpool = min(VH.maxbloodpool, VH.bloodpool)
			else
				if(VL.bloodpool >= 1)
					var/sucked = min(VL.bloodpool, 1*level)
					VH.bloodpool = VH.bloodpool+sucked
					VH.bloodpool = min(VH.maxbloodpool, VH.bloodpool)

/datum/discipline/thaumaturgy
	name = "Thaumaturgy"
	desc = "Sucks blood from your victim in distance. Even from your own kind. On higher levels boils blood of victims and unlocks blood shield. Violates Masquerade."
	icon_state = "thaumaturgy"
	cost = 1
	ranged = TRUE
	delay = 10
	violates_masquerade = TRUE
	activate_sound = 'code/modules/ziggers/sounds/thaum.ogg'

/datum/discipline/thaumaturgy/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	switch(level_casting)
		if(1)
			var/turf/start = get_turf(caster)
			var/obj/projectile/thaumaturgy/H = new(start)
			H.firer = caster
			H.preparePixelProjectile(target, start)
			H.fire(direct_target = target)
		if(2)
			var/turf/start = get_turf(caster)
			var/obj/projectile/thaumaturgy/H = new(start)
			H.firer = caster
			H.damage = 20
			H.preparePixelProjectile(target, start)
			H.level = 2
			H.fire(direct_target = target)
		if(3)
			var/turf/start = get_turf(caster)
			var/obj/projectile/thaumaturgy/H = new(start)
			H.firer = caster
			H.damage = 30
			H.preparePixelProjectile(target, start)
			H.level = 2
			H.fire(direct_target = target)
		else
			if(iskindred(target))
				var/turf/start = get_turf(caster)
				var/obj/projectile/thaumaturgy/H = new(start)
				H.firer = caster
				H.damage = 10*level_casting
				H.preparePixelProjectile(target, start)
				H.level = round(level_casting/2)
				H.fire(direct_target = target)
			else
				caster.bloodpool = min(caster.maxbloodpool, caster.bloodpool+target.bloodpool)
//				if(isnpc(target))
//					AdjustHumanity(caster, -1, 0)
				target.tremere_gib()

/datum/discipline/bloodshield
	name = "Blood shield"
	desc = "Boosts armor."
	icon_state = "bloodshield"
	cost = 2
	ranged = FALSE
	delay = 150
	activate_sound = 'code/modules/ziggers/sounds/thaum.ogg'

/datum/discipline/bloodshield/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	var/mod = level_casting
	caster.physiology.armor.melee = caster.physiology.armor.melee+(20*mod)
	caster.physiology.armor.bullet = caster.physiology.armor.bullet+(20*mod)
	animate(caster, color = "#ff0000", time = 10, loop = 1)
//	caster.color = "#ff0000"
	spawn(delay)
		if(caster)
			playsound(caster.loc, 'code/modules/ziggers/sounds/thaum.ogg', 50, FALSE)
			caster.physiology.armor.melee = caster.physiology.armor.melee-(20*mod)
			caster.physiology.armor.bullet = caster.physiology.armor.bullet-(20*mod)
			caster.color = initial(caster.color)


/datum/discipline/serpentis
	name = "Serpentis"
	desc = "Act like a cobra, get the powers to stun targets with your gaze and your tongue. On higher levels you can reach the ability to move your heart to the urn or ignore damage in torpor."
	icon_state = "serpentis"
	cost = 1
	ranged = TRUE
	delay = 50
	range = 2

/datum/discipline/serpentis/activate(mob/living/target, mob/living/carbon/human/caster)
	range = initial(range)+level_casting
	..()
	if(level_casting == 1)
		var/antidir = NORTH
		switch(caster.dir)
			if(NORTH)
				antidir = SOUTH
			if(SOUTH)
				antidir = NORTH
			if(WEST)
				antidir = EAST
			if(EAST)
				antidir = WEST
		if(target.dir == antidir)
			target.Stun(10)
			target.visible_message("<span class='warning'><b>[caster] hypnotizes [target] with his eyes!</b></span>", "<span class='warning'><b>[caster] hypnotizes you like a cobra!</b></span>")
			playsound(target.loc, 'code/modules/ziggers/sounds/serpentis.ogg', 50, TRUE)
			if(ishuman(target))
				var/mob/living/carbon/human/H = target
				H.remove_overlay(MUTATIONS_LAYER)
				var/mutable_appearance/serpentis_overlay = mutable_appearance('code/modules/ziggers/icons.dmi', "serpentis", -MUTATIONS_LAYER)
				H.overlays_standing[MUTATIONS_LAYER] = serpentis_overlay
				H.apply_overlay(MUTATIONS_LAYER)
	if(level_casting >= 2)
		if(get_dist(caster, target) <= 2+level_casting)
			playsound(target.loc, 'code/modules/ziggers/sounds/serpentis.ogg', 50, TRUE)
			playsound(caster.loc, 'code/modules/ziggers/sounds/tongue.ogg', 50, TRUE)
			target.Stun(5*level_casting)
			target.apply_damage(5*level, BRUTE, BODY_ZONE_HEAD)
			if(ishuman(target))
				var/mob/living/carbon/human/H = target
				H.remove_overlay(MUTATIONS_LAYER)
				var/mutable_appearance/serpentis_overlay = mutable_appearance('code/modules/ziggers/icons.dmi', "serpentis2", -MUTATIONS_LAYER)
				H.overlays_standing[MUTATIONS_LAYER] = serpentis_overlay
				H.apply_overlay(MUTATIONS_LAYER)
				spawn(5*level_casting)
					H.remove_overlay(MUTATIONS_LAYER)

/datum/discipline/vicissitude
	name = "Vicissitude"
	desc = "It is widely known as their art of flesh and bone shaping."
	icon_state = "vicissitude"
	cost = 1
	ranged = TRUE
	delay = 100
	range = 1

/datum/discipline/vicissitude/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		playsound(target.loc, 'code/modules/ziggers/sounds/vicissitude.ogg', 50, TRUE)
		if(target.stat >= 2)
			if(istype(target, /mob/living/carbon/human/npc))
				var/mob/living/carbon/human/npc/NPC = target
				NPC.last_attacker = null
			if(!iskindred(target))
				if(H.stat != DEAD)
					H.death()
				switch(level_casting)
					if(1)
						new /obj/item/stack/human_flesh(target.loc)
						new /obj/item/guts(target.loc)
						qdel(target)
					if(2)
						new /obj/item/stack/human_flesh/five(target.loc)
						new /obj/item/guts(target.loc)
						new /obj/item/spine(target.loc)
						var/obj/item/bodypart/B = H.get_bodypart(pick(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG))
						if(B)
							B.drop_limb()
						qdel(target)
					if(3)
						var/obj/item/bodypart/B1 = H.get_bodypart(BODY_ZONE_R_ARM)
						var/obj/item/bodypart/B2 = H.get_bodypart(BODY_ZONE_L_ARM)
						var/obj/item/bodypart/B3 = H.get_bodypart(BODY_ZONE_R_LEG)
						var/obj/item/bodypart/B4 = H.get_bodypart(BODY_ZONE_L_LEG)
						if(B1)
							B1.drop_limb()
						if(B2)
							B2.drop_limb()
						if(B3)
							B3.drop_limb()
						if(B4)
							B4.drop_limb()
						new /obj/item/stack/human_flesh/ten(target.loc)
						new /obj/item/guts(target.loc)
						new /obj/item/spine(target.loc)
						qdel(target)
					if(4)
						var/obj/item/bodypart/B1 = H.get_bodypart(BODY_ZONE_R_ARM)
						var/obj/item/bodypart/B2 = H.get_bodypart(BODY_ZONE_L_ARM)
						var/obj/item/bodypart/B3 = H.get_bodypart(BODY_ZONE_R_LEG)
						var/obj/item/bodypart/B4 = H.get_bodypart(BODY_ZONE_L_LEG)
						var/obj/item/bodypart/CH = H.get_bodypart(BODY_ZONE_CHEST)
						if(B1)
							B1.drop_limb()
						if(B2)
							B2.drop_limb()
						if(B3)
							B3.drop_limb()
						if(B4)
							B4.drop_limb()
						if(CH)
							CH.dismember()
						new /obj/item/stack/human_flesh/twenty(target.loc)
						qdel(target)
					if(5)
						var/obj/item/bodypart/B1 = H.get_bodypart(BODY_ZONE_R_ARM)
						var/obj/item/bodypart/B2 = H.get_bodypart(BODY_ZONE_L_ARM)
						var/obj/item/bodypart/B3 = H.get_bodypart(BODY_ZONE_R_LEG)
						var/obj/item/bodypart/B4 = H.get_bodypart(BODY_ZONE_L_LEG)
						var/obj/item/bodypart/CH = H.get_bodypart(BODY_ZONE_CHEST)
						var/obj/item/bodypart/HE = H.get_bodypart(BODY_ZONE_HEAD)
						if(B1)
							B1.drop_limb()
						if(B2)
							B2.drop_limb()
						if(B3)
							B3.drop_limb()
						if(B4)
							B4.drop_limb()
						if(CH)
							CH.dismember()
						if(HE)
							HE.dismember()
						new /obj/item/stack/human_flesh/fifty(target.loc)
						new /obj/item/guts(target.loc)
						new /obj/item/spine(target.loc)
						qdel(target)
		else
			target.emote("scream")
			target.apply_damage(10*level_casting, BRUTE, BODY_ZONE_CHEST)
			if(prob(10*level_casting))
				var/obj/item/bodypart/B = H.get_bodypart(pick(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM, BODY_ZONE_R_LEG, BODY_ZONE_L_LEG))
				if(B)
					B.drop_limb()

/turf
	var/silented = FALSE

/datum/discipline/quietus
	name = "Quietus"
	desc = "Grants influence over the blood of others. Can mute the nearby area."
	icon_state = "quietus"
	cost = 1
	ranged = TRUE
	delay = 50
	range = 2

/datum/discipline/quietus/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	playsound(target.loc, 'code/modules/ziggers/sounds/quietus.ogg', 50, TRUE)
	target.Stun(5*level_casting)
	if(level_casting > 3)
		if(target.bloodpool > 1)
			var/transfered = max(1, target.bloodpool-3)
			caster.bloodpool = min(caster.maxbloodpool, caster.bloodpool+transfered)
			target.bloodpool = transfered
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		H.remove_overlay(MUTATIONS_LAYER)
		var/mutable_appearance/quietus_overlay = mutable_appearance('code/modules/ziggers/icons.dmi', "quietus", -MUTATIONS_LAYER)
		H.overlays_standing[MUTATIONS_LAYER] = quietus_overlay
		H.apply_overlay(MUTATIONS_LAYER)
		spawn(5*level_casting)
			H.remove_overlay(MUTATIONS_LAYER)

/datum/discipline/necromancy
	name = "Necromancy"
	desc = "Offers control over another, undead reality."
	icon_state = "necromancy"
	cost = 2
	ranged = FALSE
	delay = 50
	violates_masquerade = TRUE

/mob/living/simple_animal/hostile/ghost/level1
	maxHealth = 20
	health = 20
/mob/living/simple_animal/hostile/ghost/level2
	maxHealth = 40
	health = 40
	melee_damage_lower = 20
	melee_damage_upper = 20
/mob/living/simple_animal/hostile/ghost/player/level3
	maxHealth = 60
	health = 60
	melee_damage_lower = 30
	melee_damage_upper = 30
/mob/living/simple_animal/hostile/ghost/player/level4
	maxHealth = 80
	health = 80
	melee_damage_lower = 40
	melee_damage_upper = 40
/mob/living/simple_animal/hostile/ghost/player/level5
	maxHealth = 100
	health = 100
	melee_damage_lower = 50
	melee_damage_upper = 50

/mob/living/simple_animal/hostile/ghost/player/Initialize()
	. = ..()
	give_player()

/mob/living/simple_animal/hostile/ghost/player/proc/give_player()
	set waitfor = FALSE
	var/list/mob/dead/observer/candidates = pollCandidatesForMob("Do you want to play as summoned ghost?", null, null, null, 50, src)
	for(var/mob/dead/observer/G in GLOB.player_list)
		if(G.key)
			to_chat(G, "<span class='ghostalert'>Someone is summoning a ghost!</span>")
	if(LAZYLEN(candidates))
		var/mob/dead/observer/C = pick(candidates)
		name = C.name
		key = C.key
		return TRUE
	return FALSE

/datum/discipline/necromancy/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	playsound(target.loc, 'code/modules/ziggers/sounds/necromancy.ogg', 50, TRUE)
	switch(level_casting)
		if(1)
			new /mob/living/simple_animal/hostile/ghost/level1(caster.loc)
		if(2)
			new /mob/living/simple_animal/hostile/ghost/level2(caster.loc)
		if(3)
			new /mob/living/simple_animal/hostile/ghost/player/level3(caster.loc)
		if(4)
			new /mob/living/simple_animal/hostile/ghost/player/level4(caster.loc)
		if(5)
			new /mob/living/simple_animal/hostile/ghost/player/level5(caster.loc)

/datum/discipline/obtenebration
	name = "Obtenebration"
	desc = "Controls the darkness around you."
	icon_state = "obtenebration"
	cost = 1
	ranged = FALSE
	delay = 100
	violates_masquerade = TRUE

/datum/discipline/obtenebration/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	playsound(target.loc, 'code/modules/ziggers/sounds/necromancy.ogg', 50, TRUE)
	var/atom/movable/AM = new(caster)
	AM.set_light(level_casting, -3)
	spawn(100)
		AM.set_light(0)