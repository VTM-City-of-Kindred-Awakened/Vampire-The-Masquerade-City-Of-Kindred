/obj/effect/decal/rugs
	name = "rugs"
	icon = 'code/modules/ziggers/tiles.dmi'
	icon_state = "rugs"

/obj/effect/decal/rugs/Initialize()
	. = ..()
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
	layer = SPACEVINE_LAYER
	var/number_of_lamps
	pixel_w = -32
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/effect/decal/lamplight
	alpha = 0

/obj/effect/decal/lamplight/Initialize()
	. = ..()
	set_light(4, 3, "#ffde9b")

/obj/structure/lamppost/Initialize()
	. = ..()
	if(GLOB.winter)
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "[initial(icon_state)]-snow"
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
		else
			new /obj/effect/decal/lamplight(loc)

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

/obj/structure/lamppost/sidewalk
	icon_state = "civ"
	number_of_lamps = 5

/obj/structure/lamppost/sidewalk/chinese
	icon_state = "chinese"

/obj/structure/trafficlight
	name = "traffic light"
	desc = "Shows when road is free or not."
	icon = 'code/modules/ziggers/lamppost.dmi'
	icon_state = "traffic"
	plane = GAME_PLANE
	layer = SPACEVINE_LAYER
	pixel_w = -32
	anchored = TRUE

/obj/structure/trafficlight/Initialize()
	. = ..()
	if(GLOB.winter)
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "[initial(icon_state)]-snow"

/obj/effect/decal/litter
	name = "litter"
	icon = 'code/modules/ziggers/tiles.dmi'
	icon_state = "paper1"

/obj/effect/decal/litter/Initialize()
	. = ..()
	icon_state = "paper[rand(1, 6)]"

/obj/effect/decal/cardboard
	name = "cardboard"
	icon = 'code/modules/ziggers/tiles.dmi'
	icon_state = "cardboard1"

/obj/effect/decal/cardboard/Initialize()
	. = ..()
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
	. = ..()
	icon_state = "rack[rand(1, 5)]"

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
	. = ..()
	icon_state = "hanger[rand(1, 4)]"

/obj/structure/foodrack
	name = "food rack"
	desc = "Have some food."
	icon = 'code/modules/ziggers/64x64.dmi'
	icon_state = "rack2"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE
	pixel_w = -16

/obj/structure/foodrack/Initialize()
	. = ..()
	icon_state = "rack[rand(1, 5)]"

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
	. = ..()
	if(prob(25))
		icon_state = "garbage_open"
	if(GLOB.winter)
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "[initial(icon_state)]-snow"

/obj/structure/trashbag
	name = "trash bag"
	desc = "Holds garbage inside."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "garbage1"
	anchored = TRUE

/obj/structure/trashbag/Initialize()
	. = ..()
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
	. = ..()
	set_light(3, 3, "#8e509e")
	if(GLOB.winter)
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "[initial(icon_state)]-snow"

/obj/structure/hotelbanner
	name = "banner"
	desc = "It says H O T E L."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "banner"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE

/obj/structure/hotelbanner/Initialize()
	. = ..()
	if(GLOB.winter)
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "[initial(icon_state)]-snow"

/obj/structure/milleniumsign
	name = "sign"
	desc = "It says M I L L E N I U M."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "millenium"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE

/obj/structure/milleniumsign/Initialize()
	. = ..()
	set_light(3, 3, "#4299bb")

/obj/structure/anarchsign
	name = "sign"
	desc = "It says B A R."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "bar"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE

/obj/structure/anarchsign/Initialize()
	. = ..()
	set_light(3, 3, "#ffffff")
	if(GLOB.winter)
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "[initial(icon_state)]-snow"

/obj/structure/chinesesign
	name = "sign"
	desc = "吸阴茎同性恋."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "chinese1"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE

/obj/structure/chinesesign/Initialize()
	. = ..()
	if(GLOB.winter)
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "[initial(icon_state)]-snow"

/obj/structure/chinesesign/alt
	icon_state = "chinese2"

/obj/structure/chinesesign/alt/alt
	icon_state = "chinese3"

/obj/structure/arc
	name = "chinatown arc"
	desc = "Cool chinese architecture."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "ark1"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE

/obj/structure/arc/Initialize()
	. = ..()
	if(GLOB.winter)
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "[initial(icon_state)]-snow"

/obj/structure/arc/add
	icon_state = "ark2"

/obj/structure/trad
	name = "traditional lamp"
	desc = "Cool chinese lamp."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "trad"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE

/obj/structure/vampipe
	name = "pipes"
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "piping1"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE

/obj/structure/hydrant
	name = "hydrant"
	desc = "Used for firefighting."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "hydrant"
	anchored = TRUE

/obj/structure/hydrant/Initialize()
	. = ..()
	if(GLOB.winter)
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "[initial(icon_state)]-snow"

/obj/structure/vampcar
	name = "car"
	desc = "It drives."
	icon = 'code/modules/ziggers/cars.dmi'
	icon_state = "taxi"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE
	pixel_w = -16

/obj/structure/vampcar/Initialize()
	. = ..()
	var/atom/movable/M = new(get_step(loc, EAST))
	M.density = TRUE
	M.anchored = TRUE
	dir = pick(NORTH, SOUTH, WEST, EAST)

/obj/structure/roadblock
	name = "\improper road block"
	desc = "Protects places from walking in."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "roadblock"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE

/obj/structure/roadblock/alt
	icon_state = "barrier"

/obj/machinery/light/prince
	icon = 'code/modules/ziggers/icons.dmi'

