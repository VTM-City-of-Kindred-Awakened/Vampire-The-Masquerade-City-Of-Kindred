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
				if(H.dna)
					to_chat(user, "[H.dna.real_name], Masquerade: [H.masquerade], [get_area_name(H)] X:[TT.x] Y:[TT.y]")
	else
		to_chat(user, "No available Masquerade breakers in city...")

/obj/item/masquerade_contract/attack(mob/living/M, mob/living/user)
	. = ..()
	if(iskindred(M) || isghoul(M))
		if(M in GLOB.masquerade_breakers_list)
			if(M.stat >= 2)
				if(M.client)
					reset_shit(M)
					M.ghostize(FALSE)
				M.death()
				to_chat(user, "<b>Successfully punished masquerade breaker and restored the Masquerade.</b>")
				var/mob/living/carbon/human/HM = user
				HM.AdjustMasquerade(1)
				if(user.key)
					var/datum/preferences/P = GLOB.preferences_datums[ckey(user.key)]
					if(P)
						P.exper = min(calculate_mob_max_exper(user), P.exper+500)
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
	amount_of_bloodpoints = 6
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
	var/chosen_name = input(user, "Write the hunted character name:", "Blood Hunt")  as text|null
	if(chosen_name)
		var/name_in_list = FALSE
		for(var/mob/living/carbon/human/H in GLOB.player_list)
			if(H)
				if(H.real_name == chosen_name)
					name_in_list = TRUE
		if(name_in_list)
			to_chat(world, "<b>Prince announces the Blood Hunt after <span class='warning'>[chosen_name]</span>!</b>")
			SEND_SOUND(world, sound('code/modules/ziggers/sounds/announce.ogg'))
		else
			to_chat(user, "<span class='warning'>There is no such names in the city!</span>")