/datum/vampireclane/malkavian
	name = "Malkavian"
	desc = "Derided as Lunatics by other vampires, the Blood of the Malkavians lets them perceive and foretell truths hidden from others. Like the “wise madmen” of poetry their fractured perspective stems from seeing too much of the world at once, from understanding too deeply, and feeling emotions that are just too strong to bear."
	curse = "Insanity."
	clane_disciplines = list(/datum/discipline/auspex = 1,
														/datum/discipline/dementation = 2,
														/datum/discipline/obfuscate = 3)
	male_clothes = "/obj/item/clothing/under/vampire/malkavian"
	female_clothes = "/obj/item/clothing/under/vampire/malkavian/female"

/datum/vampireclane/malkavian/on_gain(mob/living/carbon/human/H)
	..()
	H.add_quirk(/datum/quirk/insanity)