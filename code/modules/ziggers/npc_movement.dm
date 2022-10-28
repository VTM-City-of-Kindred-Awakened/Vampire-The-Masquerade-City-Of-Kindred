/obj/effect/landmark/npcbeacon
	name = "NPC beacon"

/mob/living/carbon/human/npc/Initialize()
	..()
	GLOB.npc_list += src

/mob/living/carbon/human/npc/death()
	..()
	if(ishuman(danger_source))
		var/mob/living/carbon/human/H = danger_source
		if(H.client)
			if(H.client.prefs.humanity > 0)
				H.client.prefs.humanity = max(0, H.client.prefs.humanity-1)
				H.client.prefs.save_preferences()
				H.client.prefs.save_character()
				SEND_SOUND(H, sound('code/modules/ziggers/feed_failed.ogg', 0, 0, 75))
				to_chat(H, "<span class='userdanger'><b>HUMANITY DECREASES</b></span>")
	GLOB.npc_list -= src

/mob/living/carbon/human/npc/Destroy()
	..()
	GLOB.npc_list -= src

/mob/living/carbon/human/npc/Life()
	if(stat == DEAD)
		return
	nutrition = 400
	if(fire_stacks >= 1)
		resist()
	if(prob(10) && !danger_source && stat <= 2)
		var/activity = rand(1, 3)
		switch(activity)
			if(1)
				StareAction()
			if(2)
				EmoteAction()
			if(3)
				SpeechAction()
	if(last_m_intent_change+300 <= world.time && !danger_source)
		last_m_intent_change = world.time
		if(prob(50))
			toggle_move_intent(src)
	..()

/mob/living/carbon/human/npc/proc/CreateWay(var/direction)
	var/turf/location = get_turf(src)
	for(var/distance = 1 to 50)
		location = get_step(location, direction)
		if(iswallturf(location))
			return location
		for(var/atom/A in location)
			if(A.density && !ishuman(A))
				return location
			if(isnpcbeacon(A) && prob(50))
//				var/opposite_dir = turn(direction, 180)				Nado
				stopturf = 1
				return get_step(location, direction)

/mob/living/carbon/human/npc/proc/ChoosePath()
	stopturf = rand(1, 2)
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

/mob/living/carbon/human/npc/proc/WalkTo(var/atom/target, var/mindistance = 0, var/delay = 3)
//	set waitfor = delay
	if(!iswalking)
		iswalking = TRUE
		var/atom/target1 = target
		var/mindistance1 = mindistance
		var/delay1 = delay
		sleep(delay)
		if(src.loc = myloc)
			repeats += 1
		if(repeats >= 5)
			walktarget = ChoosePath()
			iswalking = FALSE
			WalkTo(target1, mindistance1, delay1)
			return
		if(get_dist(target, src) <= mindistance)
			walktarget = ChoosePath()
			iswalking = FALSE
			WalkTo(target1, mindistance1, delay1)
			return
		if(stat >= 2)
			goto Skip
		if(IsSleeping())
			goto Skip
		if(danger_source)
			if(get_dist(danger_source, src) <= 7)
				last_danger_meet = world.time
				step_away(src, danger_source, 9)
				goto Skip
		if(is_talking)
			goto Skip
		if(pulledby && last_grab+30 >= world.time)
			goto Skip
		step_towards(src, target1)
//			to_chat(world, "Скипнул")
		Skip
			iswalking = FALSE
			WalkTo(target1, mindistance1, delay1)

/mob/living/carbon/human/npc/proc/handle_automated_movement()
	if(danger_source)
		a_intent = INTENT_HARM
		if(m_intent == MOVE_INTENT_WALK)
			toggle_move_intent(src)
			set_glide_size(DELAY_TO_GLIDE_SIZE(total_multiplicative_slowdown()))
		if(last_danger_meet+300 <= world.time)
			danger_source = null
			a_intent = INTENT_HELP
//			if(!range_weapon && !melee_weapon)
			if(prob(10))
				is_talking = TRUE
				spawn(rand(5, 10))
					say("*scream")
					is_talking = FALSE

	if(!walktarget)
		walktarget = ChoosePath()
	WalkTo(walktarget, stopturf, total_multiplicative_slowdown())
//			walk_to(src, walktarget, stopturf, total_multiplicative_slowdown())
//			walk_to(src, walktarget, stopturf, total_multiplicative_slowdown())
