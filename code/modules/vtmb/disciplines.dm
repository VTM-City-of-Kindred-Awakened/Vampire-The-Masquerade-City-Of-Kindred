/datum/discipline
	var/name = "Shit Aggresively"
	var/desc = "Shit with blood, cope and seethe"
	var/icon_state
	var/cost = 2
	var/ranged = FALSE
	var/delay = 5
	var/violates_masquerade = FALSE
	var/level = 1
	var/activate_sound = 'code/modules/ziggers/bloodhealing.ogg'
	var/leveldelay = TRUE

/datum/discipline/proc/activate(var/mob/living/target, var/mob/living/carbon/human/caster)
	if(!target)
		return
	if(!caster)
		return
	if(caster.bloodpool < cost)
		return
	if(target.stat == DEAD)
		return
	caster.bloodpool = max(0, caster.bloodpool-cost)
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
			caster.client.prefs.exper = min(1440, caster.client.prefs.exper+1)
			caster.client.prefs.save_preferences()
			caster.client.prefs.save_character()
			caster.last_experience = world.time
	if(violates_masquerade)
		if(CheckEyewitness(target, caster, 7, TRUE))
			AdjustMasquerade(caster, -1)
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
	activate_sound = 'code/modules/ziggers/wolves.ogg'

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
		target.Knockdown(20)
		W.forceMove(target.loc)
		playsound(W, 'code/modules/ziggers/volk.ogg', 80, TRUE)
		target.apply_damage(20*level, BRUTE, BODY_ZONE_CHEST)
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

/datum/discipline/auspex/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	var/sound/auspexbeat = sound('code/modules/ziggers/auspex.ogg', repeat = TRUE)
	caster.playsound_local(caster, auspexbeat, 75, 0, channel = CHANNEL_DISCIPLINES, use_reverb = FALSE)
	ADD_TRAIT(caster, TRAIT_THERMAL_VISION, TRAIT_GENERIC)
	caster.update_sight()
	caster.add_client_colour(/datum/client_colour/glass_colour/blue)
	spawn(delay*level)
		if(caster)
			caster.stop_sound_channel(CHANNEL_DISCIPLINES)
			playsound(caster, 'code/modules/ziggers/auspex_deactivate.ogg', 50, FALSE)
			REMOVE_TRAIT(caster, TRAIT_THERMAL_VISION, TRAIT_GENERIC)
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
	activate_sound = 'code/modules/ziggers/celerity_activate.ogg'

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
	spawn(delay*level)
		if(caster)
			playsound(caster, 'code/modules/ziggers/celerity_deactivate.ogg', 50, FALSE)
			caster.remove_movespeed_modifier(/datum/movespeed_modifier/reagent/methamphetamine)
			caster.celerity_visual = FALSE

/datum/discipline/dominate
	name = "Dominate"
	desc = "Supresses will of your targets. More effects on higher levels."
	icon_state = "dominate"
	cost = 2
	ranged = TRUE
	delay = 50
	activate_sound = 'code/modules/ziggers/dominate.ogg'

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
	switch(level)
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
				target.Knockdown(10*level)
				target.visible_message("<span class='warning'><b>[target] tries to wring \his neck!</b></span>", "<span class='warning'><b>You try to wring your own neck!</b></span>")
				playsound(target, 'code/modules/ziggers/suicide.ogg', 80, TRUE)
				target.apply_damage(10*level, BRUTE, BODY_ZONE_HEAD)
			else
				target.drop_all_held_items()
				target.Stun(10)
				spawn(10)
					target.visible_message("<span class='warning'><b>[target] wrings \his neck!</b></span>", "<span class='warning'><b>You wring your own neck!</b></span>")
					playsound(target, 'code/modules/ziggers/suicide.ogg', 80, TRUE)
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
	activate_sound = 'code/modules/ziggers/insanity.ogg'

/proc/dancefirst(mob/living/M)
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

/proc/dancesecond(mob/living/M)
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
			if(H.generation > caster.generation)
				return
			H.emote("laugh")
			H.Stun(10*level)
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
	delay = 50
	activate_sound = 'code/modules/ziggers/potence_activate.ogg'

/datum/discipline/potence/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	caster.dna.species.punchdamagelow += 10
	caster.dna.species.punchdamagehigh += 10
	caster.dna.species.meleemod += 1
	spawn(delay*level)
		if(caster)
			playsound(caster, 'code/modules/ziggers/potence_deactivate.ogg', 50, FALSE)
			caster.dna.species.punchdamagelow -= 10
			caster.dna.species.punchdamagehigh -= 10
			caster.dna.species.meleemod -= 1

/datum/discipline/fortitude
	name = "Fortitude"
	desc = "Boosts armor."
	icon_state = "fortitude"
	cost = 1
	ranged = FALSE
	delay = 50
	activate_sound = 'code/modules/ziggers/fortitude_activate.ogg'

