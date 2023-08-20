/datum/vampireclane/baali
	name = "Baali"
	desc = "The Baali are a bloodline of vampires associated with demon worship. Because of their affinity with the unholy, the Baali are particularly vulnerable to holy iconography, holy ground and holy water. They are highly vulnerable to True Faith."
	curse = "Fear of the Religion."
	clane_disciplines = list(/datum/discipline/obfuscate = 1,
														/datum/discipline/obtenebration = 2,
														/datum/discipline/daimonion = 3)
	male_clothes = "/obj/item/clothing/under/vampire/baali"
	female_clothes = "/obj/item/clothing/under/vampire/baali/female"
	whitelist = list("badteammate", "meomoor", "leonko", "raikyh", "xilvahphyre", "homuhomu", "lemshake", "notaspider")
	enlightement = TRUE

/datum/vampireclane/baali/on_gain(mob/living/carbon/human/H)
	..()
	H.faction |= "Baali"
	var/datum/brain_trauma/mild/phobia/security/T = new()
	H.gain_trauma(T, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/discipline/daimonion/post_gain(mob/living/carbon/human/H)
	if(level >= 5)
		var/datum/action/antifrenzy/A = new()
		A.Grant(H)

/datum/action/antifrenzy
	name = "Resist Beast"
	desc = "Resist Frenzy and Rotshreck by signing a contract with Demons."
	button_icon_state = "resist"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	var/used = FALSE

/datum/action/antifrenzy/Trigger()
	if(used)
		to_chat(owner, "<span class='warning'>You've already signed this contract!</span>")
		return
	used = TRUE
	var/mob/living/carbon/human/H = owner
	H.antifrenzy = TRUE
	SEND_SOUND(owner, sound('sound/magic/curse.ogg', 0, 0, 50))
	to_chat(owner, "<span class='warning'>You feel control over your Beast, but at what cost...</span>")