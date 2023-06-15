#define TURNLEFT 0
#define NOTURN 1
#define TURNRIGHT 2

#define BACKWARDS 0
#define AHEAD 1

/obj/vampire_car
	name = "car"
	desc = "Take me home, country roads..."
	icon_state = "rideable"
	icon = 'code/modules/ziggers/cars.dmi'
	pixel_w = -32
	pixel_z = -32

	var/mob/living/driver
//	var/list/passengers = list()

	var/speed = 1	//Future
	var/last_speeded = 0
	var/turning = NOTURN
	var/driving = AHEAD
	var/facing_dir = SOUTH
	var/moving_dir = SOUTH

/mob/living/carbon/human/MouseDrop(atom/over_object)
	. = ..()
	if(istype(over_object, /obj/vampire_car))
		if(get_dist(src, over_object) < 2)
			var/obj/vampire_car/V = over_object
			if(!V.driver)
				forceMove(over_object)
				V.driver = src

/obj/vampire_car/relaymove(mob, direct)
	switch(direct)
		if(NORTH)
			driving = AHEAD
			turning = NOTURN
		if(NORTHEAST)
			driving = AHEAD
			turning = TURNLEFT
		if(NORTHWEST)
			driving = AHEAD
			turning = TURNRIGHT
		if(SOUTH)
			driving = BACKWARDS
			turning = NOTURN
		if(SOUTHEAST)
			driving = BACKWARDS
			turning = TURNLEFT
		if(SOUTHWEST)
			driving = BACKWARDS
			turning = TURNRIGHT
//		if(EAST)
//		if(WEST)

	if(driving == AHEAD)
		switch(turning)
			if(NOTURN)
				moving_dir = facing_dir
			if(TURNLEFT)
				moving_dir = turn(facing_dir, -45)
			if(TURNRIGHT)
				moving_dir = turn(facing_dir, 45)
	else
		switch(turning)
			if(NOTURN)
				moving_dir = turn(facing_dir, 180)
			if(TURNLEFT)
				moving_dir = turn(facing_dir, -135)
			if(TURNRIGHT)
				moving_dir = turn(facing_dir, 225)

	var/delay = 8

	if(world.time < last_speeded+delay)
		return

	if(moving_dir != NORTH && moving_dir != SOUTH && moving_dir != EAST && moving_dir != WEST)
		delay *= 0.75

	if(delay)
		last_speeded = world.time
		if(driving == AHEAD)
			facing_dir = moving_dir
		else
			facing_dir = turn(moving_dir, 180)
//		var/target_turf = get_step(src, last_dir)	//Fo futue
		glide_size = (32 / delay) * world.tick_lag// * (world.tick_lag / CLIENTSIDE_TICK_LAG_SMOOTH)
		step(src, moving_dir)
		dir = facing_dir
		glide_size = (32 / delay) * world.tick_lag// * (world.tick_lag / CLIENTSIDE_TICK_LAG_SMOOTH)

#undef TURNLEFT
#undef NOTURN
#undef TURNRIGHT

#undef BACKWARDS
#undef AHEAD