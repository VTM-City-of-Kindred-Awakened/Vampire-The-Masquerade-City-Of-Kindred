/obj/item/dagon
	name = "Dagon"
	desc = "Волшебная палочка. Имеет разные градации силы"
	icon_state = "wiredrod"
	dagon_power = 400
/obj/item/dagon/2
	dagon_power = 500
/obj/item/dagon/3
	dagon_power = 600
/obj/item/dagon/4
	dagon_power = 700
/obj/item/dagon/5
	dagon_power = 800
/obj/item/dagon/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/nigga = target
		nigga.apply_damage(dagon_power, BURN,)
