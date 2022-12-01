/obj/item
	var/onflooricon

/obj/item/equipped(mob/M, slot)
	. = ..()
	if(onflooricon)
		icon = initial(icon)
		pixel_w = initial(pixel_w)

/obj/item/dropped(mob/M)
	. = ..()
	if(onflooricon && isturf(src.loc))
		icon = onflooricon
		pixel_w = 0

/obj/item/Initialize()
	..()
	if(isturf(loc) && onflooricon)
		icon = onflooricon
