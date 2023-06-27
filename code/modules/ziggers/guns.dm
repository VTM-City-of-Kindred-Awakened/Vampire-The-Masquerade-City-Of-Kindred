/obj/item/gun/ballistic/vampire
	icon = 'code/modules/ziggers/weapons.dmi'
	lefthand_file = 'code/modules/ziggers/righthand.dmi'
	righthand_file = 'code/modules/ziggers/lefthand.dmi'
	worn_icon = 'code/modules/ziggers/worn.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	can_suppress = FALSE
	recoil = 2

/obj/item/gun/ballistic/automatic/vampire
	icon = 'code/modules/ziggers/weapons.dmi'
	lefthand_file = 'code/modules/ziggers/righthand.dmi'
	righthand_file = 'code/modules/ziggers/lefthand.dmi'
	worn_icon = 'code/modules/ziggers/worn.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	can_suppress = FALSE
	recoil = 2

/obj/item/ammo_box/magazine/internal/cylinder/rev44
	name = "revolver cylinder"
	ammo_type = /obj/item/ammo_casing/vampire/c44
	caliber = CALIBER_44
	max_ammo = 6

/obj/item/gun/ballistic/vampire/revolver
	name = "\improper revolver"
	desc = "Old, but might."
	icon_state = "revolver"
	inhand_icon_state = "revolver"
	worn_icon_state = "revolver"
	mag_type = /obj/item/ammo_box/magazine/internal/cylinder/rev44
	initial_caliber = CALIBER_44
	fire_sound = 'code/modules/ziggers/sounds/revolver.ogg'
	load_sound = 'sound/weapons/gun/revolver/load_bullet.ogg'
	eject_sound = 'sound/weapons/gun/revolver/empty.ogg'
	vary_fire_sound = FALSE
	fire_sound_volume = 85
	dry_fire_sound = 'sound/weapons/gun/revolver/dry_fire.ogg'
	casing_ejector = FALSE
	internal_magazine = TRUE
	bolt_type = BOLT_TYPE_NO_BOLT
	tac_reloads = FALSE
	var/spin_delay = 10
	var/recent_spin = 0

/obj/item/gun/ballistic/vampire/revolver/chamber_round(keep_bullet, spin_cylinder = TRUE, replace_new_round)
	if(!magazine) //if it mag was qdel'd somehow.
		CRASH("revolver tried to chamber a round without a magazine!")
	if(spin_cylinder)
		chambered = magazine.get_round(TRUE)
	else
		chambered = magazine.stored_ammo[1]

/obj/item/gun/ballistic/vampire/revolver/shoot_with_empty_chamber(mob/living/user as mob|obj)
	..()
	chamber_round()

/obj/item/gun/ballistic/vampire/revolver/AltClick(mob/user)
	..()
	spin()

/obj/item/gun/ballistic/vampire/revolver/verb/spin()
	set name = "Spin Chamber"
	set category = "Object"
	set desc = "Click to spin your revolver's chamber."

	var/mob/M = usr

	if(M.stat || !in_range(M,src))
		return

	if (recent_spin > world.time)
		return
	recent_spin = world.time + spin_delay

	if(do_spin())
		playsound(usr, "revolver_spin", 30, FALSE)
		usr.visible_message("<span class='notice'>[usr] spins [src]'s chamber.</span>", "<span class='notice'>You spin [src]'s chamber.</span>")
	else
		verbs -= /obj/item/gun/ballistic/vampire/revolver/verb/spin

/obj/item/gun/ballistic/vampire/revolver/proc/do_spin()
	var/obj/item/ammo_box/magazine/internal/cylinder/C = magazine
	. = istype(C)
	if(.)
		C.spin()
		chamber_round(spin_cylinder = FALSE)

/obj/item/gun/ballistic/revolver/get_ammo(countchambered = FALSE, countempties = TRUE)
	var/boolets = 0 //mature var names for mature people
	if (chambered && countchambered)
		boolets++
	if (magazine)
		boolets += magazine.ammo_count(countempties)
	return boolets

/obj/item/gun/ballistic/vampire/revolver/examine(mob/user)
	. = ..()
	var/live_ammo = get_ammo(FALSE, FALSE)
	. += "[live_ammo ? live_ammo : "None"] of those are live rounds."
	if (current_skin)
		. += "It can be spun with <b>alt+click</b>"

