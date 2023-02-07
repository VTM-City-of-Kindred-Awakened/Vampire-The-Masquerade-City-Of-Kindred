/mob/living/carbon/human/npc/proc/Aggro(var/mob/M, var/attacked = FALSE)
	danger_source = M
	if(attacked)
		last_attacker = M
	if(last_danger_meet+50 < world.time)
		last_danger_meet = world.time
		if(!my_weapon)
			if(prob(50))
				RealisticSay(pick(socialrole.help_phrases))
			else
				emote("scream")