SUBSYSTEM_DEF(city_time)
	name = "City Time"
	init_order = INIT_ORDER_DEFAULT
	wait = 200
	priority = FIRE_PRIORITY_DEFAULT

	var/hour = 21
	var/minutes = 0

	var/timeofnight = "21:00"

/proc/get_next_hour(var/number)
	if(number == 23)
		return 0
	else
		return number+1

/proc/get_watch_number(var/number)
	if(number < 10)
		return "0[number]"
	else
		return "[number]"

/datum/controller/subsystem/city_time/fire()
	if(minutes == 59)
		minutes = 0
		hour =  get_next_hour(hour)
	else
		minutes = max(0, minutes+1)

	timeofnight = "[get_watch_number(hour)]:[get_watch_number(minutes)]"

	if(hour == 5 && minutes == 30)
		to_chat(world, "<span class='ghostalert'>The night is ending...</span>")

	if(hour == 5 && minutes == 45)
		to_chat(world, "<span class='ghostalert'>First rays of the sun illuminate the sky...</span>")

	if(hour == 6 && minutes == 0)
		to_chat(world, "<span class='ghostalert'>THE NIGHT IS OVER.</span>")
		SSticker.force_ending = 1
		SSticker.current_state = GAME_STATE_FINISHED
		toggle_ooc(TRUE) // Turn it on
		toggle_dooc(TRUE)
		SSticker.declare_completion(SSticker.force_ending)
		Master.SetRunLevel(RUNLEVEL_POSTGAME)
		var/won
		if(length(SSfactionwar.marks_camarilla) > length(SSfactionwar.marks_anarch) && length(SSfactionwar.marks_camarilla) > length(SSfactionwar.marks_sabbat))
			won = "camarilla"
		if(length(SSfactionwar.marks_anarch) > length(SSfactionwar.marks_camarilla) && length(SSfactionwar.marks_anarch) > length(SSfactionwar.marks_sabbat))
			won = "anarch"
		if(length(SSfactionwar.marks_sabbat) > length(SSfactionwar.marks_anarch) && length(SSfactionwar.marks_sabbat) > length(SSfactionwar.marks_camarilla))
			won = "sabbat"
		for(var/mob/living/carbon/human/H in world)
			var/area/vtm/V = get_area(H)
			if(iskindred(H) && V.upper)
				H.death()
			if(won)
				if(H.frakcja == won)
					if(H.key)
						var/datum/preferences/P = GLOB.preferences_datums[ckey(H.key)]
						if(P)
							var/mode = 1
							if(HAS_TRAIT(H, TRAIT_NON_INT))
								mode = 2
							P.exper = min(calculate_mob_max_exper(H), P.exper+(1000/mode))
		switch(won)
			if("camarilla")
				to_chat(world, "Camarilla takes control over the city...")
			if("anarch")
				to_chat(world, "Anarchs take control over the city...")
			if("sabbat")
				to_chat(world, "Sabbat takes control over the city...")
			else
				to_chat(world, "The city remains neutral...")