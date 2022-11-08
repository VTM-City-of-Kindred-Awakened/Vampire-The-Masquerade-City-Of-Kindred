/mob/living/carbon/human/npc/proc/Aggro(var/mob/M)
	danger_source = M
	last_danger_meet = world.time
	if(!melee_weapon && !range_weapon)
		if(prob(50))
			RealisticSay(pick(socialrole.help_phrases))
		else
			emote("scream")