SUBSYSTEM_DEF(factionwar)
	name = "Faction War"
	init_order = INIT_ORDER_DEFAULT
	wait = 6000
	priority = FIRE_PRIORITY_DEFAULT

	var/list/marks_camarilla = list()
	var/list/marks_anarch = list()
	var/list/marks_sabbat = list()

/datum/controller/subsystem/factionwar/fire()
	return

/datum/controller/subsystem/factionwar/proc/move_mark(var/obj/graffiti/G, var/frakcja)
	switch(frakcja)
		if("camarilla")
			marks_anarch -= G
			marks_sabbat -= G
			marks_camarilla |= G
		if("anarch")
			marks_camarilla -= G
			marks_sabbat -= G
			marks_anarch |= G
		if("sabbat")
			marks_camarilla -= G
			marks_anarch -= G
			marks_sabbat |= G

/mob/living
	var/frakcja

/obj/graffiti
	name = "faction mark"
	desc = "Reminds anyone who sees it which faction it belongs to..."
	icon = 'code/modules/ziggers/48x48.dmi'
	plane = GAME_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER
	anchored = TRUE
	pixel_w = -8
	pixel_z = -8
	alpha = 128
	var/repainting = FALSE

/obj/graffiti/Initialize()
	. = ..()
	if(icon_state)
		SSfactionwar.move_mark(src, icon_state)

/obj/graffiti/camarilla
	icon_state = "camarilla"

/obj/graffiti/anarch
	icon_state = "anarch"

/obj/graffiti/sabbat
	icon_state = "sabbat"

/obj/graffiti/AltClick(mob/user)
	..()
	if(isliving(user))
		var/mob/living/L = user
		if(!L.frakcja)
			to_chat(user, "You don't belong to any faction, so you can't repaint it.")
			return
		if(L.frakcja != icon_state)
			if(!repainting)
				repainting = TRUE
				if(do_mob(user, src, 10 SECONDS))
					icon_state = L.frakcja
					SSfactionwar.move_mark(src, L.frakcja)
					if(user.client)
						user.client.prefs.exper = min(calculate_mob_max_exper(user), user.client.prefs.exper+50)
						to_chat(user, "Successfuly repainted to [L.frakcja]'s mark.")
					repainting = FALSE
				else
					repainting = FALSE
		else
			to_chat(user, "Your faction already own this.")