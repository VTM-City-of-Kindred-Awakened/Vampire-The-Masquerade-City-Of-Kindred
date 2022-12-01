/area/vtm
	name = "San Francisco"
	icon = 'code/modules/ziggers/tiles.dmi'
	icon_state = "sewer"
	requires_power = FALSE
	has_gravity = STANDARD_GRAVITY
	dynamic_lighting = DYNAMIC_LIGHTING_FORCED
	var/music

/area/vtm/interior
	name = "Interior"
	icon_state = "interior"
	ambience_index = AMBIENCE_INTERIOR

/area/vtm/financialdistrict
	name = "Financial District"
	icon_state = "financialdistrict"
	ambience_index = AMBIENCE_CITY
	music = /datum/vampiremusic/downtown

/area/vtm/ghetto
	name = "Ghetto"
	icon_state = "ghetto"
	ambience_index = AMBIENCE_CITY
	music = /datum/vampiremusic/downtown

/area/vtm/pacificheights
	name = "Pacific Heights"
	icon_state = "pacificheights"
	ambience_index = AMBIENCE_NATURE
	music = /datum/vampiremusic/hollywood

/area/vtm/chinatown
	name = "Chinatown"
	icon_state = "chinatown"
	ambience_index = AMBIENCE_CITY
	music = /datum/vampiremusic/chinatown

/area/vtm/fishermanswharf
	name = "Fisherman's Wharf"
	icon_state = "fishermanswharf"
	ambience_index = AMBIENCE_CITY
	music = /datum/vampiremusic/santamonica

/area/vtm/northbeach
	name = "North Beach"
	icon_state = "northbeach"
	ambience_index = AMBIENCE_BEACH
	music = /datum/vampiremusic/santamonica

/area/vtm/unionsquare
	name = "Union Square"
	icon_state = "unionsquare"
	ambience_index = AMBIENCE_CITY
	music = /datum/vampiremusic/downtown

/area/vtm/prince
	name = "Prince Tower"
	icon_state = "prince"
	ambience_index = AMBIENCE_INTERIOR

/area/vtm/camarilla
	name = "Camarilla Appartements"
	icon_state = "camarilla"
	ambience_index = AMBIENCE_INTERIOR

/area/vtm/cabinet
	name = "Prince Cabinet"
	icon_state = "prince"
	ambience_index = AMBIENCE_INTERIOR
	music = /datum/vampiremusic/prince

/area/vtm/clinic
	name = "Clinic"
	icon_state = "clinic"
	ambience_index = AMBIENCE_INTERIOR

/area/vtm/supply
	name = "Supply"
	icon_state = "supply"
	ambience_index = AMBIENCE_INTERIOR

/area/vtm/anarch
	name = "Bar"
	icon_state = "anarch"
	ambience_index = AMBIENCE_INTERIOR

/area/vtm/hotel
	name = "Hotel"
	icon_state = "hotel"
	ambience_index = AMBIENCE_INTERIOR

/area/vtm/church
	name = "Church"
	icon_state = "church"
	ambience_index = AMBIENCE_INTERIOR

/area/vtm/graveyard
	name = "Graveyard"
	icon_state = "graveyard"
	ambience_index = AMBIENCE_INTERIOR
	music = /datum/vampiremusic/hollywood

/area/vtm/park
	name = "Park"
	icon_state = "park"
	ambience_index = AMBIENCE_NATURE
	music = /datum/vampiremusic/downtown

/area/vtm/theatre
	name = "Theatre"
	icon_state = "theatre"
	ambience_index = AMBIENCE_INTERIOR

/area/vtm/sewer
	name = "Sewer"
	icon_state = "sewer"
	ambience_index = AMBIENCE_SEWER
	music = /datum/vampiremusic/sewer

//MUSIC

/datum/vampiremusic
	var/length = 30 SECONDS
	var/sound
	var/forced = FALSE

/datum/vampiremusic/santamonica
	length = 304 SECONDS
	sound = 'code/modules/ziggers/sounds/santamonica.ogg'

/datum/vampiremusic/downtown
	length = 259 SECONDS
	sound = 'code/modules/ziggers/sounds/downtown.ogg'

/datum/vampiremusic/sewer
	length = 134 SECONDS
	sound = 'code/modules/ziggers/sounds/enterlair.ogg'
	forced = TRUE

/datum/vampiremusic/hollywood
	length = 337 SECONDS
	sound = 'code/modules/ziggers/sounds/hollywood.ogg'

/datum/vampiremusic/chinatown
	length = 369 SECONDS
	sound = 'code/modules/ziggers/sounds/chinatown.ogg'

/datum/vampiremusic/prince
	length = 314 SECONDS
	sound = 'code/modules/ziggers/sounds/clairedelune.ogg'
	forced = TRUE

/mob/living
	var/last_vampire_ambience = 0
	var/wait_for_music = 30
	var/wasforced

/mob/living/proc/handle_vampire_music()
	if(!client)
		return
	if(stat == DEAD)
		return
	if(!isturf(loc))
		return

	if(istype(get_area(loc), /area/vtm))
		var/area/vtm/VTM = get_area(loc)
		if(!VTM.music)
			client << sound(null, 0, 0, CHANNEL_LOBBYMUSIC)
			last_vampire_ambience = 0
			wait_for_music = 0
			return
		var/datum/vampiremusic/VMPMSC = new VTM.music()
		if(VMPMSC.forced && wait_for_music != VMPMSC.length)
			client << sound(null, 0, 0, CHANNEL_LOBBYMUSIC)
			last_vampire_ambience = 0
			wait_for_music = 0
			wasforced = TRUE

		else if(wasforced && wait_for_music != VMPMSC.length)
			client << sound(null, 0, 0, CHANNEL_LOBBYMUSIC)
			last_vampire_ambience = 0
			wait_for_music = 0
			wasforced = FALSE

		if(last_vampire_ambience+wait_for_music+10 < world.time)
			wait_for_music = VMPMSC.length
			client << sound(VMPMSC.sound, 0, 0, CHANNEL_LOBBYMUSIC, 15)
			last_vampire_ambience = world.time
		qdel(VMPMSC)
