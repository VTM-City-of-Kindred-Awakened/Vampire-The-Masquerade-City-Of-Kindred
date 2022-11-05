//Zdes nasru huynoi dlya budushego bezumia

//add_client_colour(/datum/client_colour/glass_colour/red)
//remove_client_colour(/datum/client_colour/glass_colour/red)

/mob/living/carbon/human
	var/in_frenzy = FALSE
	var/frenzy_hardness = 1
	var/last_frenzy_check = 0
	var/atom/frenzy_target = null

/mob/living/carbon/human/proc/rollfrenzy()
	if(clane && client)
		to_chat(src, "The beast is calling. Rolling...")
		var/check = vampireroll(max(1, round(client.prefs.humanity/2)), frenzy_hardness, src)
		switch(check)
			if(DICE_FAILURE)
				enter_frenzymod()
				addtimer(CALLBACK(src, .proc/exit_frenzymod), 100*clane.frenzymod)
				frenzy_hardness = 1
			if(DICE_CRIT_FAILURE)
				enter_frenzymod()
				addtimer(CALLBACK(src, .proc/exit_frenzymod), 200*clane.frenzymod)
				frenzy_hardness = 1
			if(DICE_CRIT_WIN)
				frenzy_hardness = max(1, frenzy_hardness-1)
			else
				frenzy_hardness = min(10, frenzy_hardness+1)

/mob/living/carbon/human/proc/enter_frenzymod()
	in_frenzy = TRUE
	add_client_colour(/datum/client_colour/glass_colour/red)
	GLOB.frenzy_list += src

/mob/living/carbon/human/proc/exit_frenzymod()
	in_frenzy = FALSE
	remove_client_colour(/datum/client_colour/glass_colour/red)
	GLOB.frenzy_list -= src

/mob/living/carbon/human/proc/CreateFrenzyWay(var/direction)
	var/turf/location = get_turf(src)
	for(var/distance = 1 to 50)
		location = get_step(location, direction)
		if(iswallturf(location))
			return location
		for(var/atom/A in location)
			if(A.density)
				return location

/mob/living/carbon/human/proc/ChooseFrenzyPath()
	var/turf/north_steps = CreateFrenzyWay(NORTH)
	var/turf/south_steps = CreateFrenzyWay(SOUTH)
	var/turf/west_steps = CreateFrenzyWay(WEST)
	var/turf/east_steps = CreateFrenzyWay(EAST)

	if(dir == NORTH || dir == SOUTH)
		if(get_dist(src, west_steps) >= 7 && get_dist(src, east_steps) >= 7)
			return(pick(west_steps, east_steps))
		if(get_dist(src, west_steps) > get_dist(src, east_steps))
			if(prob(75))
				return west_steps
		else if(get_dist(src, east_steps) > get_dist(src, west_steps))
			if(prob(75))
				return east_steps
		else
			if(dir == NORTH)
				return pick(west_steps, east_steps, south_steps)
			else
				return pick(west_steps, east_steps, north_steps)

	if(dir == WEST || dir == EAST)
		if(get_dist(src, north_steps) >= 7 && get_dist(src, south_steps) >= 7)
			return pick(north_steps, south_steps)
		if(get_dist(src, north_steps) > get_dist(src, south_steps))
			if(prob(75))
				return north_steps
		else if(get_dist(src, south_steps) > get_dist(src, north_steps))
			if(prob(75))
				return south_steps
		else
			if(dir == WEST)
				return pick(north_steps, south_steps, east_steps)
			else
				return pick(north_steps, south_steps, west_steps)

/mob/living/carbon/human/proc/CheckFrenzyMove()
	if(stat >= 2)
		return TRUE
	if(IsSleeping())
		return TRUE
	if(IsUnconscious())
		return TRUE
	if(IsParalyzed())
		return TRUE
	if(IsKnockdown())
		return TRUE
	if(IsStun())
		return TRUE
	if(HAS_TRAIT(src, TRAIT_RESTRAINED))
		return TRUE

/mob/living/carbon/human/proc/frenzystep()
	if(!frenzy_target || !isturf(loc) || CheckFrenzyMove())
		return
	if(m_intent == MOVE_INTENT_WALK)
		toggle_move_intent(src)
	set_glide_size(DELAY_TO_GLIDE_SIZE(total_multiplicative_slowdown()))

	if(get_dist(frenzy_target, src) <= 1)
		if(isliving(frenzy_target))
			var/mob/living/L = frenzy_target
			if(L.bloodamount && L.stat != DEAD && last_drinkblood_use+95 <= world.time)
				L.grabbedby(src)
				if(ishuman(L))
					L.emote("scream")
				if(CheckEyewitness(L, src, 7, FALSE))
					AdjustMasquerade(src, -1)
				playsound(src, 'code/modules/ziggers/drinkblood1.ogg', 50, TRUE)
				L.visible_message("<span class='warning'><b>[src] bites [L]'s neck!</b></span>", "<span class='warning'><b>[src] bites your neck!</b></span>")
				drinksomeblood(L)
	else
		step_to(src,frenzy_target,0)
		face_atom(frenzy_target)
		frenzy_target = get_frenzy_targets()

/mob/living/carbon/human/proc/get_frenzy_targets()
	var/list/targets = list()
	for(var/mob/living/L in viewers(7, src))
		if(!iskindred(L) && L.bloodamount && L.stat != DEAD)
			targets += L
			if(L == frenzy_target)
				return L
	if(length(targets) > 0)
		return pick(targets)
	if(get_dist(frenzy_target, src) <= 1)
		return ChooseFrenzyPath()

/mob/living/carbon/human/proc/handle_automated_frenzy()
	if(isturf(loc))
		if(!frenzy_target)
			frenzy_target = get_frenzy_targets()
		if(frenzy_target)
			var/datum/cb = CALLBACK(src,.proc/frenzystep)
			var/reqsteps = SSfrenzypool.wait/total_multiplicative_slowdown()
			for(var/i in 1 to reqsteps)
				addtimer(cb, (i - 1)*total_multiplicative_slowdown())

/datum/species/kindred/spec_life(mob/living/carbon/human/H)
	..()
	if(H.bloodpool <= 1 && !H.in_frenzy)
		if(H.last_frenzy_check+400 <= world.time)
			H.last_frenzy_check = world.time
			H.rollfrenzy()
	else
		H.last_frenzy_check = world.time
		for(var/mob/living/carbon/human/npc/NPC in viewers(5, src))
			NPC.danger_source = H
			NPC.last_danger_meet = world.time

/atom/movable/screen/Click()
	if(ishuman(usr))
		var/mob/living/carbon/human/FC = usr
		if(FC.in_frenzy)
			return
	..()