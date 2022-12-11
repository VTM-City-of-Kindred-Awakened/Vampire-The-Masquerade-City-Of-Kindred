/obj/item/ammo_casing/vampire
	icon = 'code/modules/ziggers/ammo.dmi'
	icon_state = "9-1"
	var/ammount = 1
	var/list/stackshit = list()
	var/base_iconstate = "9"

/obj/item/ammo_casing/vampire/Initialize()
	..()
	if(ammount > 1)
		var/to_create = ammount-1
		for(var/i in 1 to to_create)
			var/obj/item/ammo_casing/vampire/V = new type(src)
			V += stackshit
			ammount = length(stackshit)+1
			icon_state = "[base_iconstate]-[ammount]"

/obj/item/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/ammo_casing/vampire))
		var/obj/item/ammo_casing/vampire/V = I
		if(V.ammount > 1)
			var/obj/item/ammo_casing/vampire/C = pick(V.stackshit)
			attackby(C, user, params)
			if(C.loc != V)
				V.stackshit -= C
				V.ammount = length(V.stackshit)+1
				V.icon_state = "[V.base_iconstate]-[V.ammount]"
				return
	..()

/obj/item/ammo_casing/vampire/attackby(obj/item/I, mob/user, params)
	if(BB && ammount < 5)
		if(istype(I, /obj/item/ammo_casing/vampire))
			var/obj/item/ammo_casing/vampire/V = I
			if(V.BB && V.projectile_type == projectile_type)
				if(V.ammount == 1)
					V.forceMove(src)
					stackshit += V
					ammount = length(stackshit)+1
					icon_state = "[base_iconstate]-[ammount]"
				else if(V.ammount > 1 && V.ammount < 5)
					if(V.ammount > ammount)
						var/to_transfer = 5-V.ammount
						for(var/obj/item/ammo_casing/vampire/C in stackshit)
							if(to_transfer)
								C.forceMove(V)
								stackshit -= C
								to_transfer -= 1
						ammount = length(stackshit)+1
						icon_state = "[base_iconstate]-[ammount]"
						V.ammount = length(V.stackshit)+1
						V.icon_state = "[V.base_iconstate]-[V.ammount]"
					else
						var/to_transfer = 5-ammount
						for(var/obj/item/ammo_casing/vampire/C in V.stackshit)
							if(to_transfer)
								C.forceMove(src)
								V.stackshit -= C
								to_transfer -= 1
						ammount = length(stackshit)+1
						icon_state = "[base_iconstate]-[ammount]"
						V.ammount = length(V.stackshit)+1
						V.icon_state = "[V.base_iconstate]-[V.ammount]"
	..()

/obj/item/ammo_casing/vampire/v9mm
	name = "9mm bullet casing"
	desc = "A 9mm bullet casing."
	caliber = CALIBER_9MM
	projectile_type = /obj/projectile/bullet/c10mm
	base_iconstate = "9"

/obj/item/ammo_casing/vampire/v9mm/five
	ammount = 5

/obj/item/ammo_casing/vampire/c44
	name = ".44 bullet casing"
	desc = "A .44 bullet casing."
	caliber = CALIBER_44
	projectile_type = /obj/item/ammo_casing/a357
	base_iconstate = "44"
