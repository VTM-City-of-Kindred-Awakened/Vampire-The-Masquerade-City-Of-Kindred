/obj/effect/landmark/npcbeacon
	name = "NPC beacon"
	var/directionwalk
/obj/effect/landmark/npc_spawn_point
/obj/effect/landmark/npc_spawn_point/Initialize()
	. = ..()
	GLOB.npc_spawn_points |= src
/obj/effect/landmark/npcbeacon/directed
	name = "NPC traffic"
	icon_state = "npc"

/obj/effect/landmark/npcbeacon/directed/Initialize()
	..()
	directionwalk = dir

/obj/effect/landmark/npcwall
	name = "NPC Wall"
	icon_state = "x"

/mob/living/carbon/human/npc/Initialize()
	..()
	GLOB.npc_list += src

/mob/living/carbon/human/npc/death()
	walk(src,0)
	if(last_attacker)
		if(ishuman(last_attacker))
			if(get_dist(src, last_attacker) < 7)
				AdjustHumanity(last_attacker, -1, 0)
	remove_overlay(FIGHT_LAYER)
	GLOB.npc_list -= src
//	SShumannpcpool.npclost()
	..()

/mob/living/carbon/human/npc/Destroy()
	..()
	GLOB.npc_list -= src
	SShumannpcpool.npclost()

/mob/living/carbon/human/npc/Life()
	if(stat == DEAD)
		return
	if(!CheckMove())
		nutrition = 400
		if(get_dist(danger_source, src) < 7)
			last_danger_meet = world.time
		if(fire_stacks >= 1)
			resist()
		if(!staying)
			if(loc == tupik_loc)
				tupik_steps += 1
			if(loc != tupik_loc)
				tupik_loc = loc
				tupik_steps = 0
			if(tupik_steps > 1)
				var/turf/T = get_step(src, pick(NORTH, SOUTH, WEST, EAST))
				face_atom(T)
				step_to(src,T,0)
				walktarget = ChoosePath()
		if(prob(5) && !danger_source)
			var/activity = rand(1, 3)
			switch(activity)
				if(1)
					StareAction()
				if(2)
					EmoteAction()
				if(3)
					SpeechAction()
	..()

/mob/living/carbon/human/npc/proc/CreateWay(var/direction)
	var/turf/location = get_turf(src)
	for(var/distance = 1 to 50)
		location = get_step(location, direction)
		if(iswallturf(location))
			return location
		for(var/atom/A in location)
			if(A.density && !istype(A, /obj/structure/lamppost))
				return location
			if(istype(A, /obj/effect/landmark/npcwall))
				return location
			if(isnpcbeacon(A) && prob(50))
//				var/opposite_dir = turn(direction, 180)				Nado
				stopturf = 1
				return get_step(location, direction)

/mob/living/carbon/human/npc/proc/ChoosePath()
	var/turf/north_steps = CreateWay(NORTH)
	var/turf/south_steps = CreateWay(SOUTH)
	var/turf/west_steps = CreateWay(WEST)
	var/turf/east_steps = CreateWay(EAST)

	if(dir == NORTH || dir == SOUTH)
		if(get_dist(src, west_steps) >= 7 && get_dist(src, east_steps) >= 7)
			return(pick(west_steps, east_steps))
		if(get_dist(src, west_steps) > get_dist(src, east_steps))
			if(prob(75))
				return west_steps
		else if(get_dist(src, east_steps) > get_dist(src, west_steps))
			if(prob(75))
				return east_steps
		else
			if(dir == NORTH)
				return pick(west_steps, east_steps, south_steps)
			else
				return pick(west_steps, east_steps, north_steps)

	if(dir == WEST || dir == EAST)
		if(get_dist(src, north_steps) >= 7 && get_dist(src, south_steps) >= 7)
			return pick(north_steps, south_steps)
		if(get_dist(src, north_steps) > get_dist(src, south_steps))
			if(prob(75))
				return north_steps
		else if(get_dist(src, south_steps) > get_dist(src, north_steps))
			if(prob(75))
				return south_steps
		else
			if(dir == WEST)
				return pick(north_steps, south_steps, east_steps)
			else
				return pick(north_steps, south_steps, west_steps)

/mob/living/carbon/human/npc/proc/CheckMove()
	if(stat >= 2)
		return TRUE
	if(ghoulificated)
		return TRUE
	if(key)
		return TRUE
	if(IsSleeping())
		return TRUE
	if(IsUnconscious())
		return TRUE
	if(IsParalyzed())
		return TRUE
	if(IsKnockdown())
		return TRUE
	if(IsStun())
		return TRUE
	if(HAS_TRAIT(src, TRAIT_RESTRAINED))
		return TRUE
	if(is_talking)
		return TRUE
	if(pulledby)
		if(last_grab+100 > world.time)
			return TRUE
		if(pulledby.grab_state >= GRAB_PASSIVE)
			return TRUE
	if(last_grab+50 > world.time)
		return TRUE
	return FALSE

