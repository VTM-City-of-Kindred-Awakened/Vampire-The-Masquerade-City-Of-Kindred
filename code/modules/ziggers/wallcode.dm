//Smooth Operator soset biby

/obj/effect/addwall
	name = "Debug"
	desc = "First rule of debug placeholder: Do not talk about debug placeholder."
	icon = 'code/modules/ziggers/addwalls.dmi'
	base_icon_state = "wall"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER

/turf/closed/wall/vampwall
	name = "old brick wall"
	desc = "A huge chunk of bricks used to separate rooms."
	icon = 'code/modules/ziggers/walls.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	opacity = TRUE
	density = TRUE
	smoothing_flags = SMOOTH_BITMASK

	var/obj/effect/addwall/addwall

/turf/closed/wall/vampwall/attack_hand(mob/user)
	return
/turf/closed/wall/vampwall/attackby(obj/item/W, mob/user, params)
	return
/turf/closed/wall/vampwall/ex_act(severity, target)
	return

/turf/closed/wall/vampwall/Initialize()
	..()
	addwall = new(get_step(src, NORTH))
	addwall.icon_state = icon_state
	addwall.update_icon()
	addwall.name = name
	addwall.desc = desc

/turf/closed/wall/vampwall/update_icon_state()
	..()
	addwall.icon_state = icon_state
	addwall.update_icon()

/turf/closed/wall/vampwall/Destroy()
	..()
	qdel(addwall)