/obj/item/ammo_box/magazine/m44
	name = "handgun magazine (.44)"
	icon = 'code/modules/ziggers/ammo.dmi'
	lefthand_file = 'code/modules/ziggers/righthand.dmi'
	righthand_file = 'code/modules/ziggers/lefthand.dmi'
	worn_icon = 'code/modules/ziggers/worn.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	icon_state = "deagle"
	ammo_type = /obj/item/ammo_casing/vampire/c44
	caliber = CALIBER_44
	max_ammo = 7
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/vampire/deagle
	name = "\improper Desert Eagle"
	desc = "A powerful .44 handgun."
	icon_state = "deagle"
	inhand_icon_state = "deagle"
	worn_icon_state = "deagle"
	w_class = WEIGHT_CLASS_SMALL
	mag_type = /obj/item/ammo_box/magazine/m44
	burst_size = 1
	fire_delay = 0
	actions_types = list()
	bolt_type = BOLT_TYPE_LOCKING
	fire_sound = 'code/modules/ziggers/sounds/deagle.ogg'
	dry_fire_sound = 'sound/weapons/gun/pistol/dry_fire.ogg'
	load_sound = 'sound/weapons/gun/pistol/mag_insert.ogg'
	load_empty_sound = 'sound/weapons/gun/pistol/mag_insert.ogg'
	eject_sound = 'sound/weapons/gun/pistol/mag_release.ogg'
	eject_empty_sound = 'sound/weapons/gun/pistol/mag_release.ogg'
	vary_fire_sound = FALSE
	rack_sound = 'sound/weapons/gun/pistol/rack_small.ogg'
	lock_back_sound = 'sound/weapons/gun/pistol/lock_small.ogg'
	bolt_drop_sound = 'sound/weapons/gun/pistol/drop_small.ogg'
	fire_sound_volume = 75

/obj/item/ammo_box/magazine/vamp9mm
	name = "uzi magazine (9mm)"
	icon = 'code/modules/ziggers/ammo.dmi'
	lefthand_file = 'code/modules/ziggers/righthand.dmi'
	righthand_file = 'code/modules/ziggers/lefthand.dmi'
	worn_icon = 'code/modules/ziggers/worn.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	icon_state = "uzi"
	ammo_type = /obj/item/ammo_casing/vampire/c9mm
	caliber = CALIBER_9MM
	max_ammo = 25
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/vampire/uzi
	name = "\improper Type U3 Uzi"
	desc = "A lightweight, burst-fire submachine gun, for when you really want someone dead. Uses 9mm rounds."
	icon_state = "uzi"
	inhand_icon_state = "uzi"
	worn_icon_state = "uzi"
	mag_type = /obj/item/ammo_box/magazine/vamp9mm
	burst_size = 2
	bolt_type = BOLT_TYPE_OPEN
	show_bolt_icon = FALSE
	mag_display = TRUE
	rack_sound = 'sound/weapons/gun/pistol/slide_lock.ogg'
	fire_sound = 'code/modules/ziggers/sounds/uzi.ogg'

/obj/item/ammo_box/magazine/vamp556
	name = "carbine magazine (5.56mm)"
	icon = 'code/modules/ziggers/ammo.dmi'
	lefthand_file = 'code/modules/ziggers/righthand.dmi'
	righthand_file = 'code/modules/ziggers/lefthand.dmi'
	worn_icon = 'code/modules/ziggers/worn.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	icon_state = "rifle"
	ammo_type = /obj/item/ammo_casing/vampire/c556mm
	caliber = CALIBER_556
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/gun/ballistic/automatic/vampire/ar15
	name = "\improper AR-15 Carbine"
	desc = "A five-round burst 5.56 toploading carbine, designated 'AR-15'."
	icon = 'code/modules/ziggers/48x32weapons.dmi'
	icon_state = "rifle"
	inhand_icon_state = "rifle"
	worn_icon_state = "rifle"
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/vamp556
	burst_size = 3
	fire_delay = 2
	spread = 5
	bolt_type = BOLT_TYPE_OPEN
	show_bolt_icon = FALSE
	mag_display = TRUE
	fire_sound = 'code/modules/ziggers/sounds/rifle.ogg'

