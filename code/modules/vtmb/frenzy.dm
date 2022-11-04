//Zdes nasru huynoi dlya budushego bezumia

//add_client_colour(/datum/client_colour/glass_colour/red)
//remove_client_colour(/datum/client_colour/glass_colour/red)

/mob/living/carbon/human
	var/in_frenzy = FALSE
	var/frenzy_hardness = 1
	var/last_frenzy_check = 0

/mob/living/carbon/human/proc/rollfrenzy()
	if(clane && client)
		to_chat(src, "The beast is calling. Rolling...")
		var/check = vampireroll(client.prefs.humanity, frenzy_hardness, src)
		if(check == DICE_FAILURE || check == DICE_CRIT_FAILURE)
			enter_frenzymod()
			addtimer(CALLBACK(src, .proc/exit_frenzymod), 100*clane.frenzymod)
			return TRUE
		return FALSE

/mob/living/carbon/human/proc/enter_frenzymod()
	in_frenzy = TRUE
	add_client_colour(/datum/client_colour/glass_colour/red)

/mob/living/carbon/human/proc/exit_frenzymod()
	in_frenzy = FALSE
	remove_client_colour(/datum/client_colour/glass_colour/red)

/datum/species/kindred/spec_life(mob/living/carbon/human/H)
	..()
	if(H.bloodpool <= 1 && !H.in_frenzy)
		if(H.last_frenzy_check+200 <= world.time)
			H.last_frenzy_check = world.time
			if(H.rollfrenzy())
				H.frenzy_hardness = 1
			else
				H.frenzy_hardness = min(10, H.frenzy_hardness+1)