/obj/machinery/light/prince/ghost

/obj/machinery/light/prince/ghost/Crossed(atom/movable/AM)
	. = ..()
	if(ishuman(AM))
		var/mob/living/L = AM
		if(L.client)
			var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
			s.set_up(5, 1, get_turf(src))
			s.start()
			playsound(loc, 'code/modules/ziggers/sounds/explode.ogg', 100, TRUE)
			qdel(src)

/obj/machinery/light/prince/broken
	status = LIGHT_BROKEN
	icon_state = "tube-broken"

/obj/effect/decal/painting
	name = "painting"
	icon = 'code/modules/ziggers/icons.dmi'
	icon_state = "painting1"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER

/obj/effect/decal/painting/second
	icon_state = "painting2"

/obj/effect/decal/painting/third
	icon_state = "painting3"

/obj/structure/jesuscross
	name = "Jesus Christ on a cross"
	desc = "Jesus said, “Father, forgive them, for they do not know what they are doing.” And they divided up his clothes by casting lots (Luke 23:34)."
	icon = 'code/modules/ziggers/64x64.dmi'
	icon_state = "cross"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE
	pixel_w = -16
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/structure/roadsign
	name = "road sign"
	desc = "Do not drive your car cluelessly."
	icon = 'code/modules/ziggers/32x48.dmi'
	icon_state = "stop"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE

/obj/structure/roadsign/stop
	name = "stop sign"
	icon_state = "stop"

/obj/structure/roadsign/noparking
	name = "no parking sign"
	icon_state = "noparking"

/obj/structure/roadsign/nopedestrian
	name = "no pedestrian sign"
	icon_state = "nopedestrian"

/obj/structure/roadsign/busstop
	name = "bus stop sign"
	icon_state = "busstop"

/obj/structure/roadsign/speedlimit
	name = "speed limit sign"
	icon_state = "speed50"

/obj/structure/roadsign/warningtrafficlight
	name = "traffic light warning sign"
	icon_state = "warningtrafficlight"

/obj/structure/roadsign/warningpedestrian
	name = "pedestrian warning sign"
	icon_state = "warningpedestrian"

/obj/structure/roadsign/parking
	name = "parking sign"
	icon_state = "parking"

/obj/structure/roadsign/crosswalk
	name = "crosswalk sign"
	icon_state = "crosswalk"

/obj/structure/barrels
	name = "barrel"
	desc = "Storage some liquids."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "barrel1"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE

/obj/structure/barrels/rand
	icon_state = "barrel2"

/obj/structure/barrels/rand/Initialize()
	. = ..()
	icon_state = "barrel[rand(1, 12)]"

/obj/structure/bricks
	name = "bricks"
	desc = "Building material."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "bricks"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE

/obj/effect/decal/pallet
	name = "pallet"
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "under1"

/obj/effect/decal/pallet/Initialize()
	. = ..()
	icon_state = "under[rand(1, 2)]"

/obj/effect/decal/trash
	name = "trash"
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "trash1"

/obj/effect/decal/trash/Initialize()
	. = ..()
	icon_state = "trash[rand(1, 30)]"

/obj/cargotrain
	name = "cargocrate"
	desc = "It delivers a lot of things."
	icon = 'code/modules/ziggers/containers.dmi'
	icon_state = "1"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE
	density = TRUE
	var/mob/living/starter

/obj/cargotrain/Initialize()
	. = ..()
	icon_state = "[rand(2, 5)]"

/obj/cargotrain/Moved(atom/OldLoc, Dir, Forced = FALSE)
	for(var/mob/living/L in get_step(src, Dir))
		if(isnpc(L))
			if(starter)
				if(ishuman(starter))
					var/mob/living/carbon/human/H = starter
					H.AdjustHumanity(-1, 0)
		L.gib()
	..()

/obj/cargocrate
	name = "cargocrate"
	desc = "It delivers a lot of things."
	icon = 'code/modules/ziggers/containers.dmi'
	icon_state = "1"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE


/obj/cargocrate/Initialize()
	. = ..()
	icon_state = "[rand(1, 5)]"
	if(icon_state != "1")
		opacity = TRUE
	density = TRUE
	var/atom/movable/M1 = new(get_step(loc, EAST))
	var/atom/movable/M2 = new(get_step(M1.loc, EAST))
	var/atom/movable/M3 = new(get_step(M2.loc, EAST))
	M1.density = TRUE
	if(icon_state != "1")
		M1.opacity = TRUE
	M1.anchored = TRUE
	M2.density = TRUE
	if(icon_state != "1")
		M2.opacity = TRUE
	M2.anchored = TRUE
	M3.density = TRUE
	if(icon_state != "1")
		M3.opacity = TRUE
	M3.anchored = TRUE

