//Zdes nasru huynoi dlya budushego bezumia

//add_client_colour(/datum/client_colour/glass_colour/red)
//remove_client_colour(/datum/client_colour/glass_colour/red)

/mob/living/carbon/human
	var/in_frenzy = FALSE
	var/frenzy_hardness = 1
	var/last_frenzy_check = 0
	var/atom/frenzy_target = null
	var/last_experience = 0

/client/Click(object,location,control,params)
	if(isatom(object))
		if(ishuman(mob))
			var/mob/living/carbon/human/H = mob
			if(H.in_frenzy)
				return
	..()

/mob/living/carbon/human/proc/rollfrenzy()
	if(clane && client)
		to_chat(src, "I need <span class='danger'><b>BLOOD</b></span>. The <span class='danger'><b>BEAST</b></span> is calling. Rolling...")
		SEND_SOUND(src, sound('code/modules/ziggers/bloodneed.ogg', 0, 0, 50))
		var/check = vampireroll(max(1, round(humanity/2)), frenzy_hardness, src)
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
	SEND_SOUND(src, sound('code/modules/ziggers/frenzy.ogg', 0, 0, 50))
	in_frenzy = TRUE
	add_client_colour(/datum/client_colour/glass_colour/red)
	GLOB.frenzy_list += src

/mob/living/carbon/human/proc/exit_frenzymod()
	in_frenzy = FALSE
	remove_client_colour(/datum/client_colour/glass_colour/red)
	GLOB.frenzy_list -= src

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
					add_bite_animation(L)
				if(CheckEyewitness(L, src, 7, FALSE))
					AdjustMasquerade(src, -1)
				playsound(src, 'code/modules/ziggers/drinkblood1.ogg', 50, TRUE)
				L.visible_message("<span class='warning'><b>[src] bites [L]'s neck!</b></span>", "<span class='warning'><b>[src] bites your neck!</b></span>")
				face_atom(L)
				drinksomeblood(L)
	else
		step_to(src,frenzy_target,0)
		face_atom(frenzy_target)

/mob/living/carbon/human/proc/get_frenzy_targets()
	var/list/targets = list()
	for(var/mob/living/L in viewers(7, src))
		if(!iskindred(L) && L.bloodamount && L.stat != DEAD)
			targets += L
			if(L == frenzy_target)
				return L
	if(length(targets) > 0)
		return pick(targets)
	else
		return null

/mob/living/carbon/human/proc/handle_automated_frenzy()
	for(var/mob/living/carbon/human/npc/NPC in viewers(5, src))
		NPC.Aggro(src)
	if(isturf(loc))
		frenzy_target = get_frenzy_targets()
		if(frenzy_target)
			var/datum/cb = CALLBACK(src,.proc/frenzystep)
			var/reqsteps = SSfrenzypool.wait/total_multiplicative_slowdown()
			for(var/i in 1 to reqsteps)
				addtimer(cb, (i - 1)*total_multiplicative_slowdown())
		else
			if(!CheckFrenzyMove())
				if(isturf(loc))
					var/turf/T = get_step(loc, pick(NORTH, SOUTH, WEST, EAST))
					face_atom(T)
					Move(T)

/datum/species/kindred/spec_life(mob/living/carbon/human/H)
	..()
	var/skipface = (H.wear_mask && (H.wear_mask.flags_inv & HIDEFACE)) || (H.head && (H.head.flags_inv & HIDEFACE))
	if(H.clane)
		if(!skipface && H.clane.violating_appearance)
			if(CheckEyewitness(H, H, 5, FALSE))
				AdjustMasquerade(H, -1)
	if(H.client && H.stat <= 2)
		if(H.client.prefs)
			if(H.client.prefs.humanity != H.humanity)
				H.client.prefs.humanity = H.humanity
				H.client.prefs.save_preferences()
				H.client.prefs.save_character()
			if(H.client.prefs.masquerade != H.masquerade)
				H.client.prefs.masquerade = H.masquerade
				H.client.prefs.save_preferences()
				H.client.prefs.save_character()
			if(H.last_experience+600 <= world.time)
				H.client.prefs.exper = min(1440, H.client.prefs.exper+1)
				H.client.prefs.save_preferences()
				H.client.prefs.save_character()
				H.last_experience = world.time
	if(H.bloodpool <= 1 && !H.in_frenzy)
		if(H.last_frenzy_check+400 <= world.time)
			H.last_frenzy_check = world.time
			H.rollfrenzy()
	if(H.in_frenzy || H.bloodpool > 1)
		H.last_frenzy_check = world.time