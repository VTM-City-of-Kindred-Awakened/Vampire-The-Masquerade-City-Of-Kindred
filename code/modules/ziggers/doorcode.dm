/obj/item/vamp/keys
	name = "\improper keys"
	desc = "Those can open some doors."
	icon = 'code/modules/ziggers/items.dmi'
	icon_state = "keys"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_TINY
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	onflooricon = 'code/modules/ziggers/onfloor.dmi'

	var/list/accesslocks = list("nothing")

/obj/item/vamp/keys/camarilla
	accesslocks = list("camarilla")

/obj/item/vamp/keys/prince
	accesslocks = list("camarilla",
											"prince",
											"clerk",
											"archive")

/obj/item/vamp/keys/sheriff
	accesslocks = list("camarilla",
											"prince",
											"archive")

/obj/item/vamp/keys/clerk
	accesslocks = list("camarilla",
											"clerk",
											"archive")

/obj/item/vamp/keys/graveyard
	accesslocks = list("graveyard")

/obj/item/vamp/keys/clinic
	accesslocks = list("clinic")

/obj/item/vamp/keys/cleaning
	accesslocks = list("cleaning")

/obj/item/vamp/keys/archive
	accesslocks = list("archive")

/obj/item/vamp/keys/anarch
	accesslocks = list("anarch")

/obj/item/vamp/keys/bar
	accesslocks = list("bar",
											"anarch",
											"supply")

/obj/item/vamp/keys/supply
	accesslocks = list("supply",
											"anarch")

/obj/structure/vampdoor
	name = "\improper door"
	desc = "It opens and closes."
	icon = 'code/modules/ziggers/doors.dmi'
	icon_state = "door-1"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	pixel_w = -16
	anchored = TRUE
	density = TRUE
	opacity = TRUE

	var/baseicon = "door"
	var/lastclicked = 0

	var/closed = TRUE
	var/locked = FALSE
	var/lock_id = "nothing"
	var/glass = FALSE

	var/open_sound = 'code/modules/ziggers/door_open.ogg'
	var/close_sound = 'code/modules/ziggers/door_close.ogg'
	var/lock_sound = 'code/modules/ziggers/door_locked.ogg'

/obj/structure/vampdoor/attack_hand(mob/user)
	if(lastclicked+20 > world.time)
		return
	lastclicked = world.time
	if(locked)
		playsound(src, lock_sound, 75, TRUE)
		to_chat(user, "[src] is locked!")
		return

	if(closed)
		playsound(src, open_sound, 75, TRUE)
		icon_state = "[baseicon]-0"
		density = FALSE
		opacity = FALSE
		layer = OPEN_DOOR_LAYER
		to_chat(user, "You open [src].")
	else
		playsound(src, close_sound, 75, TRUE)
		icon_state = "[baseicon]-1"
		density = TRUE
		if(!glass)
			opacity = TRUE
		layer = ABOVE_ALL_MOB_LAYER
		to_chat(user, "You close [src].")

/obj/structure/vampdoor/attackby(obj/item/W, mob/living/user, params)
	if(lastclicked+20 > world.time)
		return
	lastclicked = world.time
	if(istype(W, /obj/item/vamp/keys))
		var/obj/item/vamp/keys/KEY = W
		if(KEY.accesslocks)
			for(var/i in KEY.accesslocks)
				if(i == lock_id)
					if(!locked)
						playsound(src, lock_sound, 75, TRUE)
						to_chat(user, "[src] is now locked.")
						locked = TRUE
					else
						playsound(src, lock_sound, 75, TRUE)
						to_chat(user, "[src] is now unlocked.")
						locked = FALSE

/obj/structure/vampdoor/old
	icon_state = "old-1"
	baseicon = "old"

/obj/structure/vampdoor/simple
	icon_state = "cam-1"
	baseicon = "cam"

/obj/structure/vampdoor/reinf
	icon_state = "reinf-1"
	baseicon = "reinf"

/obj/structure/vampdoor/prison
	icon_state = "prison-1"
	opacity = FALSE
	baseicon = "prison"
	glass = TRUE

/obj/structure/vampdoor/wood
	icon_state = "wood-1"
	baseicon = "wood"

/obj/structure/vampdoor/wood/old
	icon_state = "oldwood-1"
	baseicon = "oldwood"

/obj/structure/vampdoor/glass
	icon_state = "glass-1"
	opacity = FALSE
	baseicon = "glass"
	glass = TRUE

/obj/structure/vampdoor/shop
	icon_state = "shop-1"
	opacity = FALSE
	baseicon = "shop"
	glass = TRUE

/obj/structure/vampdoor/camarilla
	icon_state = "cam-1"
	baseicon = "cam"
	locked = TRUE
	lock_id = "camarilla"

/obj/structure/vampdoor/clerk
	icon_state = "shop-1"
	opacity = FALSE
	baseicon = "shop"
	glass = TRUE
	locked = TRUE
	lock_id = "clerk"

/obj/structure/vampdoor/prince
	icon_state = "glass-1"
	opacity = FALSE
	baseicon = "glass"
	glass = TRUE
	locked = TRUE
	lock_id = "prince"

/obj/structure/vampdoor/graveyard
	icon_state = "oldwood-1"
	baseicon = "oldwood"
	locked = TRUE
	lock_id = "graveyard"

/obj/structure/vampdoor/clinic
	icon_state = "shop-1"
	opacity = FALSE
	baseicon = "shop"
	glass = TRUE
	locked = TRUE
	lock_id = "clinic"

/obj/structure/vampdoor/cleaning
	icon_state = "reinf-1"
	baseicon = "reinf"
	locked = TRUE
	lock_id = "cleaning"

/obj/structure/vampdoor/archive
	icon_state = "old-1"
	baseicon = "old"
	locked = TRUE
	lock_id = "archive"

/obj/structure/vampdoor/anarch
	icon_state = "cam-1"
	baseicon = "cam"
	locked = TRUE
	lock_id = "anarch"

/obj/structure/vampdoor/bar
	icon_state = "cam-1"
	baseicon = "cam"
	locked = TRUE
	lock_id = "bar"

/obj/structure/vampdoor/supply
	icon_state = "cam-1"
	baseicon = "cam"
	locked = TRUE
	lock_id = "supply"

/obj/structure/vampdoor/npc
	icon_state = "wood-1"
	baseicon = "wood"
	locked = TRUE
	lock_id = "npc"