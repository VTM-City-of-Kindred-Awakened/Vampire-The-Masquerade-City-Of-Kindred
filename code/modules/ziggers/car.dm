#define TURNLEFT 0
#define NOTURN 1
#define TURNRIGHT 2

#define BACKWARDS 0
#define AHEAD 1

SUBSYSTEM_DEF(cars)
	name = "Cars"
	init_order = INIT_ORDER_DEFAULT
	wait = 10
	priority = FIRE_PRIORITY_DEFAULT

	var/list/cars = list()

/datum/controller/subsystem/cars/fire()
	for(var/obj/vampire_car/V in cars)
		if(V)
			if(V.on)
				playsound(V, 'code/modules/ziggers/sounds/work.ogg', 25, TRUE)
			if(V.last_speeded+20 < world.time)
				V.speed = 0

/obj/vampire_car
	name = "car"
	desc = "Take me home, country roads..."
	icon_state = "2"
	icon = 'code/modules/ziggers/cars.dmi'
	anchored = TRUE
	density = TRUE
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	pixel_w = -32
	pixel_z = -32

	var/obj/item/flashlight/FARI

	var/mob/living/driver
	var/list/passengers = list()
	var/max_passengers = 3

	var/speed = 1	//Future
	var/stage = 1
	var/last_speeded = 0
	var/turning = NOTURN
	var/driving = AHEAD
	var/facing_dir = SOUTH
	var/moving_dir = SOUTH
	var/last_dir = SOUTH
	var/turf_crossed = 0	//For turning
	var/on = FALSE
	var/locked = TRUE
	var/access = "none"

	var/health = 100
	var/maxhealth = 100
	var/repairing = FALSE

	var/last_beep = 0

/obj/vampire_car/bullet_act(obj/projectile/P, def_zone, piercing_hit = FALSE)
	. = ..()
	get_damage(5)

/obj/vampire_car/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	if(istype(I, /obj/item/vamp/keys))
		var/obj/item/vamp/keys/K = I
		if(istype(I, /obj/item/vamp/keys/hack))
			if(!repairing)
				repairing = TRUE
				if(do_mob(user, src, 20 SECONDS) && prob(50))
					locked = FALSE
					repairing = FALSE
					to_chat(user, "<span class='notice'>You've managed to open [src]'s lock.</span>")
					playsound(src, 'code/modules/ziggers/sounds/open.ogg', 50, TRUE)
					return
				else
					to_chat(user, "<span class='warning'>You've failed to open [src]'s lock.</span>")
					playsound(src, 'code/modules/ziggers/sounds/signal.ogg', 50, TRUE)
					repairing = FALSE
					return
				return
			return
		else if(K.accesslocks)
			for(var/i in K.accesslocks)
				if(i == access)
					to_chat(user, "<span class='notice'>You [locked ? "open" : "close"] [src]'s lock.</span>")
					playsound(src, 'code/modules/ziggers/sounds/open.ogg', 50, TRUE)
					locked = !locked
					return
		return
	if(istype(I, /obj/item/melee/vampirearms/tire))
		if(!repairing)
			repairing = TRUE
			if(do_mob(user, src, 5 SECONDS))
				get_damage(-20)
				playsound(src, 'code/modules/ziggers/sounds/repair.ogg', 50, TRUE)
				to_chat(user, "<span class='notice'>You repair some dents on [src].</span>")
				repairing = FALSE
				return
			else
				to_chat(user, "<span class='warning'>You failed to repair [src].</span>")
				repairing = FALSE
				return
			return
		return
	else
		get_damage(5)

/obj/vampire_car/Initialize()
	. = ..()
	FARI = new(src)
	FARI.pixel_w = -32
	FARI.pixel_z = -32
	SScars.cars += src

/obj/vampire_car/Destroy()
	. = ..()
	qdel(FARI)
	SScars.cars -= src
	for(var/mob/living/L in src)
		var/datum/action/carr/exit_car/C = locate() in L.actions
		if(C)
			C.Trigger()

/obj/vampire_car/examine(mob/user)
	. = ..()
	if(health < maxhealth && health >= maxhealth-(maxhealth/4))
		. += "It's slightly dented..."
	if(health < maxhealth-(maxhealth/4) && health >= maxhealth/2)
		. += "It has some major dents..."
	if(health < maxhealth/2 && health >= maxhealth/4)
		. += "It's heavily damaged..."
	if(health < maxhealth/4)
		. += "<span class='warning'>It appears to be falling apart...</span>"

