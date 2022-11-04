/* a basic datum базированный датум для расы вампиров. Кланы и дисциплины храняться в другом месте
*/
#define DEFAULT_BLOOD_LOSS 0.2
/datum/species/kindred
	name = "Vampire"
	id = "kindred"
	default_color = "FFFFFF"
	toxic_food = MEAT | VEGETABLES | RAW | JUNKFOOD | GRAIN | FRUIT | DAIRY | FRIED | ALCOHOL | SUGAR | PINEAPPLE
	species_traits = list(EYECOLOR, HAIR,FACEHAIR, LIPS, HAS_FLESH, HAS_BONE)
	inherent_traits = list(TRAIT_ADVANCEDTOOLUSER, TRAIT_VIRUSIMMUNE, TRAIT_NOHUNGER, TRAIT_NOBREATH, TRAIT_TOXIMMUNE, TRAIT_NOCRITDAMAGE)
	use_skintones = TRUE
	limbs_id = "human"
	mutant_bodyparts = list("tail_human" = "None", "ears" = "None", "wings" = "None")
	brutemod = 1	//0.8 bilo
	burnmod = 2
	punchdamagelow = 10
	punchdamagehigh = 20
	dust_anim = "dust-h"
	var/datum/vampire_clane/clane
/datum/species/kindred/spec_life(mob/living/carbon/human/H)
	. = ..()
	SEND_SIGNAL(H, COMSIG_VAMP_WASTEBLOOD, DEFAULT_BLOOD_LOSS)

/datum/species/kindred/check_roundstart_eligible()
	return TRUE