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
	anchored = TRUE
	density = TRUE
	pixel_w = -32
	pixel_z = -32

	light_system = MOVABLE_LIGHT_DIRECTIONAL
	light_range = 6
	light_power = 2
	light_on = FALSE

	var/mob/living/driver
	var/list/passengers = list()
	var/max_passengers = 3

	var/speed = 1	//Future
	var/last_speeded = 0
	var/turning = NOTURN
	var/driving = AHEAD
	var/facing_dir = SOUTH
	var/moving_dir = SOUTH
	var/turf_crossed = 0	//For turning
	var/on = FALSE

	var/health = 100
	var/maxhealth = 100

/obj/vampire_car/proc/get_damage(var/cost)
	if(cost > 0)
		health = max(0, health-cost)
	if(cost < 0)
		health = min(maxhealth, health+cost)
	return

/datum/action/carr/fari_vrubi
	name = "Toggle Light"
	desc = "Toggle light on/off."
	button_icon_state = "lights"

/datum/action/carr/fari_vrubi/Trigger()
	if(istype(owner.loc, /obj/vampire_car))
		var/obj/vampire_car/V = owner.loc
		if(!V.light_on)
			V.light_on = TRUE
			playsound(V, 'sound/weapons/magin.ogg', 50, TRUE)
		else
			V.light_on = FALSE
			playsound(V, 'sound/weapons/magout.ogg', 50, TRUE)
		V.set_light_on(V.light_on)

/datum/action/carr/engine
	name = "Toggle Engine"
	desc = "Toggle engine on/off."
	button_icon_state = "keys"

/datum/action/carr/engine/Trigger()
	if(istype(owner.loc, /obj/vampire_car))
		var/obj/vampire_car/V = owner.loc
		if(!V.on)
			V.on = TRUE
			playsound(V, 'code/modules/ziggers/sounds/start.ogg', 50, TRUE)
		else
			V.on = FALSE
			playsound(V, 'code/modules/ziggers/sounds/stop.ogg', 50, TRUE)

/datum/action/carr/exit_car
	name = "Exit"
	desc = "Exit the vehicle."
	button_icon_state = "exit"

/datum/action/carr/exit_car/Trigger()
	if(istype(owner.loc, /obj/vampire_car))
		var/obj/vampire_car/V = owner.loc
		if(V.driver == owner)
			V.driver = null
		if(owner in V.passengers)
			V.passengers -= owner
		owner.forceMove(V.loc)
		for(var/datum/action/carr/C in owner.actions)
			qdel(C)
		playsound(V, 'code/modules/ziggers/sounds/door.ogg', 50, TRUE)

/mob/living/carbon/human/MouseDrop(atom/over_object)
	. = ..()
	if(istype(over_object, /obj/vampire_car))
		if(get_dist(src, over_object) < 2)
			var/obj/vampire_car/V = over_object
			if(!V.driver)
				forceMove(over_object)
				V.driver = src
				var/datum/action/carr/exit_car/E = new()
				E.Grant(src)
				var/datum/action/carr/fari_vrubi/F = new()
				F.Grant(src)
				var/datum/action/carr/engine/N = new()
				N.Grant(src)
			else if(length(V.passengers) < V.max_passengers)
				forceMove(over_object)
				V.passengers += src
				var/datum/action/carr/exit_car/E = new()
				E.Grant(src)
			playsound(V, 'code/modules/ziggers/sounds/door.ogg', 50, TRUE)

/obj/vampire_car/relaymove(mob, direct)
	if(!on)
		return
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
		if(EAST)
			return
		if(WEST)
			return

	if(driving == AHEAD)
		switch(turning)
			if(NOTURN)
				moving_dir = facing_dir
			if(TURNLEFT)
				if(turf_crossed > 1)
					moving_dir = turn(facing_dir, -45)
					turf_crossed = 0
			if(TURNRIGHT)
				if(turf_crossed > 1)
					moving_dir = turn(facing_dir, 45)
					turf_crossed = 0
	else
		switch(turning)
			if(NOTURN)
				moving_dir = turn(facing_dir, 180)
			if(TURNLEFT)
				moving_dir = turn(facing_dir, 135)
				turf_crossed = 0
			if(TURNRIGHT)
				moving_dir = turn(facing_dir, 225)
				turf_crossed = 0

	var/delay = 1
	if(health < maxhealth/4)
		delay = delay+round((maxhealth-health)/20)

	if(driving == BACKWARDS)
		delay = delay*3

	if(moving_dir != NORTH && moving_dir != SOUTH && moving_dir != EAST && moving_dir != WEST)
		delay /= 0.75

	if(world.time < last_speeded+delay)
		return

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
		turf_crossed = min(2, turf_crossed+1)
		glide_size = (32 / delay) * world.tick_lag// * (world.tick_lag / CLIENTSIDE_TICK_LAG_SMOOTH)
		playsound(src, 'code/modules/ziggers/sounds/work.ogg', 50, TRUE)
		for(var/mob/living/L in loc)
			if(L)
				L.apply_damage(25, BRUTE, BODY_ZONE_CHEST)
				do_attack_animation(L)

/obj/vampire_car/Bump(atom/A)
	playsound(src, 'code/modules/ziggers/sounds/bump.ogg', 50, TRUE)
	last_speeded = world.time+20
	do_attack_animation(A)
	if(driving != BACKWARDS)
		if(istype(A, /mob/living))
			var/mob/living/L = A
			var/atom/throw_target = get_step(get_step(src, dir), dir)
			L.throw_at(throw_target, 2, 4, src)
			L.apply_damage(25, BRUTE, BODY_ZONE_CHEST)
			get_damage(10)
		else
			get_damage(20)
	else
		get_damage(5)
		if(istype(A, /mob/living))
			var/mob/living/L = A
			L.apply_damage(10, BRUTE, BODY_ZONE_CHEST)
	return

#undef TURNLEFT
#undef NOTURN
#undef TURNRIGHT

#undef BACKWARDS
#undef AHEAD