/datum/discipline/fortitude/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	var/mod = min(3, level)
	caster.physiology.armor.melee += 25*mod
	caster.physiology.armor.bullet += 25*mod
	spawn(delay*level)
		if(caster)
			playsound(caster, 'code/modules/ziggers/fortitude_deactivate.ogg', 50, FALSE)
			caster.physiology.armor.melee -= 25*mod
			caster.physiology.armor.bullet -= 25*mod

/datum/discipline/obfuscate
	name = "Obfuscate"
	desc = "Makes you less noticable."
	icon_state = "obfuscate"
	cost = 1
	ranged = FALSE
	delay = 100
	activate_sound = 'code/modules/ziggers/obfuscate_activate.ogg'

/datum/discipline/obfuscate/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	for(var/mob/living/carbon/human/npc/NPC in GLOB.npc_list)
		if(NPC.danger_source == caster)
			NPC.danger_source = null
	switch(level)
		if(1)
			caster.alpha = 138
		if(2)
			caster.alpha = 106
		if(3)
			caster.alpha = 74
		else
			caster.alpha = 10
	spawn(delay*level)
		if(caster)
			playsound(caster, 'code/modules/ziggers/obfuscate_deactivate.ogg', 50, FALSE)
			caster.alpha = 255

/datum/discipline/presence
	name = "Presence"
	desc = "Makes targets in radius more vulnerable to damages, can hypnotize."
	icon_state = "presence"
	cost = 1
	ranged = FALSE
	delay = 50
	activate_sound = 'code/modules/ziggers/presence_activate.ogg'
	leveldelay = FALSE

/datum/discipline/presence/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	var/mod = level/2
	for(var/mob/living/L in viewers(5, src))
		if(L != caster)
			if(prob(10*level))
				L.Stun(delay)
			if(ishuman(L))
				var/mob/living/carbon/human/H = L
				H.dna.species.brutemod += mod
				H.dna.species.burnmod += mod
				spawn(delay)
					if(H)
						H.dna.species.brutemod -= mod
						H.dna.species.burnmod -= mod
	if(caster)
		playsound(caster, 'code/modules/ziggers/presence_deactivate.ogg', 50, FALSE)

/datum/discipline/protean
	name = "Protean"
	desc = "Lets your beast out, making you stronger and faster. Violates Masquerade."
	icon_state = "protean"
	cost = 1
	ranged = FALSE
	delay = 100
	violates_masquerade = TRUE
	activate_sound = 'code/modules/ziggers/protean_activate.ogg'

/datum/movespeed_modifier/protean2
	multiplicative_slowdown = -0.15

/datum/movespeed_modifier/protean3
	multiplicative_slowdown = -0.30

/datum/movespeed_modifier/protean4
	multiplicative_slowdown = -0.45

