/datum/vampire_clane/malkavian
	name = "Malkavian"
	desc = "Derided as Lunatics by other vampires, the Blood of the Malkavians lets them perceive and foretell truths hidden from others. Like the “wise madmen” of poetry their fractured perspective stems from seeing too much of the world at once, from understanding too deeply, and feeling emotions that are just too strong to bear."
	clane_disciplines = list(/datum/discipline/auspex = 1)

/datum/vampire_clane/malkavian/on_gain(mob/living/carbon/human/H)
	..()
	H.add_quirk(/datum/quirk/insanity)