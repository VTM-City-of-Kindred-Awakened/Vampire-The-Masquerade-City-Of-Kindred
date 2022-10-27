/mob/living/carbon/human/npc/Initialize()
	..()
	GLOB.npc_list += src

/mob/living/carbon/human/npc/death()
	..()
	GLOB.npc_list -= src

/mob/living/carbon/human/npc/Destroy()
	..()
	GLOB.npc_list -= src

/mob/living/carbon/human/npc/Life()
	nutrition = 400
	if(prob(10) && !run_or_anger)
		EmoteAction()
	if(last_m_intent_change+300 <= world.time)
		last_m_intent_change = world.time
		if(prob(50))
			toggle_move_intent(src)
	if(myloc != loc)
		last_tupik = world.time
		myloc = loc
	if(last_tupik+50 <= world.time)
		ChoosePath()
	..()

/mob/living/carbon/human/npc/proc/CreateWay(var/direction)
	var/turf/location = loc
	for(var/distance = 1 to 100)
		location = get_step(location, direction)
		if(iswallturf(location))
			return location
		for(var/atom/A in location)
			if(A.density)
				return location

/mob/living/carbon/human/npc/proc/ChoosePath()
	var/turf/north_steps = CreateWay(NORTH)
	var/turf/south_steps = CreateWay(SOUTH)
	var/turf/west_steps = CreateWay(WEST)
	var/turf/east_steps = CreateWay(EAST)

	if(dir == NORTH || dir == SOUTH)
		if(get_dist(src, west_steps) > get_dist(src, east_steps))
			return west_steps
		else if(get_dist(src, east_steps) > get_dist(src, west_steps))
			return east_steps
		else
			if(dir == NORTH)
				return pick(west_steps, east_steps, south_steps)
			else
				return pick(west_steps, east_steps, north_steps)

	if(dir == WEST || dir == EAST)
		if(get_dist(src, north_steps) > get_dist(src, south_steps))
			return north_steps
		else if(get_dist(src, south_steps) > get_dist(src, north_steps))
			return south_steps
		else
			if(dir == WEST)
				return pick(north_steps, south_steps, east_steps)
			else
				return pick(north_steps, south_steps, west_steps)

/mob/living/carbon/human/npc/proc/handle_automated_movement()
	if(is_talking)
		return
	set_glide_size(DELAY_TO_GLIDE_SIZE(total_multiplicative_slowdown()))
	if(!walktarget || get_dist(src, walktarget) <= 2)
		walktarget = ChoosePath()
	if(!run_or_anger)
		if(m_intent == MOVE_INTENT_RUN)
			walk_to(src, walktarget, 2, total_multiplicative_slowdown())
		else
			walk_to(src, walktarget, 1, total_multiplicative_slowdown())