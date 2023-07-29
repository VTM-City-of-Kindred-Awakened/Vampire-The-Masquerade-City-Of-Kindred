/datum/vampireclane/lasombra
	name = "Lasombra"
	desc = "The Lasombra exist for their own success, fighting for personal victories rather than solely for a crown to wear or a throne to sit upon. They believe that might makes right, and are willing to sacrifice anything to achieve their goals. A clan that uses spirituality as a tool rather than seeking honest enlightenment, their fickle loyalties are currently highlighted by half their clan's defection from the Sabbat."
	curse = "Technology refuse."
	clane_disciplines = list(/datum/discipline/potence = 1,
														/datum/discipline/dominate = 2,
														/datum/discipline/obtenebration = 3)
	male_clothes = "/obj/item/clothing/under/vampire/emo"
	female_clothes = "/obj/item/clothing/under/vampire/business"
	enlightement = TRUE

/datum/vampireclane/lasombra/on_gain(mob/living/carbon/human/H)
	..()
	H.faction |= "Lasombra"

/datum/vampireclane/lasombra/post_gain(mob/living/carbon/human/H)
	..()
	if(H.client)
		if(H.client.prefs)
			if(H.client.prefs.discipline3level >= 3)
				var/obj/effect/proc_holder/spell/targeted/shadowwalk/S = new(H)
				H.mind.AddSpell(S)
	var/obj/item/organ/eyes/night_vision/NV = new()
	NV.Insert(H, TRUE, FALSE)