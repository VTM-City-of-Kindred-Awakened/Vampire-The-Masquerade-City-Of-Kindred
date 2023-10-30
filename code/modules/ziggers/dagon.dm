/obj/item/dagon
	name = "Dagon"
	desc = "Волшебная палочка"
	icon_state = "wiredrod"
/obj/item/dagon/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/nigga = target
		nigga.apply_damage(800, BURN,)
