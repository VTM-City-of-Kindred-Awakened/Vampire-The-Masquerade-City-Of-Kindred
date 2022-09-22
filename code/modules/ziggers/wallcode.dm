//Smooth Operator soset biby

/obj/effect/adwall
	name = "Debug"
	desc = "First rule of debug placeholder: Do not talk about debug placeholder."
	icon = 'code/modules/ziggers/addwalls.dmi'
	base_icon_state = "wall"

get_step(src, NORTH)

/turf/closed/indestructible/vampwall
	name = "old brick wall"
	desc = "A huge chunk of bricks used to separate rooms."
	icon = 'code/modules/ziggers/walls.dmi'
	icon_state = "wall-0"
	base_icon_state = "wall"
	opacity = TRUE
	density = TRUE
	smoothing_flags = SMOOTH_BITMASK

	var/obj/effect/addwall/addwall

/turf/closed/indestructible/vampwall/Initialize()
	..()
	addwall = new(get_step(src, NORTH))
	addwall.icon_state = icon_state
	addwall.name = name
	addwall.desc = desc

/turf/closed/indestructible/vampwall/update_icon()
	..()
	addwall.icon_state = icon_state

/turf/closed/indestructible/vampwall/Destroy()
	..()
	qdel(addwall)