/obj/vampire_car/proc/get_damage(var/cost)
	if(cost > 0)
		health = max(0, health-cost)
	if(cost < 0)
		health = min(maxhealth, health-cost)

	if(health == 0)
		on = FALSE
	else if(prob(50) && health <= maxhealth/2)
		on = FALSE

	return

/datum/action/carr/fari_vrubi
	name = "Toggle Light"
	desc = "Toggle light on/off."
	button_icon_state = "lights"

/datum/action/carr/fari_vrubi/Trigger()
	if(istype(owner.loc, /obj/vampire_car))
		var/obj/vampire_car/V = owner.loc
		if(V.FARI)
			V.FARI.on = !V.FARI.on
			to_chat(owner, "<span class='notice'>You toggle [V]'s lights.</span>")
			playsound(V, V.FARI.on ? 'sound/weapons/magin.ogg' : 'sound/weapons/magout.ogg', 40, TRUE)
			V.FARI.update_brightness(V)

/datum/action/carr/beep
	name = "Toggle Light"
	desc = "Toggle light on/off."
	button_icon_state = "beep"

/datum/action/carr/beep/Trigger()
	if(istype(owner.loc, /obj/vampire_car))
		var/obj/vampire_car/V = owner.loc
		if(V.last_beep+10 < world.time)
			V.last_beep = world.time
			playsound(V, 'code/modules/ziggers/sounds/beep.ogg', 60, TRUE)

/datum/action/carr/stage
	name = "Toggle Transmission"
	desc = "Toggle transmission to 1, 2 or 3."
	button_icon_state = "stage"

/datum/action/carr/stage/Trigger()
	if(istype(owner.loc, /obj/vampire_car))
		var/obj/vampire_car/V = owner.loc
		if(V.stage < 3)
			V.stage = V.stage+1
		else
			V.stage = 1
		to_chat(owner, "<span class='notice'>You enable [V]'s transmission at [V.stage].</span>")

/datum/action/carr/engine
	name = "Toggle Engine"
	desc = "Toggle engine on/off."
	button_icon_state = "keys"

/datum/action/carr/engine/Trigger()
	if(istype(owner.loc, /obj/vampire_car))
		var/obj/vampire_car/V = owner.loc
		if(!V.on)
			if(V.health == V.maxhealth)
				V.on = TRUE
				playsound(V, 'code/modules/ziggers/sounds/start.ogg', 50, TRUE)
				to_chat(owner, "<span class='notice'>You managed to start [V]'s engine.</span>")
				return
			if(prob(100*(V.health/V.maxhealth)))
				V.on = TRUE
				playsound(V, 'code/modules/ziggers/sounds/start.ogg', 50, TRUE)
				to_chat(owner, "<span class='notice'>You managed to start [V]'s engine.</span>")
				return
			else
				to_chat(owner, "<span class='warning'>You failed to start [V]'s engine.</span>")
				return
			return
		else
			V.on = FALSE
			playsound(V, 'code/modules/ziggers/sounds/stop.ogg', 50, TRUE)
			to_chat(owner, "<span class='notice'>You stop [V]'s engine.</span>")
			return

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
		to_chat(owner, "<span class='notice'>You exit [V].</span>")
		playsound(V, 'code/modules/ziggers/sounds/door.ogg', 50, TRUE)

/mob/living/carbon/human/MouseDrop(atom/over_object)
	. = ..()
	if(istype(over_object, /obj/vampire_car))
		if(get_dist(src, over_object) < 2)
			var/obj/vampire_car/V = over_object
			if(!V.locked)
				if(!V.driver)
					forceMove(over_object)
					V.driver = src
					var/datum/action/carr/exit_car/E = new()
					E.Grant(src)
					var/datum/action/carr/fari_vrubi/F = new()
					F.Grant(src)
					var/datum/action/carr/engine/N = new()
					N.Grant(src)
					var/datum/action/carr/stage/S = new()
					S.Grant(src)
					var/datum/action/carr/beep/B = new()
					B.Grant(src)
				else if(length(V.passengers) < V.max_passengers)
					forceMove(over_object)
					V.passengers += src
					var/datum/action/carr/exit_car/E = new()
					E.Grant(src)
				to_chat(src, "<span class='notice'>You enter [V].</span>")
				playsound(V, 'code/modules/ziggers/sounds/door.ogg', 50, TRUE)
				return
			else
				to_chat(src, "<span class='warning'>[V] is locked.</span>")
				return

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
				if(turf_crossed > stage-1)
					moving_dir = turn(facing_dir, -45)
					turf_crossed = 0
			if(TURNRIGHT)
				if(turf_crossed > stage-1)
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
	else
		delay = delay+(3-stage)

