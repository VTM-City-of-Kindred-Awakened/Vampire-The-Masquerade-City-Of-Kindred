SUBSYSTEM_DEF(graveyard)
	name = "Graveyard"
	init_order = INIT_ORDER_DEFAULT
	wait = 12000
	priority = FIRE_PRIORITY_DEFAULT

	var/alive_zombies = 0	//MAX - 20, respawn every 10 minutes
	var/lost_points = 0
	var/clear_runs = 0
	var/list/graves = list()
	var/list/graveyarders = list()

/datum/controller/subsystem/graveyard/fire()
	if(alive_zombies < 20)
		for(var/mob/living/L in graveyarders)
			if(L.client)
				to_chat(L, "WALKING DEAD ARE RISING...")
		for(var/i in 1 to 50-alive_zombies)
			var/atom/grave = pick(graves)
			new /mob/living/simple_animal/hostile/zombie(grave.loc)
			alive_zombies = max(0, alive_zombies+1)
		clear_runs = max(0, clear_runs+1)
	else
		lost_points = max(0, lost_points+1)
		clear_runs = 0

	if(lost_points > 2)
		for(var/mob/living/L in graveyarders)
			if(L)
				if(L.client)
					AdjustMasquerade(L, -1)
					lost_points = 0

	if(clear_runs > 2)
		clear_runs = 0
		for(var/mob/living/L in graveyarders)
			if(L)
				if(L.client)
					AdjustMasquerade(L, 1)
					L.client.prefs.exper = min(calculate_mob_max_exper(L), L.client.prefs.exper+100)

/obj/vampgrave
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "grave1"
	name = "grave"
	plane = GAME_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER
	anchored = TRUE
	density = TRUE

/obj/vampgrave/Initialize()
	. = ..()
	SSgraveyard.graves += src
	icon_state = "grave[rand(1, 10)]"

/obj/vampgrave/Destroy()
	. = ..()
