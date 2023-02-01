//SABBAT = +90 threat
//HUNT = +60 threat
//CAITIFF = +30 threat

SUBSYSTEM_DEF(bad_guys_party)
	name = "Bad Guys Party"
	init_order = INIT_ORDER_DEFAULT
	wait = 3000
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

/datum/controller/subsystem/bad_guys_party/fire()
	threat = max(0, threat-10)

	if(go_on_next_fire)
		if(length(candidates))
			var/list/actual_candidates = candidates.Copy
			if(length(candidates) > max_candidates)
				for(var/i in max_candidates to length(candidates))
					actual_candidates -= pick(candidates)
			for(var/mob/dead/new_player/NP in actual_candidates)
				NP.AttemptLateSpawn(next_role)
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