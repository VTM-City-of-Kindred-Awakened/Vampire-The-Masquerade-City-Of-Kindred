SUBSYSTEM_DEF(cityweather)
	name = "City Weather"
	init_order = INIT_ORDER_DEFAULT
	wait = 6000
	priority = FIRE_PRIORITY_DEFAULT

	var/list/affected_turfs = list()
	var/list/weather_effects = list()
	var/current_weather = "Clear"	//"Clear", "Rain" and "Fog"
	var/list/forecast = list()
	var/raining = FALSE
	var/fogging = FALSE

/datum/controller/subsystem/cityweather/fire()
	if(SScity_time.hour > 5 && SScity_time.hour < 21)
		return

//	for(var/i in 1 to 9)
//		var/weath = forecast[i]
//		to_chat(world, "DEBUG, [i], [weath]")

	var/cityhour = 1
	switch(SScity_time.hour)
		if(21)
			cityhour = 1
		if(22)
			cityhour = 2
		if(23)
			cityhour = 3
		if(0)
			cityhour = 4
		if(1)
			cityhour = 5
		if(2)
			cityhour = 6
		if(3)
			cityhour = 7
		if(4)
			cityhour = 8
		if(5)
			cityhour = 9

	if(forecast[cityhour] != current_weather)
		switch(forecast[cityhour])
			if("Clear")
				to_chat(world, "The night sky becomes clear...")
				raining = FALSE
				fogging = FALSE
				for(var/obj/effect/rain/R in weather_effects)
					if(R)
						qdel(R)
				for(var/obj/effect/fog/F in weather_effects)
					if(F)
						qdel(F)
			if("Rain")
				to_chat(world, "Clouds are uniting on the sky, small raindrops irrigate the city...")
				raining = TRUE
				fogging = FALSE
				for(var/obj/effect/fog/F in weather_effects)
					if(F)
						qdel(F)
				for(var/turf/T in affected_turfs)
					new /obj/effect/rain(T)
			if("Fog")
				to_chat(world, "Visibility range quickly decreases...")
				raining = FALSE
				fogging = TRUE
				for(var/obj/effect/rain/R in weather_effects)
					if(R)
						qdel(R)
				for(var/turf/T in affected_turfs)
					new /obj/effect/fog(T)
		current_weather = forecast[cityhour]

/datum/controller/subsystem/cityweather/Initialize()
	. = ..()
	for(var/turf/open/floor/T in world)
		if(istype(get_area(T), /area/vtm))
			var/area/vtm/V = get_area(T)
			if(V.upper)
				affected_turfs += T

	create_forecast()

/datum/controller/subsystem/cityweather/proc/create_forecast()
	for(var/i in 1 to 9)
		forecast += i
		var/weather = "Clear"
		if(i != 1 && i != 9)
			weather = pick("Clear", "Rain", "Fog")
		forecast[i] = weather

/datum/controller/subsystem/cityweather/proc/get_forecast(mob/user)
	for(var/i in 1 to 9)
		var/weath = forecast[i]
		var/time = "21:00"
		switch(i)
			if(1)
				time = "21:00"
			if(2)
				time = "22:00"
			if(3)
				time = "23:00"
			if(4)
				time = "00:00"
			if(5)
				time = "01:00"
			if(6)
				time = "02:00"
			if(7)
				time = "03:00"
			if(8)
				time = "04:00"
			if(9)
				time = "05:00"
		to_chat(user, "[time], [weath]")

/obj/effect/rain
	name = "rain"
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "rain"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	alpha = 98
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	move_resist = INFINITY
	obj_flags = NONE
	vis_flags = VIS_INHERIT_PLANE
	mouse_opacity = 0

/obj/effect/rain/Initialize()
	. = ..()
	for(var/obj/effect/decal/cleanable/B in loc)
		qdel(B)
	SScityweather.weather_effects += src

/obj/effect/rain/Destroy()
	. = ..()
	for(var/obj/effect/decal/cleanable/B in loc)
		qdel(B)
	SScityweather.weather_effects -= src

/obj/effect/rain/Crossed(atom/movable/AM)
	. = ..()
	AM.wash(CLEAN_RAD | CLEAN_TYPE_WEAK) // Clean radiation non-instantly
	AM.wash(CLEAN_WASH)

/obj/effect/fog
	name = "fog"
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "fog"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	alpha = 128
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	move_resist = INFINITY
	obj_flags = NONE
	vis_flags = VIS_INHERIT_PLANE
	mouse_opacity = 0

/obj/effect/fog/Initialize()
	. = ..()
	SScityweather.weather_effects += src

/obj/effect/fog/Destroy()
	. = ..()
	SScityweather.weather_effects -= src