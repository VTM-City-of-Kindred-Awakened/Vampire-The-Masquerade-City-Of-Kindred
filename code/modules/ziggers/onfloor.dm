/obj/item
	var/onflooricon
	var/onflooricon_state

/obj/item/equipped(mob/M, slot)
	. = ..()
	if(onflooricon)
		icon = initial(icon)
		pixel_w = initial(pixel_w)
		update_icon()

/obj/item/dropped(mob/M)
	. = ..()
	if(onflooricon && isturf(loc))
		icon = onflooricon
		pixel_w = 0
		cut_overlays()
		if(onflooricon_state)
			icon_state = onflooricon_state
		update_icon()

/obj/item/Initialize()
	..()
	if(isturf(loc) && onflooricon)
		icon = onflooricon
		update_icon()
	if(onflooricon_state)
		icon_state = onflooricon_state
		update_icon()
