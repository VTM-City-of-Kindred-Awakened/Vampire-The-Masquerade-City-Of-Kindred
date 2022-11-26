/obj/damap
	icon = 'code/modules/ziggers/map.dmi'
	icon_state = "map"
	plane = GAME_PLANE
	layer = ABOVE_NORMAL_TURF_LAYER

/obj/structure/vampmap
	name = "\improper map"
	desc = "Locate yourself now."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "map"
	plane = GAME_PLANE
	layer = ABOVE_ALL_MOB_LAYER
	anchored = TRUE
	density = TRUE

/obj/structure/vampmap/attack_hand(mob/user)
	. = ..()
	var/dat = {"
			<style type="text/css">

			body {
				background-color: #090909; color: white;
			}

			</style>
			"}
	var/obj/damap/DAMAP = new(user)
	var/mutable_appearance/targeticon = mutable_appearance(DAMAP.icon, "target", ABOVE_MOB_LAYER)
	targeticon.pixel_w = user.x-127
	targeticon.pixel_z = user.y-127
	DAMAP.add_overlay(targeticon)
	dat += "<center>[icon2html(getFlatIcon(DAMAP), user)]</center>"
	user << browse(dat, "window=map;size=400x400;border=1;can_resize=0;can_minimize=0")
	onclose(user, "map", src)
	qdel(DAMAP)