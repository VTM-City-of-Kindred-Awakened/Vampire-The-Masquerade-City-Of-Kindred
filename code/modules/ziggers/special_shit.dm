/obj/item/masquerade_contract
	name = "Masquerade Contract"
	desc = "See where to search the shitty Masquerade breakers. <b>CLICK ON the Contract to see possible breakers for catching. PUSH the target in torpor, to restore the Masquerade</b>"
	icon = 'code/modules/ziggers/items.dmi'
	icon_state = "masquerade"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/masquerade_contract/attack_self(mob/user)
	. = ..()
	if(length(GLOB.masquerade_breakers_list))
		var/turf/UT = get_turf(user)
		if(UT)
			to_chat(user, "<b>YOU</b>, [get_area_name(user)] X:[UT.x] Y:[UT.y]")
		for(var/mob/living/carbon/human/H in GLOB.masquerade_breakers_list)
			var/turf/TT = get_turf(H)
			if(TT)
				to_chat(user, "[H.true_real_name], Masquerade: [H.masquerade], Diablerist: [H.diablerist ? "<b>YES</b>" : "NO"], [get_area_name(H)] X:[TT.x] Y:[TT.y]")
	else
		to_chat(user, "No available Masquerade breakers in city...")

/mob/living
	var/total_contracted = 0

/obj/item/masquerade_contract/attack(mob/living/M, mob/living/user)
	. = ..()
	if(iskindred(M) || isghoul(M))
		var/mob/living/carbon/human/D = M
		if(D.diablerist)
			if(!GLOB.canon_event)
				to_chat(user, "This is not a canon event!")
				return
			if(!M.client)
				to_chat(user, "You need [M] attention to do that.")
				return
			if(M.stat >= 2)
				var/datum/preferences/P = GLOB.preferences_datums[ckey(M.key)]
//				var/extra = FALSE
//				if(D.diablerist)
//					extra = TRUE
				M.death()
				if(P)
					P.reason_of_death = "Executed to sustain the Traditions ([time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")])."
					reset_shit(M)
				M.ghostize(FALSE)
				to_chat(user, "<b>Successfully punished Traditions violator and restored the Masquerade.</b>")
				var/mob/living/carbon/human/HM = user
				HM.AdjustMasquerade(1)
				HM.total_contracted += 2
				return
		if(M in GLOB.masquerade_breakers_list)
			if(!GLOB.canon_event)
				to_chat(user, "This is not a canon event!")
				return
			if(!M.client)
				to_chat(user, "You need [M] attention to do that.")
				return
			if(M.stat >= 2)
				var/datum/preferences/P = GLOB.preferences_datums[ckey(M.key)]
//				var/extra = FALSE
//				if(D.diablerist)
//					extra = TRUE
				M.death()
				if(P)
					P.reason_of_death = "Executed to sustain the Traditions ([time2text(world.timeofday, "YYYY-MM-DD hh:mm:ss")])."
					reset_shit(M)
				M.ghostize(FALSE)
				to_chat(user, "<b>Successfully punished Traditions violator and restored the Masquerade.</b>")
				var/mob/living/carbon/human/HM = user
				HM.AdjustMasquerade(1)
				HM.total_contracted += 1
//				if(user.key)
//					if(P)
//						if(extra)
//							P.exper = min(calculate_mob_max_exper(user), P.exper+1000)
//						else
//							P.exper = min(calculate_mob_max_exper(user), P.exper+500)
				return
			else
				to_chat(user, "Target must be in critical condition or torpor.")
				return
		else
			to_chat(user, "Target must have at least 2 Masquerade violations.")
			return
	else
		to_chat(user, "Target must be kindred or ghoul.")
		return

/obj/item/drinkable_bloodpack
	name = "\improper drinkable blood pack (full)"
	desc = "Fast way to feed your inner beast."
	icon = 'code/modules/ziggers/items.dmi'
	icon_state = "blood4"
	inhand_icon_state = "blood4"
	lefthand_file = 'code/modules/ziggers/lefthand.dmi'
	righthand_file = 'code/modules/ziggers/righthand.dmi'
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF
	onflooricon = 'code/modules/ziggers/onfloor.dmi'

	var/empty = FALSE
	var/feeding = FALSE
	var/amount_of_bloodpoints = 2
	var/vitae = FALSE

/obj/item/drinkable_bloodpack/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!iskindred(M))
		if(!vitae)
			return
	if(empty)
		return
	feeding = TRUE
	if(do_mob(user, src, 3 SECONDS))
		feeding = FALSE
		empty = TRUE
		icon_state = "blood0"
		inhand_icon_state = "blood0"
		name = "\improper drinkable blood pack (empty)"
		M.bloodpool = min(M.maxbloodpool, M.bloodpool+amount_of_bloodpoints)
		M.adjustBruteLoss(-20, TRUE)
		M.adjustFireLoss(-20, TRUE)
		M.update_damage_overlays()
		M.update_health_hud()
		if(iskindred(M))
			M.update_blood_hud()
		playsound(M.loc,'sound/items/drink.ogg', 50, TRUE)
		return
	else
		feeding = FALSE
		return

