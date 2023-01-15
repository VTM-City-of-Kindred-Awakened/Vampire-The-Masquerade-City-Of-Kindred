/obj/structure/elevator_button
	name = "elevator panel"
	icon = 'icons/obj/assemblies/new_assemblies.dmi'
	icon_state = "control"
	var/on_cooldown
	var/lift_location = "City"

/obj/structure/elevator_button/attack_hand(mob/living/user)
	var/lift_niggers = list()
	. = ..()
	if(on_cooldown)
		return
	src.say("Внимание, лифт отправляется")
	on_cooldown = TRUE
	sleep(10)
	for(var/mob/mob in GLOB.player_list)
		if(get_area(mob) != get_area(src))
			continue
		lift_niggers += mob
	if(lift_location == "City")
		for(var/mob/nigga in lift_niggers)
			if(nigga.x == 115 && nigga.y == 126)
				nigga.x = 120
				nigga.y = 9
			else if(nigga.x == 116 && nigga.y == 126)
				nigga.x = 121
				nigga.y = 9
			else if(nigga.x == 115 && nigga.y == 125)
				nigga.x = 120
				nigga.y = 8
			else if(nigga.x == 116 && nigga.y == 125)
				nigga.x = 121
				nigga.y = 8
	if(lift_location == "Prince")
		for(var/mob/nigga in lift_niggers)
			if(nigga.x == 120 && nigga.y == 9)
				nigga.x = 115
				nigga.y = 126
			else if(nigga.x == 121 && nigga.y == 9)
				nigga.x = 116
				nigga.y = 126
			else if(nigga.x == 120 && nigga.y == 8)
				nigga.x = 115
				nigga.y = 125
			else if(nigga.x == 121 && nigga.y == 8)
				nigga.x = 116
				nigga.y = 125
	on_cooldown = FALSE