/obj/item/ammo_box/magazine/internal/vampire/sniper
	name = "sniper rifle internal magazine"
	desc = "Oh god, this shouldn't be here"
	ammo_type = /obj/item/ammo_casing/vampire/c556mm
	caliber = CALIBER_556
	max_ammo = 5
	multiload = TRUE

/obj/item/gun/ballistic/automatic/vampire/sniper
	name = "sniper rifle"
	desc = "A long ranged weapon that does significant damage. No, you can't quickscope."
	icon = 'code/modules/ziggers/48x32weapons.dmi'
	icon_state = "sniper"
	inhand_icon_state = "sniper"
	worn_icon_state = "sniper"
	w_class = WEIGHT_CLASS_BULKY
	mag_type = /obj/item/ammo_box/magazine/internal/vampire/sniper
	bolt_wording = "bolt"
	bolt_type = BOLT_TYPE_STANDARD
	semi_auto = FALSE
	internal_magazine = TRUE
	fire_sound = 'code/modules/ziggers/sounds/sniper.ogg'
	fire_sound_volume = 90
	vary_fire_sound = FALSE
	rack_sound = 'sound/weapons/gun/rifle/bolt_out.ogg'
	bolt_drop_sound = 'sound/weapons/gun/rifle/bolt_in.ogg'
	tac_reloads = FALSE
	fire_delay = 40
	burst_size = 1
	w_class = WEIGHT_CLASS_NORMAL
	zoomable = TRUE
	zoom_amt = 10 //Long range, enough to see in front of you, but no tiles behind you.
	zoom_out_amt = 5
	slot_flags = ITEM_SLOT_BACK
	projectile_damage_multiplier = 1.5
	actions_types = list()

/obj/item/ammo_box/magazine/internal/vampshotgun
	name = "shotgun internal magazine"
	ammo_type = /obj/item/ammo_casing/vampire/c12g
	caliber = CALIBER_12G
	multiload = FALSE
	max_ammo = 6

/obj/item/gun/ballistic/shotgun/vampire
	name = "shotgun"
	desc = "A traditional shotgun with wood furniture and a four-shell capacity underneath."
	icon = 'code/modules/ziggers/48x32weapons.dmi'
	lefthand_file = 'code/modules/ziggers/righthand.dmi'
	righthand_file = 'code/modules/ziggers/lefthand.dmi'
	worn_icon = 'code/modules/ziggers/worn.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	icon_state = "pomp"
	inhand_icon_state = "pomp"
	worn_icon_state = "pomp"
	fire_delay = 8
	mag_type = /obj/item/ammo_box/magazine/internal/vampshotgun
	can_be_sawn_off	= FALSE
	fire_sound = 'code/modules/ziggers/sounds/pomp.ogg'
	recoil = 2
	inhand_x_dimension = 32
	inhand_y_dimension = 32

/obj/item/gun/ballistic/shotgun/toy/crossbow/vampire
	name = "crossbow"
	desc = "Welcome to the Middle Ages!"
	icon = 'code/modules/ziggers/48x32weapons.dmi'
	lefthand_file = 'code/modules/ziggers/righthand.dmi'
	righthand_file = 'code/modules/ziggers/lefthand.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	icon_state = "crossbow0"
	inhand_icon_state = "crossbow0"
	fire_delay = 16
	mag_type = /obj/item/ammo_box/magazine/internal/vampcrossbow
	fire_sound = 'sound/items/syringeproj.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	inhand_x_dimension = 32
	inhand_y_dimension = 32

/obj/item/ammo_box/magazine/internal/vampcrossbow
	ammo_type = /obj/item/ammo_casing/caseless/bolt
	caliber = CALIBER_FOAM
	max_ammo = 1

/obj/item/ammo_casing/caseless/bolt
	name = "bolt"
	desc = "Welcome to the Middle Ages!"
	projectile_type = /obj/projectile/bullet/crossbow_bolt
	caliber = CALIBER_FOAM
	icon_state = "arrow"
	icon = 'code/modules/ziggers/ammo.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	harmful = TRUE