//SABBAT = +90 threat
//HUNT = +60 threat
//CAITIFF = +30 threat

SUBSYSTEM_DEF(bad_guys_party)
	name = "Bad Guys Party"
	init_order = INIT_ORDER_DEFAULT
	wait = 300
	priority = FIRE_PRIORITY_DEFAULT

	var/threat = 0	//Bigger number - less chance

	var/list/candidates = list()
	var/max_candidates = 0
	var/next_role = "Caitiff"
	var/go_on_next_fire = FALSE

/datum/controller/subsystem/bad_guys_party/proc/get_niggers(var/level)
	switch(level)
		if(1)
			//caitiff
			threat = min(100, threat+30)
			max_candidates = 3
			go_on_next_fire = TRUE
			next_role = "Caitiff"
		if(2)
			//hunt
			threat = min(100, threat+60)
			max_candidates = 5
			go_on_next_fire = TRUE
			next_role = "Hunter"
		if(3)
			//sabbat
			threat = min(100, threat+90)
			max_candidates = 7
			go_on_next_fire = TRUE
			next_role = "Sabbatist"

/mob/dead/new_player/proc/ForceLateSpawn(rank)
	if(SSticker.late_join_disabled)
		alert(src, "An administrator has disabled late join spawning.")
		return FALSE

	SSticker.queued_players -= src
	SSticker.queue_delay = 4

	SSjob.AssignRole(src, rank, 1)

	var/mob/living/character = create_character(TRUE)	//creates the human and transfers vars and mind
	var/equip = SSjob.EquipRank(character, rank, TRUE)
	if(isliving(equip))	//Borgs get borged in the equip, so we need to make sure we handle the new mob.
		character = equip

	var/datum/job/job = SSjob.GetJob(rank)

	if(job && !job.override_latejoin_spawn(character))
		for(var/obj/effect/landmark/start/sloc in GLOB.start_landmarks_list)
			if(sloc.name == rank)
				sloc.JoinPlayerHere(character, FALSE)
		character.update_parallax_teleport()

	SSticker.minds += character.mind
	character.client.init_verbs() // init verbs for the late join
	var/mob/living/carbon/human/humanc
	if(ishuman(character))
		humanc = character	//Let's retypecast the var to be human,
		SEND_GLOBAL_SIGNAL(COMSIG_GLOB_CREWMEMBER_JOINED, humanc, rank)

	GLOB.joined_player_list += character.ckey

	if(humanc && CONFIG_GET(flag/roundstart_traits))
		SSquirks.AssignQuirks(humanc, humanc.client, TRUE)

/datum/controller/subsystem/bad_guys_party/fire()
	threat = max(0, threat-10)

	if(go_on_next_fire)
		if(length(candidates))
			var/list/actual_candidates = candidates.Copy()
			if(length(candidates) > max_candidates)
				for(var/i in 1 to length(candidates)-max_candidates)
					actual_candidates -= pick(candidates)
			for(var/mob/dead/new_player/NP in actual_candidates)
				candidates -= NP
				NP.late_ready = FALSE
				NP.ForceLateSpawn(next_role)
			go_on_next_fire = FALSE
		return
	else
		switch(threat)
			if(0 to 10)
				//ANYONE
				if(prob(100-threat))
					get_niggers(rand(1, 3))
			if(11 to 40)
				//HUNT OR CAITIFF
				if(prob(100-threat))
					get_niggers(rand(1, 2))
			if(41 to 70)
				//CAITIFF ONLY
				if(prob(100-threat))
					get_niggers(1)