/obj/damap
	icon = 'code/modules/ziggers/map.dmi'
	icon_state = "map"

/obj/damap/proc/get_target(var/tx, var/ty)
	var/mutable_appearance/targeticon = mutable_appearance(icon, "target", ABOVE_MOB_LAYER)
	targeticon.pixel_w = tx-127
	targeticon.pixel_z = ty-127
	add_overlay(targeticon)

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
	DAMAP.get_target(user.x, user.y)
	dat += "[icon2html(getFlatIcon(DAMAP), user)]"
	user << browse(dat, "window=map;size=275x275;border=1;can_resize=0;can_minimize=0")
	onclose(user, "map", src)
	qdel(DAMAP)