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
	var/low = FALSE
	var/window

/turf/closed/wall/vampwall/attack_hand(mob/user)
	return
/turf/closed/wall/vampwall/attackby(obj/item/W, mob/user, params)
	return
/turf/closed/wall/vampwall/ex_act(severity, target)
	return

/turf/closed/wall/vampwall/Initialize()
	..()
	if(window)
		new window(src)
	else if(!low)
		addwall = new(get_step(src, NORTH))
		addwall.icon_state = icon_state
		addwall.name = name
		addwall.desc = desc

/turf/closed/wall/vampwall/set_smoothed_icon_state(new_junction)
	..()
	if(addwall)
		addwall.icon_state = icon_state

/turf/closed/wall/vampwall/Destroy()
	..()
	if(addwall)
		qdel(addwall)

/turf/closed/wall/vampwall/low
	icon = 'code/modules/ziggers/lowwalls.dmi'
	opacity = FALSE
	low = TRUE

/turf/closed/wall/vampwall/low/window
	icon_state = "wall-window"
	window = /obj/structure/window/fulltile

/turf/closed/wall/vampwall/rich
	name = "rich-looking wall"
	desc = "A huge chunk of expensive bricks used to separate rooms."
	icon_state = "rich-0"
	base_icon_state = "rich"

/turf/closed/wall/vampwall/rich/low
	icon = 'code/modules/ziggers/lowwalls.dmi'
	opacity = FALSE
	low = TRUE

/turf/closed/wall/vampwall/rich/low/window
	icon_state = "rich-window"
	window = /obj/structure/window/fulltile

/turf/closed/wall/vampwall/rich/low/window/reinforced
	icon_state = "rich-reinforced"
	window = /obj/structure/window/reinforced/fulltile

/turf/closed/wall/vampwall/junk
	name = "junk brick wall"
	desc = "A huge chunk of dirty bricks used to separate rooms."
	icon_state = "junk-0"
	base_icon_state = "junk"

/turf/closed/wall/vampwall/junk/low
	icon = 'code/modules/ziggers/lowwalls.dmi'
	opacity = FALSE
	low = TRUE

/turf/closed/wall/vampwall/junk/low/window
	icon_state = "junk-window"
	window = /obj/structure/window/fulltile

/turf/closed/wall/vampwall/junk/alt
	icon_state = "junkalt-0"
	base_icon_state = "junkalt"

/turf/closed/wall/vampwall/junk/alt/low
	icon = 'code/modules/ziggers/lowwalls.dmi'
	opacity = FALSE
	low = TRUE

/turf/closed/wall/vampwall/junk/alt/low/window
	icon_state = "junkalt-window"
	window = /obj/structure/window/fulltile

/turf/closed/wall/vampwall/market
	name = "concrete wall"
	desc = "A huge chunk of concrete used to separate rooms."
	icon_state = "market-0"
	base_icon_state = "market"

/turf/closed/wall/vampwall/market/low
	icon = 'code/modules/ziggers/lowwalls.dmi'
	opacity = FALSE
	low = TRUE

/turf/closed/wall/vampwall/market/low/window
	icon_state = "market-window"
	window = /obj/structure/window/fulltile

/turf/closed/wall/vampwall/market/low/window/reinforced
	icon_state = "market-reinforced"
	window = /obj/structure/window/reinforced/fulltile

/turf/closed/wall/vampwall/old
	name = "old brick wall"
	desc = "A huge chunk of old bricks used to separate rooms."
	icon_state = "old-0"
	base_icon_state = "old"

/turf/closed/wall/vampwall/old/low
	icon = 'code/modules/ziggers/lowwalls.dmi'
	opacity = FALSE
	low = TRUE

/turf/closed/wall/vampwall/old/low/window
	icon_state = "old-window"
	window = /obj/structure/window/fulltile

/turf/closed/wall/vampwall/old/low/window/reinforced
	icon_state = "old-reinforced"
	window = /obj/structure/window/reinforced/fulltile

/turf/closed/wall/vampwall/painted
	name = "painted brick wall"
	desc = "A huge chunk of painted bricks used to separate rooms."
	icon_state = "painted-0"
	base_icon_state = "painted"

/turf/closed/wall/vampwall/painted/low
	icon = 'code/modules/ziggers/lowwalls.dmi'
	opacity = FALSE
	low = TRUE