/datum/discipline/protean/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	var/mod = min(4, level)
	var/mutable_appearance/protean_overlay = mutable_appearance('code/modules/ziggers/icons.dmi', "protean[mod]", -PROTEAN_LAYER)
	switch(mod)
		if(1)
			caster.drop_all_held_items()
			caster.dna.species.attack_verb = "slash"
			caster.dna.species.punchdamagelow += 10
			caster.dna.species.punchdamagehigh += 10
			caster.remove_overlay(PROTEAN_LAYER)
			caster.overlays_standing[PROTEAN_LAYER] = protean_overlay
			caster.apply_overlay(PROTEAN_LAYER)
			spawn(delay*level)
				if(caster)
					playsound(caster, 'code/modules/ziggers/protean_deactivate.ogg', 50, FALSE)
					caster.dna.species.attack_verb = initial(caster.dna.species.attack_verb)
					caster.dna.species.punchdamagelow -= 10
					caster.dna.species.punchdamagehigh -= 10
					caster.remove_overlay(PROTEAN_LAYER)
		if(2)
			caster.drop_all_held_items()
			caster.dna.species.attack_verb = "slash"
			caster.dna.species.punchdamagelow += 10
			caster.dna.species.punchdamagehigh += 10
			caster.add_movespeed_modifier(/datum/movespeed_modifier/protean2)
			caster.remove_overlay(PROTEAN_LAYER)
			caster.overlays_standing[PROTEAN_LAYER] = protean_overlay
			caster.apply_overlay(PROTEAN_LAYER)
			spawn(delay*level)
				if(caster)
					playsound(caster, 'code/modules/ziggers/protean_deactivate.ogg', 50, FALSE)
					caster.dna.species.attack_verb = initial(caster.dna.species.attack_verb)
					caster.dna.species.punchdamagelow -= 10
					caster.dna.species.punchdamagehigh -= 10
					caster.remove_movespeed_modifier(/datum/movespeed_modifier/protean2)
					caster.remove_overlay(PROTEAN_LAYER)
		if(3)
			caster.drop_all_held_items()
			caster.dna.species.attack_verb = "slash"
			caster.dna.species.punchdamagelow += 20
			caster.dna.species.punchdamagehigh += 20
			caster.add_movespeed_modifier(/datum/movespeed_modifier/protean3)
			caster.remove_overlay(PROTEAN_LAYER)
			caster.overlays_standing[PROTEAN_LAYER] = protean_overlay
			caster.apply_overlay(PROTEAN_LAYER)
			spawn(delay*level)
				if(caster)
					playsound(caster, 'code/modules/ziggers/protean_deactivate.ogg', 50, FALSE)
					caster.dna.species.attack_verb = initial(caster.dna.species.attack_verb)
					caster.dna.species.punchdamagelow -= 20
					caster.dna.species.punchdamagehigh -= 20
					caster.remove_movespeed_modifier(/datum/movespeed_modifier/protean3)
					caster.remove_overlay(PROTEAN_LAYER)
		if(4)
			caster.drop_all_held_items()
			caster.dna.species.attack_verb = "slash"
			caster.dna.species.punchdamagelow += 20
			caster.dna.species.punchdamagehigh += 20
			caster.add_movespeed_modifier(/datum/movespeed_modifier/protean4)
			caster.remove_overlay(PROTEAN_LAYER)
			caster.overlays_standing[PROTEAN_LAYER] = protean_overlay
			caster.apply_overlay(PROTEAN_LAYER)
			spawn(delay*level)
				if(caster)
					playsound(caster, 'code/modules/ziggers/protean_deactivate.ogg', 50, FALSE)
					caster.dna.species.attack_verb = initial(caster.dna.species.attack_verb)
					caster.dna.species.punchdamagelow -= 20
					caster.dna.species.punchdamagehigh -= 20
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
	hitsound = 'code/modules/ziggers/drinkblood1.ogg'
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
				if(VL.bloodamount >= 1 && VL.stat != DEAD)
					var/sucked = min(VL.bloodamount, 2)
					VL.bloodamount -= sucked
					VH.blood_volume = max(VH.blood_volume-10, 150)
					if(ishuman(VL))
						var/mob/living/carbon/human/VHL = VL
						VHL.blood_volume = max(VH.blood_volume-10*sucked, 150)
						if(VL.bloodamount == 0)
							VHL.blood_volume = 0
							VL.death()
//							if(isnpc(VL))
//								AdjustHumanity(VH, -1, 3)
					else
						if(VL.bloodamount == 0)
							VL.death()
					VH.bloodpool += sucked*max(1, VL.bloodquality-1)
					VH.bloodpool = min(VH.maxbloodpool, VH.bloodpool)
			else
				if(VL.bloodpool >= 1)
					var/sucked = min(VL.bloodpool, 1*level)
					VH.bloodpool += sucked
					VH.bloodpool = min(VH.maxbloodpool, VH.bloodpool)

/datum/discipline/thaumaturgy
	name = "Thaumaturgy"
	desc = "Sucks blood from your victim in distance. Even from your own kind. On higher levels boils blood of victims and unlocks blood shield. Violates Masquerade."
	icon_state = "thaumaturgy"
	cost = 1
	ranged = TRUE
	delay = 10
	violates_masquerade = TRUE
	activate_sound = 'code/modules/ziggers/thaum.ogg'

/datum/discipline/thaumaturgy/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	switch(level)
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
				H.damage = 10*level
				H.preparePixelProjectile(target, start)
				H.level = round(level/2)
				H.fire(direct_target = target)
			else
				caster.bloodpool += target.bloodamount
				caster.bloodpool = min(caster.maxbloodpool, caster.bloodpool)
//				if(isnpc(target))
//					AdjustHumanity(caster, -1, 0)
				target.tremere_gib()

/datum/discipline/bloodshield
	name = "Blood shield"
	desc = "Boosts armor."
	icon_state = "bloodshield"
	cost = 2
	ranged = FALSE
	delay = 50
	activate_sound = 'code/modules/ziggers/thaum.ogg'

/datum/discipline/bloodshield/activate(mob/living/target, mob/living/carbon/human/caster)
	..()
	var/mod = min(3, level)
	caster.physiology.armor.melee += 25*mod
	caster.physiology.armor.bullet += 25*mod
	animate(caster, color = "#ff0000", time = 10, loop = 1)
//	caster.color = "#ff0000"
	spawn(delay*level)
		if(caster)
			playsound(caster, 'code/modules/ziggers/thaum.ogg', 50, FALSE)
			caster.physiology.armor.melee -= 25*mod
			caster.physiology.armor.bullet -= 25*mod
			caster.color = initial(caster.color)