/proc/get_nearest_free_turf(var/turf/start)
	if(isopenturf(get_step(start, EAST)))
		if(isopenturf(get_step(get_step(start, EAST), EAST)))
			if(isopenturf(get_step(get_step(get_step(start, EAST), EAST), EAST)))
				if(isopenturf(get_step(get_step(get_step(get_step(start, EAST), EAST), EAST), EAST)))
					if(isopenturf(get_step(get_step(get_step(get_step(get_step(start, EAST), EAST), EAST), EAST), EAST)))
						if(isopenturf(get_step(get_step(get_step(get_step(get_step(get_step(start, EAST), EAST), EAST), EAST), EAST), EAST)))
							if(isopenturf(get_step(get_step(get_step(get_step(get_step(get_step(get_step(start, EAST), EAST), EAST), EAST), EAST), EAST), EAST)))
								if(isopenturf(get_step(get_step(get_step(get_step(get_step(get_step(get_step(get_step(start, EAST), EAST), EAST), EAST), EAST), EAST), EAST), EAST)))
									if(isopenturf(get_step(get_step(get_step(get_step(get_step(get_step(get_step(get_step(get_step(start, EAST), EAST), EAST), EAST), EAST), EAST), EAST), EAST), EAST)))
										if(isopenturf(get_step(get_step(get_step(get_step(get_step(get_step(get_step(get_step(get_step(get_step(start, EAST), EAST), EAST), EAST), EAST), EAST), EAST), EAST), EAST), EAST)))
											if(isopenturf(get_step(get_step(get_step(get_step(get_step(get_step(get_step(get_step(get_step(get_step(get_step(start, EAST), EAST), EAST), EAST), EAST), EAST), EAST), EAST), EAST), EAST), EAST)))
												return get_step(get_step(get_step(get_step(get_step(get_step(get_step(get_step(get_step(get_step(get_step(start, EAST), EAST), EAST), EAST), EAST), EAST), EAST), EAST), EAST), EAST), EAST)
											return get_step(get_step(get_step(get_step(get_step(get_step(get_step(get_step(get_step(get_step(start, EAST), EAST), EAST), EAST), EAST), EAST), EAST), EAST), EAST), EAST)
										return get_step(get_step(get_step(get_step(get_step(get_step(get_step(get_step(get_step(start, EAST), EAST), EAST), EAST), EAST), EAST), EAST), EAST), EAST)
									return get_step(get_step(get_step(get_step(get_step(get_step(get_step(get_step(start, EAST), EAST), EAST), EAST), EAST), EAST), EAST), EAST)
								return get_step(get_step(get_step(get_step(get_step(get_step(get_step(start, EAST), EAST), EAST), EAST), EAST), EAST), EAST)
							return get_step(get_step(get_step(get_step(get_step(get_step(start, EAST), EAST), EAST), EAST), EAST), EAST)
						return get_step(get_step(get_step(get_step(get_step(start, EAST), EAST), EAST), EAST), EAST)
					return get_step(get_step(get_step(get_step(start, EAST), EAST), EAST), EAST)
				return get_step(get_step(get_step(start, EAST), EAST), EAST)
			return get_step(get_step(start, EAST), EAST)
		return get_step(start, EAST)
	return start

/obj/structure/marketplace
	name = "stock market"
	desc = "Recent stocks visualization."
	icon = 'code/modules/ziggers/stonks.dmi'
	icon_state = "marketplace"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE
	density = TRUE
	pixel_w = -24
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/structure/fuelstation
	name = "fuel station"
	desc = "Fuel your car here. 50 dollars per 1000 units."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "fuelstation"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/stored_money = 0

/obj/structure/fuelstation/AltClick(mob/user)
	if(stored_money)
		say("Money refunded.")
		for(var/i in 1 to stored_money)
			new /obj/item/stack/dollar(loc)
		stored_money = 0

/obj/structure/fuelstation/examine(mob/user)
	. = ..()
	. += "<b>Balance</b>: [stored_money] dollars"

/obj/structure/fuelstation/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/stack/dollar))
		var/obj/item/stack/dollar/D = I
		stored_money += D.amount
		to_chat(user, "<span class='notice'>You insert [D.amount] dollars into [src].</span>")
		qdel(I)
		say("Payment received.")
	if(istype(I, /obj/item/gas_can))
		var/obj/item/gas_can/G = I
		if(G.stored_gasoline < 1000 && stored_money)
			var/gas_to_dispense = min(stored_money*20, 1000-G.stored_gasoline)
			var/money_to_spend = round(gas_to_dispense/20)
			G.stored_gasoline = min(1000, G.stored_gasoline+gas_to_dispense)
			stored_money = max(0, stored_money-money_to_spend)
			playsound(loc, 'code/modules/ziggers/sounds/gas_fill.ogg', 50, TRUE)
			to_chat(user, "<span class='notice'>You fill [I].</span>")
			say("Gas filled.")

/obj/structure/bloodextractor
	name = "blood extractor"
	desc = "Extract blood in packs."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "bloodextractor"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/last_extracted = 0

/mob/living/carbon/human/MouseDrop(atom/over_object)
	. = ..()
	if(istype(over_object, /obj/structure/bloodextractor))
		if(get_dist(src, over_object) < 2)
			var/obj/structure/bloodextractor/V = over_object
			if(!buckled)
				V.visible_message("<span class='warning'>Buckle [src] fist!</span>")
			if(bloodpool < 2)
				V.visible_message("<span class='warning'>[V] can't find enough blood in [src]!</span>")
				return
			if(iskindred(src))
				if(bloodpool < 4)
					V.visible_message("<span class='warning'>[V] can't find enough blood in [src]!</span>")
					return
			if(V.last_extracted+1200 > world.time)
				V.visible_message("<span class='warning'>[V] isn't ready!</span>")
				return
			V.last_extracted = world.time
			if(!iskindred(src))
				new /obj/item/drinkable_bloodpack(get_step(V, SOUTH))
				bloodpool = max(0, bloodpool-2)
			else
				new /obj/item/drinkable_bloodpack/vitae(get_step(V, SOUTH))
				bloodpool = max(0, bloodpool-4)

GLOBAL_LIST_EMPTY(vampire_computers)


