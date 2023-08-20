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
	whitelist = list("badteammate", "meomoor", "terain1", "egorium", "vanotyan", "takyon69", "lemshake", "happypala44", "kerststf", "oneplusone", "triplewammy", "leonko", "twiner", "otuskursky", "sishtis", "shirumic", "kommando", "nehoroshka", "raikyh", "themaskedman2", "xilvahphyre", "nikroszero", "foxfiredogs", "d6ll1r10um", "drdreidel", "stinkethstonketh", "neepbeep666", "parchment", "blackcat055", "laoziofcitium", "aniotaess", "andreykey", "mosasauruss", "animusin", "mercuryarrow", "keebo885", "homuhomu", "ivanzarax", "testuser", "panbarin", "cmdrgungnir")

/datum/vampireclane/lasombra/post_gain(mob/living/carbon/human/H)
	..()
	var/obj/item/organ/eyes/night_vision/NV = new()
	NV.Insert(H, TRUE, FALSE)
	H.vis_flags |= VIS_HIDE

/datum/discipline/obtenebration/post_gain(mob/living/carbon/human/H)
	H.faction |= "Lasombra"
	if(level >= 3)
		var/obj/effect/proc_holder/spell/targeted/shadowwalk/S = new(H)
		H.mind.AddSpell(S)