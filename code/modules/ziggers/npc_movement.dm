/mob/living/carbon/human/npc/proc/CreateWay(var/direction)
	var/turf/location = loc
	for(var/distance = 1 to 100)
		location = get_step(location, direction)-1
		if(iswallturf(location))
			return get_dist(src, location)
		for(var/atom/A in location)
			if(A.density)
				return get_dist(src, location)-1