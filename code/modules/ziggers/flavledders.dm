/obj/manholeup
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "ladder"
	name = "ladder"
	plane = GAME_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/climbing = FALSE

/obj/manholeup/attack_hand(mob/user)
	if(!climbing)
		climbing = TRUE
		if(do_after(user, 50, src))
			climbing = FALSE
			var/turf/destination = get_step_multiz(src, UP)
			var/mob/living/L = user
			if(L.pulling)
				L.pulling.forceMove(destination)
			user.forceMove(destination)
			playsound(src, 'code/modules/ziggers/sounds/manhole.ogg', 50, TRUE)
		else
			climbing = FALSE
	..()

/obj/manholedown
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "manhole"
	name = "manhole"
	plane = GAME_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/climbing = FALSE

/obj/manholedown/attack_hand(mob/user)
	if(!climbing)
		climbing = TRUE
		if(do_after(user, 50, src))
			climbing = FALSE
			var/turf/destination = get_step_multiz(src, DOWN)
			var/mob/living/L = user
			if(L.pulling)
				L.pulling.forceMove(destination)
			user.forceMove(destination)
			playsound(src, 'code/modules/ziggers/sounds/manhole.ogg', 50, TRUE)
		else
			climbing = FALSE
	..()
