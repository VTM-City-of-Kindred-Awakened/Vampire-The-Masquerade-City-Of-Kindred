/* a basic datum базированный датум для расы вампиров. Кланы и дисциплины храняться в другом месте
*/
/datum/species/kindred
	name = "SORODICH"
	id = "kindred"
	default_color = "FFFFFF"
	toxic_food = MEAT | VEGETABLES | RAW | JUNKFOOD | GRAIN | FRUIT | DAIRY | FRIED | ALCOHOL | SUGAR | PINEAPPLE
	species_traits = list(EYECOLOR, HAIR,FACEHAIR, LIPS, HAS_FLESH, HAS_BONE)
	inherent_traits = list(TRAIT_ADVANCEDTOOLUSER, TRAIT_VIRUSIMMUNE, TRAIT_NOHUNGER, TRAIT_NOBREATH)
	use_skintones = TRUE
	limbs_id = "human"
	mutant_bodyparts = list("tail_human" = "None", "ears" = "None", "wings" = "None")
	brutemod = 0.8
	burnmod = 2
	punchdamagelow = 10
	punchdamagehigh = 20
	var/datum/vampire_clane/clane
/datum/species/kindred/on_species_gain(mob/living/carbon/human/C, datum/species/old_species, pref_load)
	. = ..()
	C.set_clane(C.client.prefs.clane)
	C.skin_tone = "albino"
	C.update_body(0)
