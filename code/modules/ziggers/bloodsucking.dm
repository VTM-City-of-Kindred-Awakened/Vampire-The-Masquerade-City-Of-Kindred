/mob/living/carbon/human/proc/add_bite_animation()
	remove_overlay(BITE_LAYER)
	var/mutable_appearance/bite_overlay = mutable_appearance('code/modules/ziggers/icons.dmi', "bite", -BITE_LAYER)
	overlays_standing[BITE_LAYER] = bite_overlay
	apply_overlay(BITE_LAYER)
	spawn(15)
		if(src)
			remove_overlay(BITE_LAYER)

/mob/living/carbon/human
	var/image/suckbar
	var/atom/suckbar_loc

/proc/get_needed_difference_between_numbers(var/number1, var/number2)
	if(number1 > number2)
		return number1 - number2
	else if(number1 < number2)
		return number2 - number1
	else
		return 1

/mob/living/carbon/human/proc/drinksomeblood(var/mob/living/mob)
	last_drinkblood_use = world.time
	if(client)
		client.images -= suckbar
	qdel(suckbar)
	suckbar_loc = mob
	suckbar = image('code/modules/ziggers/bloodcounter.dmi', suckbar_loc, "[round(14*(mob.bloodpool/mob.maxbloodpool))]", HUD_LAYER)
	suckbar.pixel_z = 40
	suckbar.plane = ABOVE_HUD_PLANE
	suckbar.appearance_flags = APPEARANCE_UI_IGNORE_ALPHA
	if(client)
		client.images += suckbar
	var/sound/heartbeat = sound('code/modules/ziggers/sounds/drinkblood2.ogg', repeat = TRUE)
	if(HAS_TRAIT(src, TRAIT_BLOODY_SUCKER))
		src.emote("moan")
		Immobilize(30, TRUE)
	playsound_local(src, heartbeat, 75, 0, channel = CHANNEL_BLOOD, use_reverb = FALSE)
	if(!iskindred(mob))
		mob.Stun(30)
	if(iskindred(mob))
		to_chat(src, "<span class='userdanger'><b>YOU TRY TO COMMIT DIABLERIE OVER [mob].</b></span>")
	if(isnpc(mob))
		var/mob/living/carbon/human/npc/NPC = mob
		NPC.danger_source = null
		NPC.last_attacker = src
	to_chat(src, "<span class='warning'>You sip some <b>BLOOD</b> from your victim. It feels good.</span>")
	if(mob.bloodpool == 1 && mob.maxbloodpool > 1)
//		if(alert("This action will kill your victim. Are you sure?",,"Yes","No")!="Yes")
//			return
		to_chat(src, "<span class='warning'>You feel small amount of <b>BLOOD</b> in your victim.</span>")
		if(iskindred(mob) && !mob.client)
			last_drinkblood_use = 0
			if(client)
				client.images -= suckbar
			qdel(suckbar)
			stop_sound_channel(CHANNEL_BLOOD)
			return
	if(!HAS_TRAIT(src, TRAIT_BLOODY_SUCKER) && CheckEyewitness(src, src, 7, FALSE))
		AdjustMasquerade(-1)
	if(do_after(src, 30, target = mob, timed_action_flags = NONE, progress = FALSE))
		mob.bloodpool = max(0, mob.bloodpool-1)
		suckbar.icon_state = "[round(14*(mob.bloodpool/mob.maxbloodpool))]"
		if(ishuman(mob))
			var/mob/living/carbon/human/H = mob
			drunked_of |= "[H.dna.real_name]"
			if(!iskindred(mob))
				H.blood_volume = max(H.blood_volume-50, 150)
				if(H.reagents)
					if(length(H.reagents.reagent_list))
						H.reagents.trans_to(src, min(10, H.reagents.total_volume))
		if(clane)
			if(clane.name == "Giovanni")
				mob.adjustBruteLoss(20, TRUE)
			if(clane.name == "Ventrue" && mob.bloodquality < BLOOD_QUALITY_NORMAL)	//Ventrue mozhet sosat norm, no ne bomzhei i zhivotnih. BLOOD_QUALITY_LOW - 1, BLOOD_QUALITY_NORMAL - 2, BLOOD_QUALITY_HIGH - 3. Golubaya krov daet +1 k otsosu
				to_chat(src, "<span class='warning'>You are too privileged to drink that awful <b>BLOOD</b>. Go get something better.</span>")
				visible_message("<span class='danger'>[src] throws up!</span>", "<span class='userdanger'>You throw up!</span>")
				playsound(get_turf(src), 'sound/effects/splat.ogg', 50, TRUE)
				if(isturf(loc))
					add_splatter_floor(loc)
				stop_sound_channel(CHANNEL_BLOOD)
				if(client)
					client.images -= suckbar
				qdel(suckbar)
				return
		bloodpool = min(maxbloodpool, bloodpool+1*max(1, mob.bloodquality-1))
		adjustBruteLoss(-10, TRUE)
		adjustFireLoss(-10, TRUE)
		update_damage_overlays()
		update_health_hud()
		update_blood_hud()
		if(mob.bloodpool <= 0)
			if(ishuman(mob))
				var/mob/living/carbon/human/K = mob
				if(iskindred(mob))
					AdjustHumanity(-1, 0)
					AdjustMasquerade(-1)
					if(K.generation >= generation)
						if(K.client)
							reset_shit(K)
							K.ghostize(FALSE)
						mob.death()
						adjustBruteLoss(-50, TRUE)
						adjustFireLoss(-50, TRUE)
					else
						if(prob(20+((generation-K.generation)*10)))
							to_chat(src, "<span class='userdanger'><b>[K]'s SOUL OVERCOMES YOURS AND GAIN CONTROL OF YOUR BODY.</b></span>")
							reset_shit(src)
							ghostize(FALSE)
							death()
//							key = K.key
//							generation = K.generation
//							maxHealth = initial(maxHealth)+100*(13-generation)
//							health = initial(health)+100*(13-generation)
//							mob.death()
						else
							generation = K.generation
							maxHealth = initial(maxHealth)+100*(13-generation)
							health = initial(health)+100*(13-generation)
							if(K.client)
								reset_shit(K)
								K.ghostize(FALSE)
							mob.death()
					if(client)
						client.images -= suckbar
					qdel(suckbar)
					return
				else
					K.blood_volume = 0
			if(ishuman(mob) && !iskindred(mob))
				if(isnpc(mob))
					var/mob/living/carbon/human/npc/Npc = mob
					Npc.last_attacker = null
				SEND_SOUND(src, sound('code/modules/ziggers/sounds/feed_failed.ogg', 0, 0, 75))
				to_chat(src, "<span class='warning'>This sad sacrifice for your own pleasure affects something deep in your mind.</span>")
				AdjustHumanity(-1, 3)
				mob.death()
			if(!ishuman(mob))
				mob.death()
			stop_sound_channel(CHANNEL_BLOOD)
			last_drinkblood_use = 0
			if(client)
				client.images -= suckbar
			qdel(suckbar)
			return
		if(grab_state >= GRAB_PASSIVE)
			stop_sound_channel(CHANNEL_BLOOD)
			drinksomeblood(mob)
	else
		last_drinkblood_use = 0
		if(client)
			client.images -= suckbar
		qdel(suckbar)
		stop_sound_channel(CHANNEL_BLOOD)
		if(!iskindred(mob))
			mob.SetSleeping(50)