/turf/closed/wall/vampwall/painted/low/window
	icon_state = "painted-window"
	window = /obj/structure/window/fulltile

/turf/closed/wall/vampwall/painted/low/window/reinforced
	icon_state = "painted-reinforced"
	window = /obj/structure/window/reinforced/fulltile

/turf/closed/wall/vampwall/rich/old
	name = "old rich-looking wall"
	desc = "A huge chunk of old bricks used to separate rooms."
	icon_state = "theater-0"
	base_icon_state = "theater"

/turf/closed/wall/vampwall/rich/old/low
	icon = 'code/modules/ziggers/lowwalls.dmi'
	opacity = FALSE
	low = TRUE

/turf/closed/wall/vampwall/rich/old/low/window
	icon_state = "theater-window"
	window = /obj/structure/window/fulltile

/turf/closed/wall/vampwall/rich/old/low/window/reinforced
	icon_state = "theater-reinforced"
	window = /obj/structure/window/reinforced/fulltile

/turf/closed/wall/vampwall/brick
	name = "brick wall"
	desc = "A huge chunk of bricks used to separate rooms."
	icon_state = "brick-0"
	base_icon_state = "brick"

/turf/closed/wall/vampwall/brick/low
	icon = 'code/modules/ziggers/lowwalls.dmi'
	opacity = FALSE
	low = TRUE

/turf/closed/wall/vampwall/brick/low/window
	icon_state = "brick-window"
	window = /obj/structure/window/fulltile

/turf/closed/wall/vampwall/rock
	name = "rock wall"
	desc = "A huge chunk of rocks separating whole territory."
	icon_state = "rock-0"
	base_icon_state = "rock"

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
	set_light(1, 0.25, "#a4b7ff")

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
	icon_state = "sidewalk1"
	var/number_of_variations = 3
	var/based_icon_state = "sidewalk"
	flags_1 = NONE
	attachment_holes = FALSE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/sidewalk/Initialize()
	..()
	icon_state = "[based_icon_state][rand(1, number_of_variations)]"
	set_light(1, 0.25, "#a4b7ff")

/turf/open/floor/plating/sidewalk/poor
	icon_state = "sidewalk_poor1"
	based_icon_state = "sidewalk_poor"

/turf/open/floor/plating/sidewalk/rich
	icon_state = "sidewalk_rich1"
	number_of_variations = 6
	based_icon_state = "sidewalk_rich"

/obj/effect/decal/bordur
	name = "sidewalk"
	icon = 'code/modules/ziggers/tiles.dmi'
	icon_state = "border"

/obj/effect/decal/bordur/corner
	icon_state = "border_corner"

//STRUCTURES

/obj/structure/lamppost
	name = "lamppost"
	desc = "Gives some light to the streets."
	icon = 'code/modules/ziggers/lamppost.dmi'
	base_icon_state = "base"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	var/number_of_lamps
	pixel_w = -32
	anchored = TRUE
	density = TRUE

/obj/effect/decal/lamplight
	alpha = 0

/obj/effect/decal/lamplight/Initialize()
	..()
	set_light(4, 1, "#ffde9b")

/obj/structure/lamppost/Initialize()
	..()
	switch(number_of_lamps)
		if(1)
			switch(dir)
				if(NORTH)
					new /obj/effect/decal/lamplight(get_step(loc, NORTH))
				if(SOUTH)
					new /obj/effect/decal/lamplight(get_step(loc, SOUTH))
				if(EAST)
					new /obj/effect/decal/lamplight(get_step(loc, EAST))
				if(WEST)
					new /obj/effect/decal/lamplight(get_step(loc, WEST))
		if(2)
			switch(dir)
				if(NORTH)
					new /obj/effect/decal/lamplight(get_step(loc, NORTH))
					new /obj/effect/decal/lamplight(get_step(loc, SOUTH))
				if(SOUTH)
					new /obj/effect/decal/lamplight(get_step(loc, NORTH))
					new /obj/effect/decal/lamplight(get_step(loc, SOUTH))
				if(EAST)
					new /obj/effect/decal/lamplight(get_step(loc, EAST))
					new /obj/effect/decal/lamplight(get_step(loc, WEST))
				if(WEST)
					new /obj/effect/decal/lamplight(get_step(loc, EAST))
					new /obj/effect/decal/lamplight(get_step(loc, WEST))
		if(3)
			switch(dir)
				if(NORTH)
					new /obj/effect/decal/lamplight(get_step(loc, NORTH))
					new /obj/effect/decal/lamplight(get_step(loc, EAST))
					new /obj/effect/decal/lamplight(get_step(loc, WEST))
				if(SOUTH)
					new /obj/effect/decal/lamplight(get_step(loc, SOUTH))
					new /obj/effect/decal/lamplight(get_step(loc, EAST))
					new /obj/effect/decal/lamplight(get_step(loc, WEST))
				if(EAST)
					new /obj/effect/decal/lamplight(get_step(loc, EAST))
					new /obj/effect/decal/lamplight(get_step(loc, NORTH))
					new /obj/effect/decal/lamplight(get_step(loc, SOUTH))
				if(WEST)
					new /obj/effect/decal/lamplight(get_step(loc, WEST))
					new /obj/effect/decal/lamplight(get_step(loc, NORTH))
					new /obj/effect/decal/lamplight(get_step(loc, SOUTH))
		if(4)
			new /obj/effect/decal/lamplight(get_step(loc, NORTH))
			new /obj/effect/decal/lamplight(get_step(loc, SOUTH))
			new /obj/effect/decal/lamplight(get_step(loc, EAST))
			new /obj/effect/decal/lamplight(get_step(loc, WEST))

