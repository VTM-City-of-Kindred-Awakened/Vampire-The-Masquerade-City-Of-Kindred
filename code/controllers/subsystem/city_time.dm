SUBSYSTEM_DEF(city_time)
	name = "City Time"
	init_order = INIT_ORDER_DEFAULT
	wait = 200
	priority = FIRE_PRIORITY_DEFAULT

	var/hour = 21
	var/minutes = 0

	var/timeofnight = "23:00"

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

/datum/controller/subsystem/chat/fire()
	if(minutes == 59)
		minutes = 0
		hour =  get_next_hour(hour)
	else
		minutes = max(0, minutes+1)

	timeofnight = "[get_watch_number(hour)]:[get_watch_number(minutes)]"