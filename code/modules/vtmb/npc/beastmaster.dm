/mob/living/carbon/human
	var/list/beastmaster = list()

/mob/living/simple_animal/hostile/retaliate/beastmaster
	name = "dog"
	desc = "Woof-woof."
	icon = 'code/modules/ziggers/mobs.dmi'
	icon_state = "dog"
	icon_living = "dog"
	icon_dead = "dog_dead"
//	del_on_death = 1
	footstep_type = FOOTSTEP_MOB_SHOE
	mob_biotypes = MOB_ORGANIC
	speak_chance = 0
	turns_per_move = 5
	speed = 0
//	move_to_delay = 3
//	rapid = 3
//	ranged = 1
	maxHealth = 100
	health = 100
	harm_intent_damage = 5
	melee_damage_lower = 50
	melee_damage_upper = 50
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	a_intent = INTENT_HARM
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	bloodpool = 10
	maxbloodpool = 10
//	retreat_distance = 3
//	minimum_distance = 5
//	casingtype = /obj/item/ammo_casing/vampire/c556mm
//	projectilesound = 'code/modules/ziggers/sounds/rifle.ogg'
	loot = list()
	faction = list("Police")

	var/follow = TRUE
	var/mob/living/carbon/human/beastmaster

/mob/living/simple_animal/hostile/retaliate/beastmaster/proc/add_beastmaster_enemies(var/mob/living/L)
	if(istype(L, /mob/living/simple_animal/hostile/retaliate/beastmaster))
		var/mob/living/simple_animal/hostile/retaliate/beastmaster/M = L
		if(M.beastmaster == beastmaster)
			return
	enemies |= L

/mob/living/simple_animal/hostile/retaliate/beastmaster/Retaliate()
	return

/mob/living/carbon/human/attack_hand(mob/user)
	if(user)
		if(user.a_intent != INTENT_HELP)
			for(var/mob/living/simple_animal/hostile/retaliate/beastmaster/B in beastmaster)
				B.add_beastmaster_enemies(user)
	..()

/mob/living/carbon/human/npc/on_hit(obj/projectile/P)
	. = ..()
	if(P)
		if(P.firer)
			for(var/mob/living/simple_animal/hostile/retaliate/beastmaster/B in beastmaster)
				B.add_beastmaster_enemies(P.firer)

/mob/living/carbon/human/npc/hitby(atom/movable/AM, skipcatch, hitpush = TRUE, blocked = FALSE, datum/thrownthing/throwingdatum)
	. = ..()
	if(throwingdatum)
		if(throwingdatum.thrower)
			for(var/mob/living/simple_animal/hostile/retaliate/beastmaster/B in beastmaster)
				B.add_beastmaster_enemies(throwingdatum.thrower)

/mob/living/carbon/human/npc/attackby(obj/item/W, mob/living/user, params)
	. = ..()
	if(user)
		if(W.force)
			for(var/mob/living/simple_animal/hostile/retaliate/beastmaster/B in beastmaster)
				B.add_beastmaster_enemies(user)

/mob/living/carbon/human/npc/grabbedby(mob/living/carbon/user, supress_message = FALSE)
	. = ..()
	for(var/mob/living/simple_animal/hostile/retaliate/beastmaster/B in beastmaster)
		B.add_beastmaster_enemies(user)

/mob/living/carbon/human/pointed(atom/A as mob|obj|turf in view(client.view, src))
	if(..())
		if(isliving(A))
			for(var/mob/living/simple_animal/hostile/retaliate/beastmaster/B in beastmaster)
				B.add_beastmaster_enemies(A)

/datum/action/beastmaster_stay
	name = "Stay/Follow"
	desc = "Command to stay or follow."
	button_icon_state = "wait"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	var/cool_down = 0
	var/following = FALSE

/datum/action/beastmaster_stay/Trigger()
	. = ..()
	if(ishuman(owner))
		if(cool_down+10 >= world.time)
			return
		cool_down = world.time
		var/mob/living/carbon/human/H = owner
		if(!following)
			following = TRUE
			to_chat(owner, "You call your support.")
			for(var/mob/living/simple_animal/hostile/retaliate/beastmaster/B in H.beastmaster)
				B.follow = TRUE
		else
			following = FALSE
			to_chat(owner, "Your support will wait here.")
			for(var/mob/living/simple_animal/hostile/retaliate/beastmaster/B in H.beastmaster)
				B.follow = FALSE

/datum/action/beastmaster_deaggro
	name = "Loose Aggression"
	desc = "Command to stop any aggressive moves."
	button_icon_state = "deaggro"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	var/cool_down = 0

/datum/action/beastmaster_deaggro/Trigger()
	. = ..()
	if(ishuman(owner))
		if(cool_down+10 >= world.time)
			return
		cool_down = world.time
		var/mob/living/carbon/human/H = owner
		for(var/mob/living/simple_animal/hostile/retaliate/beastmaster/B in H.beastmaster)
			B.enemies = list()
			B.LosePatience()

/mob/living/simple_animal/hostile/retaliate/beastmaster/proc/gotomaster()
	step_towards(src, beastmaster)

/mob/living/simple_animal/hostile/retaliate/beastmaster/handle_automated_movement()
	..()
	if(follow && !target && stat != DEAD)
		if(z != beastmaster.z)
			forceMove(get_turf(beastmaster))
		if(get_dist(src, beastmaster) > 15)
			forceMove(get_turf(beastmaster))
		if(get_dist(src, beastmaster) > 3)
			var/reqsteps = round((SSnpcpool.next_fire-world.time)/total_multiplicative_slowdown())
			var/datum/cb = CALLBACK(src,/mob/living/simple_animal/hostile/retaliate/beastmaster/proc/gotomaster)
			for(var/i in 1 to reqsteps)
				addtimer(cb, (i - 1)*total_multiplicative_slowdown())