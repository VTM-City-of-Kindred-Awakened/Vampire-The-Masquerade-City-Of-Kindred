/obj/effect/decal/rugs
	name = "rugs"
	icon = 'code/modules/ziggers/tiles.dmi'
	icon_state = "rugs"

/obj/effect/decal/rugs/Initialize()
	..()
	icon_state = "rugs[rand(1, 11)]"

/obj/structure/vampfence
	name = "\improper fence"
	desc = "Protects places from walking in."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "fence"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE

/obj/structure/vampfence/corner
	icon_state = "fence_corner"

/obj/structure/vampfence/rich
	icon = 'code/modules/ziggers/32x48.dmi'

/obj/structure/vampfence/corner/rich
	icon = 'code/modules/ziggers/32x48.dmi'

/obj/structure/gargoyle
	name = "\improper gargoyle"
	desc = "Some kind of gothic architecture."
	icon = 'code/modules/ziggers/32x48.dmi'
	icon_state = "gargoyle"
	pixel_z = 8
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYERS_LAYER
	anchored = TRUE

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
	set_light(7, 1, "#ffde9b")

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
	icon_state = "traffic"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	pixel_w = -32
	anchored = TRUE

/obj/effect/decal/litter
	name = "litter"
	icon = 'code/modules/ziggers/tiles.dmi'
	icon_state = "paper1"

/obj/effect/decal/litter/Initialize()
	..()
	icon_state = "paper[rand(1, 6)]"

/obj/effect/decal/cardboard
	name = "cardboard"
	icon = 'code/modules/ziggers/tiles.dmi'
	icon_state = "cardboard1"

/obj/effect/decal/cardboard/Initialize()
	..()
	icon_state = "cardboard[rand(1, 5)]"
	var/matrix/M = matrix()
	M.Turn(rand(0, 360))
	transform = M

/obj/structure/clothingrack
	name = "clothing rack"
	desc = "Have some clothes."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "rack"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE

/obj/structure/clothingrack/rand
	icon_state = "rack2"

/obj/structure/clothingrack/rand/Initialize()
	..()
	icon_state = "rack[rand(1, 3)]"

/obj/structure/clothinghanger
	name = "clothing hanger"
	desc = "Have some clothes."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "hanger1"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE

/obj/structure/clothinghanger/Initialize()
	..()
	icon_state = "hanger[rand(1, 4)]"

/obj/structure/trashcan
	name = "trash can"
	desc = "Holds garbage inside."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "garbage"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE

/obj/structure/trashcan/Initialize()
	..()
	if(prob(25))
		icon_state = "garbage_open"

/obj/structure/trashbag
	name = "trash bag"
	desc = "Holds garbage inside."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "garbage1"
	anchored = TRUE

/obj/structure/trashbag/Initialize()
	..()
	var/garbagestate = rand(1, 9)
	if(garbagestate > 6)
		density = TRUE
	icon_state = "garbage[garbagestate]"

/obj/structure/hotelsign
	name = "sign"
	desc = "It says H O T E L."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "hotel"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE

/obj/structure/hotelsign/Initialize()
	..()
	set_light(1, 0.5, "#8e509e")

/obj/structure/hotelbanner
	name = "banner"
	desc = "It says H O T E L."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "banner"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE

/obj/structure/milleniumsign
	name = "sign"
	desc = "It says M I L L E N I U M."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "millenium"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE

/obj/structure/milleniumsign/Initialize()
	..()
	set_light(1, 0.5, "#4299bb")

/obj/structure/anarchsign
	name = "sign"
	desc = "It says B A R."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "bar"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE

/obj/structure/anarchsign/Initialize()
	..()
	set_light(1, 0.5, "#ffffff")