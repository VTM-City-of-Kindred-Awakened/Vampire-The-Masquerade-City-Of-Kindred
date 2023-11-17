/obj/item/staff/furion
	name = "Teleportation staff"
	desc = "The Prophet keeps his sentinel over the forest, protecting it when in need."
	icon_state = "bostaff0"
/obj/item/staff/furion/attack_self(mob/user)
	. = ..()
	var/selected_area = input(user, "Choose a area", "Teleportation") as anything in GLOB.sortedAreas
	if(!selected_area)
		return
	var/list/turfs = list()
	for(var/turf/T in selected_area)
		if(T.density)
			continue
		turfs.Add(T)

	if(length(turfs))
		var/turf/T = pick(turfs)
		usr.forceMove(T)
	else
		to_chat(src, "Nowhere to jump to!", confidential = TRUE)
		return