/obj/vampire_computer
	name = "computer"
	desc = "See the news of Kindred City."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "computer"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/main = FALSE
	var/datum/app/current_app
	var/datum/app/focus_app
	var/list/datum/app/apps = list()
	var/owner = "none"
	var/logged = FALSE
	var/x_pos = 0
	var/y_pos = 0
	var/password
	var/username


/obj/vampire_computer/Initialize()
	. = ..()
	GLOB.vampire_computers += src
	username = gen_username()
	password = gen_pass()
	var/obj/item/paper/password_paper = new (loc)
	password_paper.name = "don't forget your password!"
	password_paper.info = "<center><h2>Hello, [username]!</h2></center><br>I have to remind you about it again, but please don't forget your password - <b>[password]</b>"
	var/datum/app/icq/icq = new ()
	var/datum/app/notepad/notepad = new ()
	var/datum/app/gmail/gmail = new ()
	var/datum/app/news/news = new ()

	gmail.generate_email()
	if(main)
		news.can_send = TRUE
	// Отправка почты на комп принца от всех, у кого owner это не none, а, например, regent
	apps.Add(icq)
	apps.Add(notepad)
	apps.Add(gmail)
	apps.Add(news)

	for(var/obj/vampire_computer/C in GLOB.vampire_computers)
		if(C.main)
			if(owner != "none")
				var/datum/app/gmail/main_gmail = C.apps[3]
				main_gmail.send_email("Hello! This message is from [owner]'s computer.", "Hello!", gmail.email_adress)

/obj/vampire_computer/attack_hand(mob/user)
	. = ..()
	ui_interact(user)

/obj/vampire_computer/Destroy()
	. = ..()
	GLOB.vampire_computers -= src

/obj/vampire_computer/prince
	icon_state = "computerprince"
	main = TRUE

/obj/vampire_computer/ui_act(action, list/params)
	. = ..()
	if(.)
		return
	switch(action)
		if("set_notepad_text")
			var/datum/app/notepad/app = locate(params["ref"]) in apps
			app.text = params["text"]
			return TRUE
		if("set_current_app")
			current_app = locate(params["ref"]) in apps
			current_app.minimized = FALSE
			return TRUE
		if("set_focus_app")
			var/datum/app/app = locate(params["ref"]) in apps
			focus_app = app
			return TRUE
		if("launch_app")
			var/datum/app/app = locate(params["ref"]) in apps
			if(!app.launched)
				app.launched = TRUE
			else
				app.minimized = FALSE
			current_app = app
			focus_app = null
			if(istype(app, /datum/app/news) && icon_state == "computermessage")
				icon_state = initial(icon_state)
			return TRUE
		if("close")
			var/datum/app/app = locate(params["ref"]) in apps
			app.launched = FALSE
			if(!app.desktop_app)
				apps.Remove(app)
			return TRUE
		if("minimize")
			var/datum/app/app = locate(params["ref"]) in apps
			if(app.minimized)
				app.minimized = FALSE
			else
				app.minimized = TRUE
			current_app = null
			return TRUE
		if("set_app_cords")
			var/datum/app/app = locate(params["ref"]) in apps
			app.x = set_cords(params["rel_x"], 1185, 0)
			app.y = set_cords(params["rel_y"], 600, 0)
			return TRUE
		if("send_message")
			if(params["message"] != "" && params["message"])
				var/datum/app/icq/app = locate(params["ref"]) in apps
				app.SendMessage(params["message"])
				return TRUE
		if("icq_login_user")
			if(params["username"] != "" && params["username"])
				for(var/obj/vampire_computer/C in GLOB.vampire_computers)
					var/datum/app/icq/icq = C.apps[1]
					if(icq.username == params["username"])
						throw_error("This name is already exists!")
						return TRUE
				var/datum/app/icq/app = locate(params["ref"]) in apps
				app.username = params["username"]
				return TRUE
		if("set_email_check")
			var/datum/app/gmail/gmail = apps[3]
			var/datum/email/email = locate(params["ref"]) in gmail.emails
			if(!email.checked)
				email.checked = TRUE
			else
				email.checked = FALSE
			return TRUE
		if("set_email_star")
			var/datum/app/gmail/gmail = apps[3]
			var/datum/email/email = locate(params["ref"]) in gmail.emails
			if(!email.stared)
				email.stared = TRUE
			else
				email.stared = FALSE
			return TRUE
		if("select_all_emails")
			var/datum/app/gmail/gmail = apps[3]
			for(var/datum/email/email in gmail.emails)
				email.checked = TRUE
			return TRUE
		if("deselect_all_emails")
			var/datum/app/gmail/gmail = apps[3]
			for(var/datum/email/email in gmail.emails)
				email.checked = FALSE
			return TRUE
		if("delete_emails")
			var/datum/app/gmail/gmail = apps[3]
			for(var/datum/email/email in gmail.emails)
				if(email.checked)
					gmail.emails.Remove(email)
			return TRUE
		if("gmail_switch_screen")
			var/datum/app/gmail/gmail = apps[3]
			gmail.screen = params["screen"]
			return TRUE
		if("set_current_email")
			var/datum/app/gmail/gmail = apps[3]
			gmail.current_email = locate(params["ref"]) in gmail.emails
			return TRUE
		if("news_send_message")
			if(params["message"] != "" && params["message"])
				for(var/obj/vampire_computer/C in GLOB.vampire_computers)
					var/datum/app/news/news = C.apps[4]
					news.text = params["message"]
					message_admins("[usr]([usr.key]) send an announcement:\"- [params["message"]]\"")
					if(!C.main)
						C.say("New announcement from Prince!")
						C.icon_state = "computermessage"
					else
						C.say("Announcement sent.")
			return TRUE
		if("delete_email")
			var/datum/app/gmail/gmail = apps[3]
			var/datum/email/email = locate(params["ref"]) in gmail.emails
			gmail.emails.Remove(email)
			gmail.screen = 1
			return TRUE
		if("gmail_send_email")
			var/datum/app/gmail/gmail = apps[3]
			if(!params["message"])
				throw_error("You must write a message!")
				return TRUE
			else if(!params["subject"])
				throw_error("You must write a subject!")
				return TRUE
			else if(!params["to"])
				throw_error("You must write a reciever adress!")
				return TRUE
			var/sended = gmail.send_email(params["message"], params["subject"], params["to"])
			if(!sended)
				throw_error("This email is not exists!")
			return TRUE
		if("login")
			if(params["username"] == username && params["password"] == password)
				playsound(loc, 'sound/winxp/startup.wav', 100)
				logged = TRUE
				return TRUE
			else
				playsound(loc, 'sound/winxp/error.wav', 100)
				return TRUE

