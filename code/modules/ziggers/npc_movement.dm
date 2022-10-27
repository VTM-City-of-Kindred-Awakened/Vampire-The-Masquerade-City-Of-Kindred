/mob/living/carbon/human/npc/Initialize()
	..()
	GLOB.npc_list += src

/mob/living/carbon/human/npc/death()
	..()
	GLOB.npc_list -= src

/mob/living/carbon/human/npc/Destroy()
	..()
	GLOB.npc_list -= src

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
		if(get_dist(src, west_steps) <= 1 && get_dist(src, east_steps) <= 1)
			if(dir == NORTH)
				return south_steps
			if(dir == SOUTH)
				return north_steps
		if(get_dist(src, west_steps) > get_dist(src, east_steps))
			return west_steps
		else if(get_dist(src, east_steps) > get_dist(src, west_steps))
			return east_steps
		else
			return pick(west_steps, east_steps)

	if(dir == WEST || dir == EAST)
		if(get_dist(src, north_steps) <= 1 && get_dist(src, south_steps) <= 1)
			if(dir == WEST)
				return east_steps
			if(dir == EAST)
				return west_steps
		if(get_dist(src, north_steps) > get_dist(src, south_steps))
			return north_steps
		else if(get_dist(src, south_steps) > get_dist(src, north_steps))
			return south_steps
		else
			return pick(north_steps, south_steps)

/mob/living/carbon/human/npc/proc/handle_automated_movement()
	if(is_talking)
		return
	if(!walktarget || get_dist(src, walktarget) <= 1)
		walktarget = ChoosePath()
	if(!run_or_anger)
		walk_to(src, walktarget, rand(1, 3), 2)