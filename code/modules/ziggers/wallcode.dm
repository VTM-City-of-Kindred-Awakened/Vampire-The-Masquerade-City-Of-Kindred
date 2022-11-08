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
	desc = "A huge chunk of old bricks used to separate rooms."
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

/turf/closed/wall/vampwall/rich
	name = "rich-looking wall"
	desc = "A huge chunk of expensive bricks used to separate rooms."
	icon_state = "rich-0"
	base_icon_state = "rich"

/turf/closed/wall/vampwall/junk
	name = "junk brick wall"
	desc = "A huge chunk of dirty bricks used to separate rooms."
	icon_state = "junk-0"
	base_icon_state = "junk"

/turf/closed/wall/vampwall/junk/alt
	icon_state = "junkalt-0"
	base_icon_state = "junkalt"

/turf/closed/wall/vampwall/market
	name = "concrete wall"
	desc = "A huge chunk of concrete used to separate rooms."
	icon_state = "market-0"
	base_icon_state = "market"

/turf/closed/wall/vampwall/old
	name = "old brick wall"
	desc = "A huge chunk of old bricks used to separate rooms."
	icon_state = "old-0"
	base_icon_state = "old"

/turf/closed/wall/vampwall/painted
	name = "painted brick wall"
	desc = "A huge chunk of painted bricks used to separate rooms."
	icon_state = "painted-0"
	base_icon_state = "painted"

/turf/closed/wall/vampwall/rich/old
	name = "old rich-looking wall"
	desc = "A huge chunk of old bricks used to separate rooms."
	icon_state = "theater-0"
	base_icon_state = "theater"

/turf/closed/wall/vampwall/brick
	name = "brick wall"
	desc = "A huge chunk of bricks used to separate rooms."
	icon_state = "brick-0"
	base_icon_state = "brick"

//TURFS

/obj/effect/decal/asphalt
	name = "asphalt"
	icon = 'code/modules/ziggers/tiles.dmi'
	icon_state = "decal1"

/obj/effect/decal/asphalt/Initialize()
	..()
	icon_state = "decal[rand(1, 24)]"
	update_icon()

/obj/effect/decal/asphaltline
	name = "asphalt"
	icon = 'code/modules/ziggers/tiles.dmi'
	icon_state = "line"

/obj/effect/decal/asphaltline/alt
	icon_state = "line_alt"

/obj/effect/decal/asphaltline/Initialize()
	..()
	icon_state = "[initial(icon_state)][rand(1, 3)]"
	update_icon()

/obj/effect/decal/crosswalk
	name = "asphalt"
	icon = 'code/modules/ziggers/tiles.dmi'
	icon_state = "crosswalk1"

/obj/effect/decal/crosswalk/Initialize()
	..()
	icon_state = "crosswalk[rand(1, 3)]"
	update_icon()

/turf/open/floor/plating/asphalt
	gender = PLURAL
	name = "asphalt"
	icon = 'code/modules/ziggers/tiles.dmi'
	icon_state = "asphalt1"
	flags_1 = NONE
	attachment_holes = FALSE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/asphalt/Initialize()
	..()
	if(prob(50))
		icon_state = "asphalt[rand(1, 3)]"
		update_icon()
	if(prob(25))
		new /obj/effect/decal/asphalt(src)

/turf/open/floor/plating/asphalt/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return

/turf/open/floor/plating/asphalt/ex_act(severity, target)
	contents_explosion(severity, target)

/obj/effect/decal/stock
	name = "stock"
	icon = 'code/modules/ziggers/tiles.dmi'
	icon_state = "stock"

/turf/open/floor/plating/sidewalk
	gender = PLURAL
	name = "sidewalk"
	icon = 'code/modules/ziggers/tiles.dmi'
	icon_state = "sidewalk"
	flags_1 = NONE
	attachment_holes = FALSE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/sidewalk/corner
	icon_state = "sidewalk_corner"

/turf/open/floor/plating/sidewalk/full
	icon_state = "sidewalk_full"

/turf/open/floor/plating/sidewalk/alt
	icon_state = "sidewalk_alt"

/turf/open/floor/plating/sidewalk/alt/corner
	icon_state = "sidewalk_alt_corner"

/turf/open/floor/plating/sidewalk/alt/full
	icon_state = "sidewalk_alt_full"