//	if(moving_dir != NORTH && moving_dir != SOUTH && moving_dir != EAST && moving_dir != WEST)
//		delay /= 0.75

	if(world.time < last_speeded+delay)
		return

	if(speed < 5 && last_speeded+delay+10 > world.time)
		if(moving_dir != turn(last_dir, 45) && moving_dir != turn(last_dir, -45) && moving_dir != last_dir)
			if(last_beep+10 < world.time)
				last_beep = world.time
				playsound(src, 'code/modules/ziggers/sounds/stopping.ogg', 40, TRUE)
			speed = 0
			return

	if(delay)
		speed = delay
		last_speeded = world.time
		if(driving == AHEAD)
			facing_dir = moving_dir
		else
			facing_dir = turn(moving_dir, 180)
//		var/target_turf = get_step(src, last_dir)	//Fo futue
		glide_size = (32 / delay) * world.tick_lag// * (world.tick_lag / CLIENTSIDE_TICK_LAG_SMOOTH)
		step(src, moving_dir)
		dir = facing_dir
		FARI.dir = facing_dir
		last_dir = moving_dir
		turf_crossed = min(3, turf_crossed+1)
		glide_size = (32 / delay) * world.tick_lag// * (world.tick_lag / CLIENTSIDE_TICK_LAG_SMOOTH)
		playsound(src, 'code/modules/ziggers/sounds/work.ogg', 40, TRUE)
		if(health < maxhealth/2)
			do_attack_animation(src)
		for(var/mob/living/L in loc)
			if(L)
				L.apply_damage(25, BRUTE, BODY_ZONE_CHEST)
				do_attack_animation(L)

/obj/vampire_car/Bump(atom/A)
	if(speed > 5)
		return
	playsound(src, 'code/modules/ziggers/sounds/bump.ogg', 50, TRUE)
	last_speeded = world.time+20
	do_attack_animation(A)
	if(driving != BACKWARDS)
		if(istype(A, /mob/living))
			var/mob/living/L = A
			L.Knockdown(10)
			L.apply_damage(25, BRUTE, BODY_ZONE_CHEST)
			get_damage(5)
		else
			get_damage(10)
			driver.apply_damage(10, BRUTE, BODY_ZONE_CHEST)
	else
		get_damage(1)
		if(istype(A, /mob/living))
			var/mob/living/L = A
			L.apply_damage(10, BRUTE, BODY_ZONE_CHEST)
	return

/obj/vampire_car/retro
	icon_state = "1"
	max_passengers = 1
	dir = WEST
	facing_dir = WEST
	moving_dir = WEST
	last_dir = WEST

/obj/vampire_car/retro/rand
	icon_state = "3"

/obj/vampire_car/retro/rand/Initialize()
	. = ..()
	icon_state = "[pick(1, 3, 5)]"

/obj/vampire_car/rand
	icon_state = "4"
	dir = WEST
	facing_dir = WEST
	moving_dir = WEST
	last_dir = WEST

/obj/vampire_car/rand/Initialize()
	. = ..()
	icon_state = "[pick(2, 4, 6)]"

/obj/vampire_car/rand/camarilla
	access = "camarilla"
	icon_state = "6"

/obj/vampire_car/retro/rand/camarilla
	access = "camarilla"
	icon_state = "5"

/obj/vampire_car/rand/anarch
	access = "anarch"
	icon_state = "6"

/obj/vampire_car/retro/rand/anarch
	access = "anarch"
	icon_state = "5"

/obj/vampire_car/rand/clinic
	access = "clinic"
	icon_state = "6"

/obj/vampire_car/retro/rand/clinic
	access = "clinic"
	icon_state = "5"

#undef TURNLEFT
#undef NOTURN
#undef TURNRIGHT

#undef BACKWARDS
#undef AHEAD