/obj/vampire_computer/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "WindowsXP", "WindowsXP")
		ui.open()

/obj/vampire_computer/proc/throw_error(error)
	playsound(loc, 'sound/winxp/error.wav', 100)
	var/datum/app/error/error_app = new ()
	error_app.error_message = error
	error_app.launched = TRUE
	current_app = error_app
	apps.Add(error_app)

/obj/vampire_computer/proc/set_cords(cord, max, min)
	if(cord < max && cord > min)
		return cord
	else if(cord > max)
		return max
	else if(cord < min)
		return min


/obj/vampire_computer/ui_data(mob/user)
	var/list/data = list()
	var/list/data_apps = list()

	for(var/datum/app/app in apps)
		var/list/app_data = app.data()
		app_data["reference"] =REF(app)
		data_apps += list(app_data)

	data["apps"] = data_apps
	data["current_app"] = 0
	if(current_app)
		data["current_app"] = REF(current_app)

	data["focus_ref"] = REF(focus_app)
	data["logged"] = logged
	data["password"] = password
	data["x"] = x_pos
	data["y"] = y_pos
	return data

/obj/vampire_computer/proc/gen_username()
	var/name = pick(GLOB.first_names_male + GLOB.first_names_female)
	name += pick("1", "2", "3", "4", "5", "6", "7", "8", "9", "0")
	name += pick("1", "2", "3", "4", "5", "6", "7", "8", "9", "0")
	return name

/obj/vampire_computer/proc/gen_pass()
	var/newPass
	newPass += pick("the", "if", "of", "as", "in", "a", "you", "from", "to", "an", "too", "little", "snow", "dead", "drunk", "rosebud", "duck", "al", "le")
	newPass += pick("diamond", "beer", "mushroom", "assistant", "clown", "captain", "twinkie", "security", "nuke", "small", "big", "escape", "yellow", "gloves", "monkey", "engine", "nuclear", "ai")
	newPass += pick("1", "2", "3", "4", "5", "6", "7", "8", "9", "0")
	return newPass




/datum/app
	var/title
	var/x = 50
	var/y = 50
	var/minimized= FALSE
	var/launched = FALSE
	var/app_type
	var/width = 660
	var/height = 500
	var/desktop_app = TRUE

/datum/app/proc/data()
	var/list/data = list()
	data["launched"]= launched
	data["type"]= app_type
	data["title"]= title
	data["minimized"]= minimized
	data["x"]= x
	data["y"]= y
	data["width"]= width
	data["height"]= height
	data["desktop_app"]= desktop_app
	return data

/datum/app/icq
	title = "ICQ"
	app_type = "icq"
	var/list/datum/message/messages = list()
	var/username = ""

/datum/app/icq/proc/SendMessage(message)
	var/datum/message/send = new(username, message)
	for(var/obj/vampire_computer/C in GLOB.vampire_computers)
		var/datum/app/icq/app = C.apps[1]
		app.messages += send

/datum/app/icq/data()
	. = ..()
	. += list("username" = username)
	var/list/data_messages = list()
	for(var/datum/message/message in messages)
		data_messages += list(list("author" = message.author, "message" = message.message))
	. += list("messages" = data_messages)

/datum/message
	var/author
	var/message

/datum/message/New(param_author, param_message)
	author = param_author
	message = param_message

/datum/app/error
	title = "Error!"
	app_type = "error"
	width = 330
	height = 100
	x = 300
	y = 300
	desktop_app = FALSE
	var/error_message

/datum/app/error/data()
	. = ..()
	. += list("error_message" = error_message)

/datum/app/notepad
	title = "Notepad"
	app_type = "notepad"
	var/text
	var/wordWrap = FALSE

/datum/app/notepad/data()
	. = ..()
	. += list("text" = text)
	. += list("wordWrap" = wordWrap)

/datum/app/gmail
	title = "Gmail"
	app_type = "gmail"
	var/list/datum/email/emails = list()
	var/email_adress = "test@gmail.com"
	var/screen = 1
	var/datum/email/current_email

/datum/app/gmail/data()
	. = ..()
	.+=list("email_adress" = email_adress)
	var/list/data_emails = list()
	for(var/datum/email/email in emails)
		var/list/data_email = email.to_data()
		data_email["reference"] = REF(email)
		data_emails += list(data_email)
	. += list("emails" = data_emails)
	. += list("screen" = screen)
	if(current_email)
		var/list/data_current_email = current_email.to_data()
		data_current_email["reference"] = REF(current_email)
		. += list("current_email" = data_current_email)


