/obj/item
	var/onflooricon

/obj/item/equipped(mob/M, slot)
	. = ..()
	if(onflooricon)
		icon = initial(icon)

/obj/item/dropped(mob/M)
	. = ..()
	if(onflooricon)
		icon = onflooricon

/obj/item/Initialize()
	..()
	if(isturf(loc) && onflooricon)
		icon = onflooricon