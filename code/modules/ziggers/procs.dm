proc/AdjustHumanity(var/mob/living/carbon/human/H, var/value, var/limit)
	if(H.client && !H.in_frenzy)
		var/mod = 1
		if(H.clane)
			mod = H.clane.humanitymod
		if(value < 0)
			if(H.client.prefs.humanity > limit)
				H.client.prefs.humanity = max(limit, H.client.prefs.humanity+(value*mod))
				H.client.prefs.save_preferences()
				H.client.prefs.save_character()
				SEND_SOUND(H, sound('code/modules/ziggers/feed_failed.ogg', 0, 0, 75))
				to_chat(H, "<span class='userdanger'><b>HUMANITY DECREASES</b></span>")
		if(value > 0)
			if(H.client.prefs.humanity < limit)
				H.client.prefs.humanity = min(limit, H.client.prefs.humanity+(value*mod))
				H.client.prefs.save_preferences()
				H.client.prefs.save_character()
//				SEND_SOUND(H, sound('code/modules/ziggers/feed_failed.ogg', 0, 0, 75))
				to_chat(H, "<span class='userhelp'><b>HUMANITY INCREASES</b></span>")
	if(iskindred(H) && H.client.prefs.humanity < 1 && !H.in_frenzy)
		H.enter_frenzymod()
		H.client.prefs.slotlocked = 0
		H.client.prefs.masquerade = initial(H.client.prefs.masquerade)
		H.client.prefs.generation = initial(H.client.prefs.generation)
		qdel(H.client.prefs.clane)
		H.client.prefs.clane = new /datum/vampire_clane/brujah()
		H.client.prefs.humanity = H.client.prefs.clane.start_humanity
		H.client.prefs.random_species()
		H.client.prefs.random_character()
		H.client.prefs.real_name = random_unique_name(H.client.prefs.gender)
		H.client.prefs.save_character()

proc/AdjustMasquerade(var/mob/living/carbon/human/H, var/value)
	if(H.client)
		if(value < 0)
			if(H.client.prefs.masquerade > 0)
				H.client.prefs.masquerade = max(0, H.client.prefs.masquerade+value)
				H.client.prefs.save_preferences()
				H.client.prefs.save_character()
				SEND_SOUND(H, sound('code/modules/ziggers/feed_failed.ogg', 0, 0, 75))
				to_chat(H, "<span class='userdanger'><b>MASQUERADE VIOLATION</b></span>")
		if(value > 0)
			if(H.client.prefs.masquerade < 5)
				H.client.prefs.masquerade = min(5, H.client.prefs.masquerade+value)
				H.client.prefs.save_preferences()
				H.client.prefs.save_character()
//				SEND_SOUND(H, sound('code/modules/ziggers/feed_failed.ogg', 0, 0, 75))
				to_chat(H, "<span class='userhelp'><b>MASQUERADE RESTORED</b></span>")

proc/CheckEyewitness(var/mob/living/source, var/mob/attacker, var/range = 0, var/affects_source = FALSE)
	var/actual_range = max(1, round(range*(255/attacker.alpha)))
	var/list/seenby = list()
	for(var/mob/living/carbon/human/npc/NPC in viewers(actual_range, source))
		if(source != NPC || affects_source)
			seenby += NPC
			NPC.danger_source = attacker
			NPC.last_danger_meet = world.time
	var/turf/T = get_turf(attacker)
	if(T.lighting_object && T.lighting_object.invisibility <= source.see_invisible && T.is_softly_lit())
		if(affects_source && !in_range(T,source))
			return FALSE
		else if(!affects_source)
			return FALSE
	if(length(seenby) >= 1)
		return TRUE
	return FALSE

proc/vampireroll(var/dices_num = 1, var/hardness = 1, var/atom/rollviewer)
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