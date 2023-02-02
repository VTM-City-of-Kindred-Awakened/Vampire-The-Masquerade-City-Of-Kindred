/obj/projectile/bullet/vamp9mm
	name = "9mm bullet"
	damage = 25

/obj/projectile/bullet/vamp44
	name = ".44 bullet"
	damage = 35
	armour_penetration = 15

/obj/projectile/bullet/vamp556mm
	name = "5.56mm bullet"
	damage = 45
	armour_penetration = 30

/obj/projectile/bullet/vamp12g
	name = "12g shotgun slug"
	damage = 65
	sharpness = SHARP_POINTY
	wound_bonus = 0

/obj/item/ammo_casing/vampire
	icon = 'code/modules/ziggers/ammo.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	var/base_iconstate

/obj/item/ammo_casing/vampire/c9mm
	name = "9mm bullet casing"
	desc = "A 9mm bullet casing."
	caliber = CALIBER_9MM
	projectile_type = /obj/projectile/bullet/vamp9mm
	icon_state = "9"
	base_iconstate = "9"

/obj/item/ammo_casing/vampire/c44
	name = ".44 bullet casing"
	desc = "A .44 bullet casing."
	caliber = CALIBER_44
	projectile_type = /obj/projectile/bullet/vamp44
	icon_state = "44"
	base_iconstate = "44"

/obj/item/ammo_casing/vampire/c556mm
	name = "5.56mm bullet casing"
	desc = "A 5.56mm bullet casing."
	caliber = CALIBER_556
	projectile_type = /obj/projectile/bullet/vamp556mm
	icon_state = "556"
	base_iconstate = "556"

/obj/item/ammo_casing/vampire/c12g
	name = "12g bullet casing"
	desc = "A 12g bullet casing."
	caliber = CALIBER_12G
	projectile_type = /obj/projectile/bullet/vamp12g
	icon_state = "12"
	base_iconstate = "12"

/*
/obj/item/storage/ammostack
	icon = 'code/modules/ziggers/ammo.dmi'
	var/base_caliber = "tut base_iconstate"
	var/max_patroni = 5

/obj/item/storage/ammostack/update_icon()
	. = ..()
	var/patroni = 0
	for(var/obj/item/ammo_casing/vampire/V in src)
		if(V)
			patroni = max(0, patroni+1)
	if(patroni)
		if(patroni > 1)
			icon_state = "[base_caliber]-[patroni]"
		else
			icon_state = "[base_caliber]-live"

/obj/item/storage/ammostack/attackby(obj/item/I, mob/user, params)
	. = ..()
	var/patroni = 0
	for(var/obj/item/ammo_casing/vampire/V in src)
		if(V)
			patroni = max(0, patroni+1)
	if(istype(I, /obj/item/ammo_casing/vampire))
		var/obj/item/ammo_casing/vampire/V = I
		if(patroni < max_patroni && V.base_iconstate = base_caliber)
			I.forceMove(src)
			update_icon()

/obj/item/storage/ammostack/Initialize()
	. = ..()
*/