/obj/structure/lamppost/one
	icon_state = "one"
	number_of_lamps = 1

/obj/structure/lamppost/two
	icon_state = "two"
	number_of_lamps = 2

/obj/structure/lamppost/three
	icon_state = "three"
	number_of_lamps = 3

/obj/structure/lamppost/four
	icon_state = "four"
	number_of_lamps = 4

/obj/structure/trafficlight
	name = "traffic light"
	desc = "Shows when road is free or not."
	icon = 'code/modules/ziggers/lamppost.dmi'
	base_icon_state = "traffic"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	pixel_w = -32
	anchored = TRUE

/turf/open/floor/plating/parquetry
	gender = PLURAL
	name = "parquetry"
	icon = 'code/modules/ziggers/tiles.dmi'
	icon_state = "parquet"
	flags_1 = NONE
	attachment_holes = FALSE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/granite
	gender = PLURAL
	name = "granite"
	icon = 'code/modules/ziggers/tiles.dmi'
	icon_state = "granite"
	flags_1 = NONE
	attachment_holes = FALSE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/concrete
	gender = PLURAL
	name = "concrete"
	icon = 'code/modules/ziggers/tiles.dmi'
	icon_state = "concrete"
	flags_1 = NONE
	attachment_holes = FALSE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/vampgrass
	gender = PLURAL
	name = "grass"
	icon = 'code/modules/ziggers/tiles.dmi'
	icon_state = "grass1"
	flags_1 = NONE
	attachment_holes = FALSE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_FLOOR
	barefootstep = FOOTSTEP_HARD_BAREFOOT
	clawfootstep = FOOTSTEP_HARD_CLAW
	heavyfootstep = FOOTSTEP_GENERIC_HEAVY

/turf/open/floor/plating/grass/Initialize()
	..()
	icon_state = "grass[rand(1, 5)]"

/obj/effect/decal/wallpaper
	name = "wall paint"
	icon = 'code/modules/ziggers/tiles.dmi'
	icon_state = "wallpaper"

/obj/effect/decal/wallpaper/grey
	icon_state = "wallpaper-grey"

/obj/effect/decal/wallpaper/light
	icon_state = "wallpaper-light"

/obj/effect/decal/wallpaper/red
	icon_state = "wallpaper-asylum"

/obj/effect/decal/wallpaper/blue
	icon_state = "wallpaper-club"

/obj/effect/decal/wallpaper/paper
	name = "wallpapers"
	icon_state = "wallpaper-cheap"

/obj/effect/decal/wallpaper/paper/green
	icon_state = "wallpaper-green"

/obj/effect/decal/wallpaper/paper/stripe
	icon_state = "wallpaper-stripe"

/obj/effect/decal/wallpaper/paper/rich
	icon_state = "wallpaper-rich"

/obj/effect/decal/wallpaper/stone
	name = "wall decoration"
	icon_state = "wallpaper-stone"

/obj/effect/decal/rugs
	name = "rugs"
	icon = 'code/modules/ziggers/tiles.dmi'
	icon_state = "rugs"

/obj/effect/decal/rugs/Initialize()
	..()
	icon_state = "rugs[rand(1, 11)]"