/proc/AdjustHumanity(var/mob/living/carbon/human/H, var/value, var/limit)
	if(!is_special_character(H) || H.mind.special_role == "Ambitious")
		if(!H.in_frenzy)
			var/mod = 1
			var/enlight = FALSE
			if(H.clane)
				mod = H.clane.humanitymod
				enlight = H.clane.enlightement
			if(enlight)
				if(value < 0)
					if(H.humanity < 10)
						H.humanity = max(limit, H.humanity-(value*mod))
						SEND_SOUND(H, sound('code/modules/ziggers/sounds/humanity_gain.ogg', 0, 0, 75))
						to_chat(H, "<span class='us-erhelp'><b>ENLIGHTEMENT INCREASES</b></span>")
				if(value > 0)
					if(H.humanity > 0)
						H.humanity = min(limit, H.humanity-(value*mod))
						SEND_SOUND(H, sound('code/modules/ziggers/sounds/humanity_loss.ogg', 0, 0, 75))
						to_chat(H, "<span class='userdanger'><b>ENLIGHTEMENT DECREASES</b></span>")
			else
				if(value < 0)
					if(H.humanity > limit)
						H.humanity = max(limit, H.humanity+(value*mod))
						SEND_SOUND(H, sound('code/modules/ziggers/sounds/humanity_loss.ogg', 0, 0, 75))
						to_chat(H, "<span class='userdanger'><b>HUMANITY DECREASES</b></span>")
				if(value > 0)
					if(H.humanity < limit)
						H.humanity = min(limit, H.humanity+(value*mod))
						SEND_SOUND(H, sound('code/modules/ziggers/sounds/humanity_gain.ogg', 0, 0, 75))
						to_chat(H, "<span class='us-erhelp'><b>HUMANITY INCREASES</b></span>")

/proc/AdjustMasquerade(var/mob/living/carbon/human/H, var/value)
	if(!is_special_character(H) || H.mind.special_role == "Ambitious")
		if(H.last_masquerade_violation+100 < world.time)
			H.last_masquerade_violation = world.time
			if(value < 0)
				if(H.masquerade > 0)
					H.masquerade = max(0, H.masquerade+value)
					SEND_SOUND(H, sound('code/modules/ziggers/sounds/masquerade_violation.ogg', 0, 0, 75))
					to_chat(H, "<span class='userdanger'><b>MASQUERADE VIOLATION</b></span>")
				SSbad_guys_party.next_fire = max(world.time, SSbad_guys_party.next_fire-600)
			if(value > 0)
				if(H.masquerade < 5)
					H.masquerade = min(5, H.masquerade+value)
					SEND_SOUND(H, sound('code/modules/ziggers/sounds/general_good.ogg', 0, 0, 75))
					to_chat(H, "<span class='userhelp'><b>MASQUERADE REINFORCEMENT</b></span>")
				SSbad_guys_party.next_fire = max(world.time, SSbad_guys_party.next_fire+1200)

	if(H in GLOB.masquerade_breakers_list)
		if(H.masquerade > 1)
			GLOB.masquerade_breakers_list -= H
	else if(H.masquerade < 2)
		GLOB.masquerade_breakers_list |= H

/mob/living/carbon/human/npc/proc/backinvisible(var/atom/A)
	switch(dir)
		if(NORTH)
			if(A.y >= y)
				return TRUE
		if(SOUTH)
			if(A.y <= y)
				return TRUE
		if(EAST)
			if(A.x >= x)
				return TRUE
		if(WEST)
			if(A.x <= x)
				return TRUE
	return FALSE

/proc/CheckEyewitness(var/mob/living/source, var/mob/attacker, var/range = 0, var/affects_source = FALSE)
	var/actual_range = max(1, round(range*(attacker.alpha/255)))
	if(SScityweather.fogging)
		actual_range = round(actual_range/2)
	var/list/seenby = list()
	for(var/mob/living/carbon/human/npc/NPC in viewers(actual_range, source))
		if(NPC.CheckMove())
			return
		if(source != NPC || affects_source)
			if(NPC == source)
				NPC.Aggro(attacker, TRUE)
			if(!NPC.pulledby)
				var/turf/LC = get_turf(attacker)
				if(LC.get_lumcount() > 0.25 || get_dist(NPC, attacker) <= 1)
					if(NPC.backinvisible(attacker))
						seenby += NPC
						NPC.Aggro(attacker, FALSE)
	if(length(seenby) >= 1)
		return TRUE
	return FALSE

/proc/vampireroll(var/dices_num = 1, var/hardness = 1, var/atom/rollviewer)
	var/wins = 0
	var/crits = 0
	var/brokes = 0
	for(var/i in 1 to dices_num)
		var/roll = rand(1, 10)
		if(roll == 10)
			crits += 1
		if(roll == 1)
			brokes += 1
		else if(roll >= hardness)
			wins += 1
	if(crits > brokes)
		if(rollviewer)
			to_chat(rollviewer, "<b>Critical <span class='nicegreen'>hit</span>!</b>")
			return DICE_CRIT_WIN
	if(crits < brokes)
		if(rollviewer)
			to_chat(rollviewer, "<b>Critical <span class='danger'>failure</span>!</b>")
			return DICE_CRIT_FAILURE
	if(crits == brokes && !wins)
		if(rollviewer)
			to_chat(rollviewer, "<span class='danger'>Failed</span>")
			return DICE_FAILURE
	if(wins)
		switch(wins)
			if(1)
				to_chat(rollviewer, "<span class='tinynotice'>Maybe</span>")
				return DICE_WIN
			if(2)
				to_chat(rollviewer, "<span class='smallnotice'>Okay</span>")
				return DICE_WIN
			if(3)
				to_chat(rollviewer, "<span class='notice'>Good</span>")
				return DICE_WIN
			if(4)
				to_chat(rollviewer, "<span class='notice'>Lucky</span>")
				return DICE_WIN
			else
				to_chat(rollviewer, "<span class='boldnotice'>Phenomenal</span>")
				return DICE_WIN

/proc/get_vamp_skin_color(var/value = "albino")
	switch(value)
		if("caucasian1")
			return "vamp1"
		if("caucasian2")
			return "vamp2"
		if("caucasian3")
			return "vamp3"
		if("latino")
			return "vamp4"
		if("mediterranean")
			return "vamp5"
		if("asian1")
			return "vamp6"
		if("asian2")
			return "vamp7"
		if("arab")
			return "vamp8"
		if("indian")
			return "vamp9"
		if("african1")
			return "vamp10"
		if("african2")
			return "vamp11"
		else
			return value