/obj/item/drinkable_bloodpack/elite
	name = "\improper elite blood pack (full)"
	amount_of_bloodpoints = 4

/obj/item/drinkable_bloodpack/vitae
	name = "\improper vampire vitae pack (full)"
	amount_of_bloodpoints = 4
	vitae = TRUE

/obj/item/blood_hunt
	name = "Blood Hunt Announcer"
	desc = "Announce a Blood Hunt to the city."
	icon = 'code/modules/ziggers/items.dmi'
	icon_state = "eye"
	item_flags = NOBLUDGEON
	w_class = WEIGHT_CLASS_SMALL
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF

/obj/item/blood_hunt/attack_self(mob/user)
	. = ..()
	var/chosen_name = input(user, "Write the hunted or forgiven character name:", "Blood Hunt")  as text|null
	if(chosen_name)
		var/name_in_list = FALSE
		for(var/mob/living/carbon/human/H in GLOB.player_list)
			if(H)
				if(H.true_real_name == chosen_name)
					if(H in SSbloodhunt.hunted)
						SSbloodhunt.hunted -= H
						H.bloodhunted = FALSE
						SSbloodhunt.update_shit()
						to_chat(user, "<span class='warning'>You remove [chosen_name] from the Hunted list.</span>")
						to_chat(world, "<b>The Blood Hunt after <span class='green'>[H.true_real_name]</span> is over!</b>")
						SEND_SOUND(world, sound('code/modules/ziggers/sounds/announce.ogg'))
					else
						SSbloodhunt.announce_hunted(H)
						to_chat(user, "<span class='warning'>You add [chosen_name] to the Hunted list.</span>")
					name_in_list = TRUE
		if(!name_in_list)
			to_chat(user, "<span class='warning'>There is no such names in the city!</span>")

/obj/item/phone_book
	name = "phone book"
	desc = "See the actual numbers in the city."
	icon_state = "phonebook"
	icon = 'code/modules/ziggers/items.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	w_class = WEIGHT_CLASS_SMALL

/obj/item/phone_book/attack_self(mob/user)
	. = ..()
	for(var/i in GLOB.phone_numbers_list)
		to_chat(user, "- [i]")

/obj/item/quran
	name = "quran"
	desc = "Inshallah..."
	icon_state = "quran"
	icon = 'code/modules/ziggers/items.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	w_class = WEIGHT_CLASS_SMALL

/obj/item/quran/attack(mob/living/target, mob/living/user)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/H = target
		var/pathof = "Humanity"
		if(H.clane)
			if(H.clane.enlightement)
				pathof = "Enlightement"
		to_chat(user, "<b>[pathof]: [H.humanity]</b>")

/obj/item/quran/testuser

/obj/item/wire_cutters
	name = "wirecutters"
	desc = "With this item you can repair almost any electronics."
	icon_state = "fixer"
	icon = 'code/modules/ziggers/items.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	w_class = WEIGHT_CLASS_SMALL

/obj/fusebox
	name = "fuse box"
	desc = "Power the controlled area with pure electricity."
	icon = 'code/modules/ziggers/32x48.dmi'
	icon_state = "fusebox"
	plane = GAME_PLANE
	layer = CAR_LAYER
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	pixel_y = 32
	var/damaged = 0
	var/repairing = FALSE

/obj/fusebox/proc/check_damage(var/mob/living/user)
	if(damaged > 100 && icon_state != "fusebox_open")
		icon_state = "fusebox_open"
		var/area/A = get_area(src)
		A.requires_power = TRUE
		A.fire_controled = FALSE
		var/datum/effect_system/spark_spread/s = new /datum/effect_system/spark_spread
		s.set_up(5, 1, get_turf(src))
		s.start()
		for(var/obj/machinery/light/L in A)
			L.update(FALSE)
		playsound(loc, 'code/modules/ziggers/sounds/explode.ogg', 100, TRUE)
		user.electrocute_act(50, src, siemens_coeff = 1, flags = NONE)

/obj/fusebox/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/wire_cutters))
		if(!repairing)
			repairing = TRUE
			if(do_after(user, 100, src))
				icon_state = "fusebox"
				damaged = 0
//				user.electrocute_act(50, src, siemens_coeff = 1, flags = NONE)
				playsound(get_turf(src),'code/modules/ziggers/sounds/fix.ogg', 75, FALSE)
				var/area/A = get_area(src)
				A.requires_power = FALSE
				if(initial(A.fire_controled))
					A.fire_controled = TRUE
				for(var/obj/machinery/light/L in A)
					L.update(FALSE)
				repairing = FALSE
			else
				repairing = FALSE
	else
		..()
		if(I.force)
			damaged += I.force
			check_damage(user)

/mob/living/Life()
	if(GLOB.canon_event)
		if(client)
			if(client.holder)
				var/cool_guy = FALSE
				for(var/i in GLOB.psychokids)
					if(i == "[client.ckey]")
						cool_guy = TRUE
				if(!cool_guy)
					client.deadmin()
	..()
