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
		to_chat(user, "<b>YOU</b>, [get_area_name(user)] X:[user.x] Y:[user.y]")
		for(var/mob/living/H in GLOB.masquerade_breakers_list)
			to_chat(user, "[H.real_name], Masquerade: [H.masquerade], [get_area_name(H)] X:[H.x] Y:[H.y]")
	else
		to_chat(user, "No available Masquerade breakers in city...")

/obj/item/masquerade_contract/attack(mob/living/M, mob/living/user)
	. = ..()
	if(iskindred(M))
		if(M in GLOB.masquerade_breakers_list)
			if(M.stat >= UNCONSCIOUS)
				if(M.client)
					M.client.prefs.slotlocked = 0
					M.client.prefs.exper = 0
					M.client.prefs.generation_bonus = 0
					M.client.prefs.discipline1level = 1
					M.client.prefs.discipline2level = 1
					M.client.prefs.discipline3level = 1
					M.client.prefs.masquerade = initial(M.client.prefs.masquerade)
					M.client.prefs.generation = initial(M.client.prefs.generation)
					qdel(M.client.prefs.clane)
					M.client.prefs.clane = new /datum/vampireclane/brujah()
					M.client.prefs.humanity = M.client.prefs.clane.start_humanity
					M.client.prefs.random_species()
					M.client.prefs.random_character()
					M.client.prefs.real_name = random_unique_name(M.client.prefs.gender)
					M.client.prefs.save_character()
					M.client.prefs.save_preferences()
					M.ghostize(FALSE)
				M.death()
				to_chat(user, "<b>Successfully punished masquerade breaker and restored the Masquerade.</b>")
				AdjustMasquerade(user, 1)
				return
			else
				to_chat(user, "Target must be in critical condition or torpor.")
				return
		else
			to_chat(user, "Target must have at least 2 Masquerade violations.")
			return
	else
		to_chat(user, "Target must be kindred.")
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

/obj/item/drinkable_bloodpack/attack(mob/living/M, mob/living/user)
	. = ..()
	if(!iskindred(M))
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
		M.update_blood_hud()
		playsound(M.loc,'sound/items/drink.ogg', 50, TRUE)
		return
	else
		feeding = FALSE
		return

/obj/item/drinkable_bloodpack/elite
	name = "\improper elite blood pack (full)"
	amount_of_bloodpoints = 4