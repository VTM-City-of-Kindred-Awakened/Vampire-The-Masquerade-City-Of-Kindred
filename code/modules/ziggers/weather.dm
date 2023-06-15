SUBSYSTEM_DEF(cityweather)
	name = "City Weather"
	init_order = INIT_ORDER_DEFAULT
	wait = 6000
	priority = FIRE_PRIORITY_DEFAULT

	var/list/affected_turfs = list()
	var/current_weather = "Clear"	//"Clear", "Rain" and "Fog"
	var/list/forecast = list()

/datum/controller/subsystem/cityweather/fire()
	if(SScity_time.hour > 5 && SScity_time.hour < 21)
		return

	for(var/i in 1 to 9)
		var/weath = forecast[i]
		to_chat(world, "DEBUG, [i], [weath]")

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
			if("Rain")
				to_chat(world, "Clouds are uniting on the sky, small raindrops irrigate the city...")
			if("Fog")
				to_chat(world, "Visibility range quickly decreases...")
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
		var/weather = pick("Clear", "Rain", "Fog")
		forecast[i] = weather