/datum/app/gmail/proc/send_email(param_message, params_subject, params_to)
	var/datum/email/email = new (email_adress, param_message, params_subject)
	for(var/obj/vampire_computer/C in GLOB.vampire_computers)
		var/datum/app/gmail/gmail = C.apps[3]
		if(gmail.email_adress == params_to)
			gmail.emails.Add(email)
			screen = 1
			return TRUE
	return FALSE

/datum/app/gmail/proc/generate_email()
	var/newEmail
	newEmail += pick("the", "if", "of", "as", "in", "a", "you", "from", "to", "an", "too", "little", "snow", "dead", "drunk", "rosebud", "duck", "al", "le")
	newEmail += pick("diamond", "beer", "mushroom", "assistant", "clown", "captain", "twinkie", "security", "nuke", "small", "big", "escape", "yellow", "gloves", "monkey", "engine", "nuclear", "ai")
	newEmail += pick("1", "2", "3", "4", "5", "6", "7", "8", "9", "0")
	newEmail += pick("1", "2", "3", "4", "5", "6", "7", "8", "9", "0")
	newEmail += "@gmail.com"
	email_adress = newEmail

/datum/email
	var/sender
	var/message
	var/date
	var/checked = FALSE
	var/stared = FALSE
	var/email_title = "none"
	var/subject

/datum/email/New(param_sender, param_message, param_subject)
	sender = param_sender
	subject = param_subject
	message = param_message
	date = SScity_time.timeofnight

/datum/email/proc/to_data()
	var/list/data = list("subject"=subject, "sender" = sender, "message" = message, "date" = date, "checked" = checked, "stared" = stared)
	return data

/datum/app/news
	title = "News"
	app_type = "news"
	var/text = "No messages"
	var/can_send = FALSE

/datum/app/news/data()
	.=..()
	. += list("text"=text)
	. += list("can_send"=can_send)

/obj/structure/rack/tacobell
	name = "table"
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "tacobell"

/obj/structure/rack/tacobell/attack_hand(mob/living/user)
	return

/obj/structure/rack/tacobell/horizontal
	icon_state = "tacobell1"

/obj/structure/rack/tacobell/vertical
	icon_state = "tacobell2"

/obj/structure/rack/tacobell/south
	icon_state = "tacobell3"

/obj/structure/rack/tacobell/north
	icon_state = "tacobell4"

/obj/structure/rack/tacobell/east
	icon_state = "tacobell5"

/obj/structure/rack/tacobell/west
	icon_state = "tacobell6"

/obj/structure/rack/bubway
	name = "table"
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "bubway"

/obj/structure/rack/bubway/attack_hand(mob/living/user)
	return

/obj/structure/rack/bubway/horizontal
	icon_state = "bubway1"

/obj/structure/rack/bubway/vertical
	icon_state = "bubway2"

/obj/structure/rack/bubway/south
	icon_state = "bubway3"

/obj/structure/rack/bubway/north
	icon_state = "bubway4"

/obj/structure/rack/bubway/east
	icon_state = "bubway5"

/obj/structure/rack/bubway/west
	icon_state = "bubway6"

/obj/bacotell
	name = "Baco Tell"
	desc = "Eat some precious tacos and pizza!"
	icon = 'code/modules/ziggers/fastfood.dmi'
	icon_state = "bacotell"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE
	pixel_w = -16

/obj/bubway
	name = "BubWay"
	desc = "Eat some precious burgers and pizza!"
	icon = 'code/modules/ziggers/fastfood.dmi'
	icon_state = "bubway"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE
	pixel_w = -16

/obj/gummaguts
	name = "Gumma Guts"
	desc = "Eat some precious chicken nuggets and donuts!"
	icon = 'code/modules/ziggers/fastfood.dmi'
	icon_state = "gummaguts"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE
	pixel_w = -16

/obj/underplate
	name = "underplate"
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "underplate"
	plane = GAME_PLANE
	layer = TABLE_LAYER
	anchored = TRUE

/obj/underplate/stuff
	icon_state = "stuff"

/obj/order
	name = "order sign"
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "order"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE

/obj/order1
	name = "order screen"
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "order1"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE

/obj/order2
	name = "order screen"
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "order2"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE

/obj/order3
	name = "order screen"
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "order3"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE

/obj/order4
	name = "order screen"
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "order4"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE

/obj/matrix
	name = "matrix"
	desc = "Suicide is no exit..."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "matrix"
	plane = GAME_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER
	anchored = TRUE
	opacity = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/matrixing = FALSE

/obj/matrix/attack_hand(mob/user)
	if(user.client)
		if(!matrixing)
			matrixing = TRUE
			if(do_after(user, 100, src))
				cryoMob(user, src)
				matrixing = FALSE
			else
				matrixing = FALSE
	return TRUE

/proc/cryoMob(mob/living/mob_occupant, obj/pod)
	if(isnpc(mob_occupant))
		return
	var/list/crew_member = list()
	crew_member["name"] = mob_occupant.real_name

	if(mob_occupant.mind)
		// Handle job slot/tater cleanup.
		var/job = mob_occupant.mind.assigned_role
		crew_member["job"] = job
		SSjob.FreeRole(job)
