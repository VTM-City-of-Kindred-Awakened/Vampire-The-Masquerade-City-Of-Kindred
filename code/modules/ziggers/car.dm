SUBSYSTEM_DEF(carsystem)
	name = "Car System"
	init_order = INIT_ORDER_DEFAULT
	wait = 1
	priority = FIRE_PRIORITY_DEFAULT
	var/list/cars = list()

/datum/controller/subsystem/carsystem/fire()
	for(var/obj/vampire_car/V in cars)
		if(V)
			V.proccess_move()

/obj/vampire_car
	name = "car"
	desc = "Take me home, country roads..."
	icon_state = "rideable"
	icon = 'code/modules/ziggers/cars.dmi'
	var/mob/living/driver
//	var/list/passengers = list()
	var/velocity_dir = SOUTH
	var/velocity_magnitude = 0

	var/input_x = 0
	var/input_y = 0

	var/next_move = 0
	var/next_rot = 0

	var/reverse_gear = 0

	var/accel_pow = 2
	var/turn_delay = 2
	var/brake_pow = 2

	var/velocity_max = 7
	var/delay_divisor = 12.5 //this is what decides our base speed

	var/facing = SOUTH
	var/flying = SOUTH

/mob/living/carbon/human/MouseDrop(atom/over_object)
	. = ..()
	if(istype(over_object, /obj/vampire_car))
		if(get_dist(src, over_object) < 2)
			var/obj/vampire_car/V = over_object
			if(!V.driver)
				forceMove(over_object)
				V.driver = src

/obj/vampire_car/Initialize()
	. = ..()
	SScarsystem.cars += src

/obj/vampire_car/Destroy()
	. = ..()
	SScarsystem.cars -= src

/obj/vampire_car/relaymove(mob, direct)
	input_x = 0
	input_y = 0
	switch(direct)
		if(NORTH)
			input_y += 1
		if(SOUTH)
			input_y -= 1
		if(EAST)
			input_x += 1
		if(WEST)
			input_x -= 1
//	if(input_x || input_y)

/obj/vampire_car/proc/proccess_move(mob/user)
	var/accel = 0
	var/rot = 0
	accel = input_y * accel_pow * (reverse_gear ? -1 : 1)
	rot = input_x * turn_delay
	if(velocity_magnitude == 0)
		rot = 0

	if(next_rot <= world.time && rot)
		dir = turn(dir,45 * (rot > 0 ? -1 : 1)  * ((reverse_gear) ? -1 : 1))	//reverse_gear + 1 esli chto vdrug
		facing = dir
		flying = dir
		next_rot = world.time + abs(rot)

	if(velocity_dir != dir && (velocity_magnitude + accel) > velocity_max)
		if(velocity_magnitude >= velocity_max) //we are at max speed
			velocity_magnitude -= accel_pow * 1.5
		else						  //we are at max speed AND the user is holding on the gas.
			velocity_magnitude -= accel_pow * 2
	velocity_dir = dir

	if(next_move > world.time)
		return min(next_rot-world.time, next_move - world.time)

	if(input_x == 0 && input_y == 0)
		accel = -brake_pow

	var/delay
	if(accel)
		if(accel > 0)
			if(velocity_magnitude < 1)
				velocity_magnitude = 1
			velocity_magnitude += accel
			delay = delay_divisor / velocity_magnitude
		else
			velocity_magnitude -= brake_pow
			if(velocity_magnitude <= 2)
				if(velocity_magnitude <= 0)
					reverse_gear = !reverse_gear
					delay = 10
					velocity_magnitude = 0
					return 10
				velocity_magnitude = 0
			else
				delay = delay_divisor / velocity_magnitude

	else if(velocity_magnitude)
		delay = delay_divisor / velocity_magnitude

	if(dir & (dir-1))
		delay *= 0.75

	if(delay)
		velocity_magnitude = min(velocity_magnitude + accel * delay/delay_divisor, velocity_max)

		var/target_turf = get_step(src,(reverse_gear ? turn(velocity_dir,180) : velocity_dir))
		glide_size = (32 / delay) * world.tick_lag// * (world.tick_lag / CLIENTSIDE_TICK_LAG_SMOOTH)
		step(src, (reverse_gear ? turn(velocity_dir, 180) : velocity_dir))
		glide_size = (32 / delay) * world.tick_lag// * (world.tick_lag / CLIENTSIDE_TICK_LAG_SMOOTH)
		update_owner_dir()
		if(loc != target_turf)
			velocity_magnitude = 0
	else
		delay = 1 // stopped

	next_move = world.time + delay
	return min(delay, next_rot-world.time)

/obj/vampire_car/proc/update_owner_dir() //after move, update ddir
	if(flying && facing != flying)
		dir = facing
