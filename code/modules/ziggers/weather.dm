SUBSYSTEM_DEF(cityweather)
	name = "City Weather"
	init_order = INIT_ORDER_DEFAULT
	wait = 600
	priority = FIRE_PRIORITY_DEFAULT

	var/current_weather = "Clear"	//"Clear", "Rain" and "Fog"
	var/list/forecast = list()
	var/raining = FALSE
	var/fogging = FALSE

/datum/controller/subsystem/cityweather/fire()
	if(SScity_time.hour > 5 && SScity_time.hour < 21)
		return

	if(raining && length(GLOB.cleanable_list))
		var/obj/effect/decal/cleanable/C = pick(GLOB.cleanable_list)
		if(C)
			qdel(C)

//	if(raining)
//		var/turf/T = pick(affected_turfs)
//		T.wash(CLEAN_SCRUB)

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
		current_weather = forecast[cityhour]
		switch(forecast[cityhour])
			if("Clear")
				to_chat(world, "The night sky becomes clear...")
				raining = FALSE
				fogging = FALSE
			if("Rain")
				to_chat(world, "Clouds are uniting on the sky, small raindrops irrigate the city...")
				raining = TRUE
				fogging = FALSE
//			if("Fog")
//				to_chat(world, "Visibility range quickly decreases...")
//				raining = FALSE
//				fogging = TRUE

/datum/controller/subsystem/cityweather/Initialize()
	. = ..()
	create_forecast()

/datum/controller/subsystem/cityweather/proc/create_forecast()
	for(var/i in 1 to 9)
		forecast += i
		var/weather = "Clear"
		if(i != 1 && i != 9)
			weather = pick("Clear", "Rain")
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