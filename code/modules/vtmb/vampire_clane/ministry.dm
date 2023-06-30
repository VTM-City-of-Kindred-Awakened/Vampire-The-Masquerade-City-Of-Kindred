/datum/vampireclane/ministry
	name = "Ministry"
	desc = "The Ministry, also called the Ministry of Set, Followers of Set, or Setites, are a clan of vampires who believe their founder was the Egyptian god Set."
	curse = "Decreased moving speed in lighted areas."
	clane_disciplines = list(/datum/discipline/obfuscate = 1,
														/datum/discipline/presence = 2,
														/datum/discipline/serpentis = 3)
	male_clothes = "/obj/item/clothing/under/costume/mummy"
	female_clothes = "/obj/item/clothing/under/costume/mummy"

/datum/vampireclane/ministry/on_gain(mob/living/carbon/human/H)
	..()
	H.add_quirk(/datum/quirk/lightophobia)
	if(H.client)
		if(H.client.prefs)
			if(H.client.prefs.discipline3level >= 3)
				var/datum/action/mummyfy/mummy = new()
				mummy.Grant(H)
			if(H.client.prefs.discipline3level >= 4)
				var/datum/action/urn/U = new()
				U.Grant(H)
	var/obj/item/organ/eyes/night_vision/NV = new()
	NV.Insert(H, TRUE, FALSE)

/obj/urn
	name = "organ urn"
	desc = "Stores some precious organs..."
	icon = 'code/modules/ziggers/icons.dmi'
	icon_state = "urn"
	plane = GAME_PLANE
	layer = CAR_LAYER
	var/mob/living/own

/obj/urn/attackby(obj/item/I, mob/living/user, params)
	. = ..()
	qdel(src)

/obj/urn/attack_hand(mob/user)
	. = ..()
	qdel(src)

/obj/urn/Destroy()
	. = ..()
	if(own)
		own.death()

/obj/urn/New(var/mob/living/owner)
	. = ..()
	own = owner

/datum/action/urn
	name = "Make Urn"
	desc = "Move your heart to the urn and become immune to stakes."
	button_icon_state = "urn"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	var/obj/urn/urn
	var/cool_down = 0

/mob/living
	var/stakeimmune = FALSE

/datum/action/urn/Trigger()
	if(cool_down+200 >= world.time)
		return
	if(istype(owner, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = owner
		cool_down = world.time
		if(H.bloodpool < 1)
			to_chat(owner, "<span class='warning'>You don't have enough <b>BLOOD</b> to do that!</span>")
			return
		H.bloodpool = max(0, H.bloodpool-1)
		if(!urn)
			if(H.dna)
				if(H.dna.species)
					H.dna.species.inherent_traits |= TRAIT_STUNIMMUNE
					H.dna.species.inherent_traits |= TRAIT_SLEEPIMMUNE
					H.dna.species.inherent_traits |= TRAIT_NOSOFTCRIT
					H.stakeimmune = TRUE
					new /obj/urn(H.loc, H)
		else
			if(H.dna)
				if(H.dna.species)
					H.dna.species.inherent_traits -= TRAIT_STUNIMMUNE
					H.dna.species.inherent_traits -= TRAIT_SLEEPIMMUNE
					H.dna.species.inherent_traits -= TRAIT_NOSOFTCRIT
					H.stakeimmune = FALSE
			urn.own = null
			qdel(urn)

/datum/action/mummyfy
	name = "Mummyfy"
	desc = "Fall in torpor-like condition and ignore physical damage."
	button_icon_state = "serpentis"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS

/datum/action/mummyfy/Trigger()
	if(istype(owner, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = owner
		if(H.bloodpool < 2)
			to_chat(owner, "<span class='warning'>You don't have enough <b>BLOOD</b> to do that!</span>")
			return
		H.bloodpool = max(0, H.bloodpool-2)
		H.Paralyze(600)
		if(H.dna)
			if(H.dna.species)
				H.dna.species.brutemod = 0
		spawn(600)
			if(H)
				if(H.dna)
					if(H.dna.species)
						H.dna.species.brutemod = initial(H.dna.species.brutemod)