/mob/living/carbon/human/npc
	var/no_walks = 0

/mob/living/carbon/human/npc/proc/route_optimisation()
	var/sosat = FALSE
	for(var/mob/M in viewers(10, src))
		if(M.client)
			sosat = TRUE
	if(sosat)
		return FALSE
	if(no_walks >= 10)
		no_walks = 0
		return FALSE
	no_walks = no_walks+1
	return TRUE

/mob/living/carbon/human/npc/proc/handle_automated_movement()
	if(CheckMove())
		return
	if(!walktarget && !staying && !danger_source)
		walktarget = ChoosePath()
		face_atom(walktarget)
		stopturf = rand(1, 2)
	if(isturf(loc))
		if(danger_source)
			a_intent = INTENT_HARM
			if(m_intent == MOVE_INTENT_WALK)
				toggle_move_intent(src)
			if(!my_weapon)
//				if(last_walkin+5 < world.time)
				var/reqsteps = round((SShumannpcpool.next_fire-world.time)/total_multiplicative_slowdown())
				set_glide_size(DELAY_TO_GLIDE_SIZE(total_multiplicative_slowdown()))
				walk_away(src, danger_source, reqsteps, total_multiplicative_slowdown())
			if(my_weapon)
				if(!spawned_weapon)
					my_weapon.forceMove(loc)
					drop_all_held_items()
					put_in_active_hand(my_weapon)
					spawned_weapon = TRUE
				if(get_active_held_item() != my_weapon)
					if(isturf(my_weapon.loc) && get_dist(src, my_weapon) < 2 && !get_active_held_item())
						ClickOn(my_weapon)
					else
						my_weapon = null
				if(danger_source)
					ClickOn(danger_source)
					face_atom(danger_source)
//				if(last_walkin+5 < world.time)
					var/reqsteps = round((SShumannpcpool.next_fire-world.time)/total_multiplicative_slowdown())
					set_glide_size(DELAY_TO_GLIDE_SIZE(total_multiplicative_slowdown()))
					walk_to(src, danger_source, reqsteps, total_multiplicative_slowdown())

			if(isliving(danger_source))
				var/mob/living/L = danger_source
				if(L.stat > 2)
					danger_source = null
					if(my_weapon)
						drop_all_held_items()
						my_weapon.forceMove(src)
						spawned_weapon = FALSE
					walktarget = ChoosePath()
					a_intent = INTENT_HELP

			if(last_danger_meet+300 <= world.time)
				danger_source = null
				if(my_weapon)
					drop_all_held_items()
					my_weapon.forceMove(src)
					spawned_weapon = FALSE
				walktarget = ChoosePath()
				a_intent = INTENT_HELP
		else if(walktarget && !staying)
			if(prob(25))
				toggle_move_intent(src)
			var/reqsteps = round((SShumannpcpool.next_fire-world.time)/total_multiplicative_slowdown())
			set_glide_size(DELAY_TO_GLIDE_SIZE(total_multiplicative_slowdown()))
			walk_to(src, walktarget, reqsteps, total_multiplicative_slowdown())

		if(my_weapon)
			if(spawned_weapon)
				if(get_active_held_item() == my_weapon)
					drop_all_held_items()
					my_weapon.forceMove(src)
					spawned_weapon = FALSE

/*
	if(danger_source)
		a_intent = INTENT_HARM
		if(m_intent == MOVE_INTENT_WALK)
			toggle_move_intent(src)
			set_glide_size(DELAY_TO_GLIDE_SIZE(total_multiplicative_slowdown()))
		walk_away(src,danger_source,9,total_multiplicative_slowdown())
		if(last_danger_meet+300 <= world.time)
			danger_source = null
			a_intent = INTENT_HELP
		goto Skip
//			if(!range_weapon && !melee_weapon)

	if(lastgo+total_multiplicative_slowdown() > world.time)
		goto Skip
	if(pulledby && last_grab+30 > world.time)
		goto Skip
	if(!walktarget)
		walktarget = ChoosePath()
		face_atom(walktarget)
		stopturf = rand(1, 2)
	if(get_dist(walktarget, src) <= stopturf)
		walktarget = ChoosePath()
		face_atom(walktarget)
		stopturf = rand(1, 2)
	lastgo = world.time
	var/walkshit = max(stopturf-1, get_dist(walktarget, src)-2)
	walk_to(src, walktarget, walkshit, total_multiplicative_slowdown())
	Skip
*/

//			walk_to(src, walktarget, stopturf, total_multiplicative_slowdown())
//			walk_to(src, walktarget, stopturf, total_multiplicative_slowdown())