//		if(LAZYLEN(mob_occupant.mind.objectives))
//			mob_occupant.mind.objectives.Cut()
		mob_occupant.mind.special_role = null
	else
		crew_member["job"] = "N/A"

	if (pod)
		pod.visible_message("\The [pod] hums and hisses as it teleports [mob_occupant.real_name].")

	var/list/gear = list()
	if(ishuman(mob_occupant))		// sorry simp-le-mobs deserve no mercy
		var/mob/living/carbon/human/C = mob_occupant
		if(C.bloodhunted)
			SSbloodhunt.hunted -= C
			C.bloodhunted = FALSE
			SSbloodhunt.update_shit()
		if(C.dna)
			GLOB.fucking_joined -= C.dna.real_name
		gear = C.get_all_gear()
		for(var/obj/item/item_content as anything in gear)
			qdel(item_content)
		for(var/mob/living/L in mob_occupant.GetAllContents() - mob_occupant)
			L.forceMove(pod.loc)
		if(mob_occupant.client)
			mob_occupant.client.screen.Cut()
//			mob_occupant.client.screen += mob_ocupant.client.void
			var/mob/dead/new_player/M = new /mob/dead/new_player()
			M.key = mob_occupant.key
	QDEL_NULL(mob_occupant)

/obj/structure/billiard_table
	name = "billiard table"
	desc = "Come here, play some BALLS. I know you want it so much..."
	icon = 'code/modules/ziggers/32x48.dmi'
	icon_state = "billiard1"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE
	density = TRUE

/obj/structure/billiard_table/Initialize()
	. = ..()
	icon_state = "billiard[rand(1, 3)]"

/obj/police_department
	name = "San Francisco Police Demartment"
	desc = "Stop right there you criminal scum! Nobody can break the law in my watch!!"
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "police"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE
	pixel_z = 40

/obj/structure/pole
	name = "stripper pole"
	desc = "A pole fastened to the ceiling and floor, used to show of ones goods to company."
	icon = 'code/modules/ziggers/64x64.dmi'
	icon_state = "pole"
	density = TRUE
	anchored = TRUE
	var/icon_state_inuse
	layer = 4 //make it the same layer as players.
	density = 0 //easy to step up on

/obj/structure/pole/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	if(obj_flags & IN_USE)
		to_chat(user, "It's already in use - wait a bit.")
		return
	if(user.dancing)
		return
	else
		obj_flags |= IN_USE
		user.setDir(SOUTH)
		user.Stun(100)
		user.forceMove(src.loc)
		user.visible_message("<B>[user] dances on [src]!</B>")
		animatepole(user)
		user.layer = layer //set them to the poles layer
		obj_flags &= ~IN_USE
		user.pixel_y = 0
		icon_state = initial(icon_state)

/obj/structure/pole/proc/animatepole(mob/living/user)
	return

/obj/structure/pole/animatepole(mob/living/user)

	if (user.loc != src.loc)
		return
	animate(user,pixel_x = -6, pixel_y = 0, time = 10)
	sleep(20)
	user.dir = 4
	animate(user,pixel_x = -6,pixel_y = 24, time = 10)
	sleep(12)
	src.layer = 4.01 //move the pole infront for now. better to move the pole, because the character moved behind people sitting above otherwise
	animate(user,pixel_x = 6,pixel_y = 12, time = 5)
	user.dir = 8
	sleep(6)
	animate(user,pixel_x = -6,pixel_y = 4, time = 5)
	user.dir = 4
	src.layer = 4 // move it back.
	sleep(6)
	user.dir = 1
	animate(user,pixel_x = 0, pixel_y = 0, time = 3)
	sleep(6)
	user.do_jitter_animation()
	sleep(6)
	user.dir = 2

/obj/structure/strip_club
	name = "sign"
	desc = "It says DO RA. Maybe it's some kind of strip club..."
	icon = 'code/modules/ziggers/48x48.dmi'
	icon_state = "dora"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	pixel_w = -8
	pixel_z = 32

/obj/structure/strip_club/Initialize()
	. = ..()
	set_light(3, 2, "#8e509e")

/obj/structure/fire_barrel
	name = "barrel"
	desc = "Some kind of light and warm source..."
	icon = 'code/modules/ziggers/icons.dmi'
	icon_state = "barrel"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE
	density = TRUE

/obj/structure/fire_barrel/Initialize()
	. = ..()
	set_light(3, 2, "#ffa800")

/obj/structure/fountain
	name = "fountain"
	desc = "Gothic water structure."
	icon = 'code/modules/ziggers/fountain.dmi'
	icon_state = "fountain"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE
	density = TRUE
	pixel_w = -16
	pixel_z = -16

/obj/structure/coclock
	name = "clock"
	desc = "See the time."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "clock"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE
	pixel_z = 32

/obj/structure/coclock/examine(mob/user)
	. = ..()
	to_chat(user, "<b>[SScity_time.timeofnight]</b>")

/obj/structure/coclock/grandpa
	icon = 'code/modules/ziggers/grandpa_cock.dmi'
	icon_state = "cock"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE
	density = TRUE
	pixel_z = 0

/turf/open/floor/plating/bloodshit
	gender = PLURAL
	name = "blood"
	icon = 'code/modules/ziggers/tiles.dmi'
	icon_state = "blood"
	flags_1 = NONE
	attachment_holes = FALSE
	bullet_bounce_sound = null
	footstep = FOOTSTEP_WATER
	barefootstep = FOOTSTEP_WATER
	clawfootstep = FOOTSTEP_WATER
	heavyfootstep = FOOTSTEP_WATER

