/mob/living/carbon/human/npc/proc/Aggro(var/mob/M, var/attacked = FALSE)
	if(key)
		return
	danger_source = M
	if(attacked)
		last_attacker = M
	if(last_danger_meet+50 < world.time)
		last_danger_meet = world.time
		if(!my_weapon)
			if(prob(50))
				emote("scream")
			else
				RealisticSay(pick(socialrole.help_phrases))
		else
			RealisticSay(pick(socialrole.help_phrases))