/turf/open/floor/plating/bloodshit/Initialize()
	. = ..()
	for(var/mob/living/L in src)
		if(L)
			L.death()
	spawn(5)
		for(var/turf/T in range(1, src))
			if(T && !istype(T, /turf/open/floor/plating/bloodshit))
				new /turf/open/floor/plating/bloodshit(T)

/obj/american_flag
	name = "american flag"
	desc = "PATRIOTHICC!!!"
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "america"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE

/obj/effect/decal/graffiti
	name = "graffiti"
	icon = 'code/modules/ziggers/32x48.dmi'
	icon_state = "graffiti1"
	pixel_z = 32
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE
	var/large = FALSE

/obj/effect/decal/graffiti/large
	pixel_w = -16
	icon = 'code/modules/ziggers/64x64.dmi'
	large = TRUE

/obj/effect/decal/graffiti/Initialize()
	. = ..()
	if(!large)
		icon_state = "graffiti[rand(1, 15)]"
	else
		icon_state = "graffiti[rand(1, 3)]"

/obj/structure/roofstuff
	name = "roof ventilation"
	desc = "Air to inside."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "roof1"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE

/obj/structure/roofstuff/Initialize()
	. = ..()
	if(GLOB.winter)
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "[initial(icon_state)]-snow"

/obj/structure/roofstuff/alt1
	icon_state = "roof2"
	density = FALSE

/obj/structure/roofstuff/alt2
	icon_state = "roof3"

/obj/structure/roofstuff/alt3
	icon_state = "roof4"

/obj/effect/decal/baalirune
	name = "satanic rune"
	pixel_w = -16
	pixel_z = -16
	icon = 'code/modules/ziggers/64x64.dmi'
	icon_state = "baali"
	var/total_corpses = 0

/obj/effect/decal/baalirune/attack_hand(mob/living/user)
	. = ..()
	var/mob/living/carbon/human/H = locate() in get_turf(src)
	if(H)
		if(H.stat == DEAD)
			H.gib()
			total_corpses += 1
			if(total_corpses >= 20)
				total_corpses = 0
				playsound(get_turf(src), 'sound/magic/demon_dies.ogg', 100, TRUE)
				new /mob/living/simple_animal/hostile/baali_guard(get_turf(src))
//			var/datum/preferences/P = GLOB.preferences_datums[ckey(user.key)]
//			if(P)
//				P.exper = min(calculate_mob_max_exper(user), P.exper+15)

/obj/structure/vamptree
	name = "tree"
	desc = "Cute and tall flora."
	icon = 'code/modules/ziggers/trees.dmi'
	icon_state = "tree1"
	plane = GAME_PLANE
	layer = SPACEVINE_LAYER
	anchored = TRUE
	density = TRUE
	pixel_w = -32
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	var/burned = FALSE

/obj/structure/vamptree/Initialize()
	. = ..()
	icon_state = "tree[rand(1, 11)]"
	if(GLOB.winter)
		if(istype(get_area(src), /area/vtm))
			var/area/vtm/V = get_area(src)
			if(V.upper)
				icon_state = "[initial(icon_state)][rand(1, 11)]-snow"

/obj/structure/vamptree/proc/burnshit()
	if(!burned)
		burned = TRUE
		icon_state = "dead[rand(1, 3)]"

/obj/structure/vamptree/pine
	name = "pine"
	desc = "Cute and tall flora."
	icon = 'code/modules/ziggers/pines.dmi'
	icon_state = "pine1"
	plane = GAME_PLANE
	layer = SPACEVINE_LAYER
	anchored = TRUE
	density = TRUE
	pixel_w = -24
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/structure/vamptree/pine/Initialize()
	. = ..()
	icon_state = "pine[rand(1, 4)]"
	if(prob(2))
		burned = TRUE
		icon_state = "dead[rand(1, 5)]"

/obj/structure/vamptree/pine/burnshit()
	if(!burned)
		burned = TRUE
		icon_state = "dead[rand(1, 5)]"

/obj/structure/vampstatue
	name = "statue"
	desc = "Epic kind of art."
	icon = 'icons/effects/32x64.dmi'
	icon_state = "statue"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/weapon_showcase
	name = "weapon showcase"
	desc = "Look, a gun."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "showcase"
	density = TRUE
	anchored = TRUE
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/weapon_showcase/Initialize()
	. = ..()
	icon_state = "showcase[rand(1, 7)]"

/obj/effect/decal/carpet
	name = "carpet"
	pixel_w = -16
	pixel_z = -16
	icon = 'code/modules/ziggers/64x64.dmi'
	icon_state = "kover"

/obj/structure/vamprocks
	name = "rock"
	desc = "Rokk."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "rock1"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/structure/vamprocks/Initialize()
	. = ..()
	icon_state = "rock[rand(1, 9)]"

/obj/structure/small_vamprocks
	name = "rock"
	desc = "Rokk."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "smallrock1"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF

/obj/structure/small_vamprocks/Initialize()
	. = ..()
	icon_state = "smallrock[rand(1, 6)]"

/obj/structure/big_vamprocks
	name = "rock"
	desc = "Rokk."
	icon = 'code/modules/ziggers/64x64.dmi'
	icon_state = "rock1"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	pixel_w = -16

/obj/structure/big_vamprocks/Initialize()
	. = ..()
	icon_state = "rock[rand(1, 4)]"

/obj/structure/stalagmite
	name = "stalagmite"
	desc = "Rokk."
	icon = 'code/modules/ziggers/64x64.dmi'
	icon_state = "stalagmite1"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	pixel_w = -16

/obj/structure/stalagmite/Initialize()
	. = ..()
	icon_state = "stalagmite[rand(1, 5)]"