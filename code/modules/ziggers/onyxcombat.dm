/mob/living
	var/mob/parrying = null
	var/parry_class = WEIGHT_CLASS_TINY
	var/parry_cd = 0
	var/blocking = FALSE
	var/last_m_intent = MOVE_INTENT_RUN
	var/last_bloodheal_use = 0
	var/last_bloodpower_use = 0
	var/last_drinkblood_use = 0
	var/last_bloodheal_click = 0
	var/last_bloodpower_click = 0
	var/last_drinkblood_click = 0

/mob/living/carbon/human/death()
	..()
	if(dna.species.type == /datum/species/kindred)
		spawn(30)
			dust()

/mob/living/carbon/human/toggle_move_intent(mob/living/user)
	if(blocking && m_intent == MOVE_INTENT_WALK)
		return
	..()

/mob/living/carbon/human/proc/SwitchBlocking()
	if(!blocking)
		visible_message("<span class='warning'>[src] prepares to block.</span>", "<span class='warning'>You prepare to block.</span>")
		blocking = TRUE
		if(hud_used)
			hud_used.block_icon.icon_state = "act_block_on"
		clear_parrying()
		remove_overlay(HALO_LAYER)
		var/mutable_appearance/block_overlay = mutable_appearance('code/modules/ziggers/icons.dmi', "block", -HALO_LAYER)
		overlays_standing[HALO_LAYER] = block_overlay
		apply_overlay(HALO_LAYER)
		last_m_intent = m_intent
		if(m_intent == MOVE_INTENT_RUN)
			toggle_move_intent(src)
	else
		to_chat(src, "<span class='warning'>You lower your defense.</span>")
		remove_overlay(HALO_LAYER)
		blocking = FALSE
		if(m_intent != last_m_intent)
			toggle_move_intent(src)
		if(hud_used)
			hud_used.block_icon.icon_state = "act_block_off"

/mob/living/carbon/human/attackby(obj/item/W, mob/living/user, params)
	if(user.blocking)
		return
	if(user.a_intent == INTENT_GRAB && ishuman(user))
		var/mob/living/carbon/human/ZIG = user
		ZIG.parry_class = W.w_class
		ZIG.Parry(src)
		return
	if(user == parrying && user != src)
		if(W.w_class == parry_class)
			user.apply_damage(60, STAMINA)
		if(W.w_class == parry_class-1 || W.w_class == parry_class+1)
			user.apply_damage(30, STAMINA)
		else
			user.apply_damage(10, STAMINA)
		user.do_attack_animation(src)
		visible_message("<span class='danger'>[src] parries the attack!</span>", "<span class='danger'>You parry the attack!</span>")
		playsound(src, 'code/modules/ziggers/parried.ogg', 70, TRUE)
		clear_parrying()
		return
	if(blocking)
		if(istype(W, /obj/item/melee))
			var/obj/item/melee/WEP = W
			var/obj/item/bodypart/assexing = get_bodypart("[(active_hand_index % 2 == 0) ? "r" : "l" ]_arm")
			if(istype(get_active_held_item(), /obj/item))
				var/obj/item/IT = get_active_held_item()
				if(IT.w_class >= W.w_class)
					apply_damage(10, STAMINA)
					user.do_attack_animation(src)
					playsound(src, 'sound/weapons/tap.ogg', 70, TRUE)
					visible_message("<span class='danger'>[src] blocks the attack!</span>", "<span class='danger'>You block the attack!</span>")
					if(incapacitated(TRUE, TRUE) && blocking)
						SwitchBlocking()
					return
				else
					var/hand_damage = max(WEP.force - IT.force/2, 1)
					playsound(src, WEP.hitsound, 70, TRUE)
					apply_damage(hand_damage, WEP.damtype, assexing)
					apply_damage(30, STAMINA)
					user.do_attack_animation(src)
					visible_message("<span class='warning'>[src] weakly blocks the attack!</span>", "<span class='warning'>You weakly block the attack!</span>")
					if(incapacitated(TRUE, TRUE) && blocking)
						SwitchBlocking()
					return
			else
				playsound(src, WEP.hitsound, 70, TRUE)
				apply_damage(round(WEP.force/2), WEP.damtype, assexing)
				apply_damage(30, STAMINA)
				user.do_attack_animation(src)
				visible_message("<span class='warning'>[src] blocks the attack with [gender == MALE ? "his" : "her"] bare hands!</span>", "<span class='warning'>You block the attack with your bare hands!</span>")
				if(incapacitated(TRUE, TRUE) && blocking)
					SwitchBlocking()
				return
	..()

/mob/living/carbon/human/attack_hand(mob/user)
	if(user.a_intent == INTENT_HARM && blocking)
		playsound(src, 'sound/weapons/tap.ogg', 70, TRUE)
		apply_damage(10, STAMINA)
		user.do_attack_animation(src)
		visible_message("<span class='danger'>[src] blocks the punch!</span>", "<span class='danger'>You block the punch!</span>")
		if(incapacitated(TRUE, TRUE) && blocking)
			SwitchBlocking()
		return
	..()

/mob/living/carbon/human/proc/Parry(var/mob/M)
	if(!pulledby && !parrying && world.time-parry_cd >= 30 && M != src)
		parrying = M
		if(blocking)
			SwitchBlocking()
		visible_message("<span class='warning'>[src] prepares to parry [M]'s next attack.</span>", "<span class='warning'>You prepare to parry [M]'s next attack.</span>")
		playsound(src, 'code/modules/ziggers/parry.ogg', 70, TRUE)
		remove_overlay(HALO_LAYER)
		var/mutable_appearance/parry_overlay = mutable_appearance('code/modules/ziggers/icons.dmi', "parry", -HALO_LAYER)
		overlays_standing[HALO_LAYER] = parry_overlay
		apply_overlay(HALO_LAYER)
		parry_cd = world.time
//		update_icon()
		spawn(10)
			clear_parrying()
	return

/mob/living/carbon/human/proc/clear_parrying()
	if(parrying)
		parrying = null
		remove_overlay(HALO_LAYER)
		to_chat(src, "<span class='warning'>You lower your defense.</span>")
//	update_icon()

//(source.pulledby && source.pulledby.grab_state > GRAB_PASSIVE)

/atom/movable/screen/block
	name = "block"
	icon = 'code/modules/ziggers/icons.dmi'
	icon_state = "act_block_off"
	layer = HUD_LAYER
	plane = HUD_PLANE

/atom/movable/screen/block/Click()
	if(ishuman(usr))
		var/mob/living/carbon/human/BL = usr
		BL.SwitchBlocking()
	..()

/atom/movable/screen/blood
	name = "bloodpool"
	icon = 'code/modules/ziggers/vamphud.dmi'
	icon_state = "blood0"
	layer = HUD_LAYER
	plane = HUD_PLANE

/atom/movable/screen/addinv
	layer = HUD_LAYER
	plane = HUD_PLANE

/atom/movable/screen/blood/Click()
	if(ishuman(usr))
		var/mob/living/carbon/human/BD = usr
		BD.update_blood_hud()
		if(BD.bloodpool > 0)
			to_chat(BD, "<span class='notice'>You've got [BD.bloodpool]/[BD.maxbloodpool] blood points.</span>")
		else
			to_chat(BD, "<span class='warning'>You've got [BD.bloodpool]/[BD.maxbloodpool] blood points.</span>")
	..()

/atom/movable/screen/drinkblood
	name = "Drink Blood"
	icon = 'code/modules/ziggers/disciplines.dmi'
	icon_state = "drink"
	layer = HUD_LAYER
	plane = HUD_PLANE

/mob/living
	var/bloodamount = 1
	var/maxbloodamount = 1

/mob/living/carbon/human
	bloodamount = 5
	maxbloodamount = 5

/atom/movable/screen/drinkblood/Click()
	if(ishuman(usr))
		var/mob/living/carbon/human/BD = usr
		BD.update_blood_hud()
		if(world.time < BD.last_drinkblood_use+95)
			return
		if(world.time < BD.last_drinkblood_click+10)
			return
		BD.last_drinkblood_click = world.time
//		if(BD.bloodpool >= BD.maxbloodpool)
//			SEND_SOUND(BD, sound('code/modules/ziggers/need_blood.ogg'))
//			to_chat(BD, "<span class='warning'>You're full of <b>BLOOD</b>.</span>")
//			return
		if(BD.grab_state > GRAB_PASSIVE)
			if(ishuman(pulling))
				var/mob/living/carbon/human/PB = pulledby
				if(PB.dna.species.id == "kindred")
					SEND_SOUND(BD, sound('code/modules/ziggers/need_blood.ogg'))
					to_chat(BD, "<span class='warning'>You can't drink <b>BLOOD</b> of your own kind. <b>THIS IS INSANE!</b></span>")
					return
			if(isliving(BD.pulling))
				var/mob/living/LV = BD.pulling
				if(LV.bloodamount <= 0)
					SEND_SOUND(BD, sound('code/modules/ziggers/need_blood.ogg'))
					to_chat(BD, "<span class='warning'>There is no <b>BLOOD</b> in this creature.</span>")
					return
				if(isdead(LV))
					SEND_SOUND(BD, sound('code/modules/ziggers/need_blood.ogg'))
					to_chat(BD, "<span class='warning'>This creature is <b>DEAD</b>.</span>")
					return
				playsound(BD, 'code/modules/ziggers/drinkblood1.ogg', 50, TRUE)
				BD.drinksomeblood(LV)
	..()

/mob/living/carbon/human/proc/drinksomeblood(var/mob/living/mob)
	last_drinkblood_use = world.time
	SEND_SOUND(src, sound('code/modules/ziggers/drinkblood2.ogg'))
	to_chat(src, "<span class='warning'>You sip some <b>BLOOD</b> from your victim. It feels good.</span>")
	if(mob.bloodamount == 1 && mob.maxbloodamount > 1)
//		if(alert("This action will kill your victim. Are you sure?",,"Yes","No")!="Yes")
//			return
		to_chat(src, "<span class='warning'>You feel small amount of <b>BLOOD</b> in your victim.</span>")
	if(do_after(src, 96, target = mob))
		mob.bloodamount -= 1
		if(ishuman(mob))
			var/mob/living/carbon/human/H = mob
			H.blood_volume = max(H.blood_volume-10, 150)
		bloodpool = min(maxbloodpool, bloodpool+1)
		adjustBruteLoss(-5, TRUE)
		adjustFireLoss(-5, TRUE)
		update_damage_overlays()
		update_health_hud()
		update_blood_hud()
		if(mob.bloodamount <= 0)
			if(ishuman(mob))
				var/mob/living/carbon/human/K = mob
				K.blood_volume = 0
			mob.death()
			if(ishuman(mob))
				SEND_SOUND(src, sound('code/modules/ziggers/feed_failed.ogg'))
				to_chat(src, "<span class='warning'>This sad sacrifice for your own pleasure affects something deep in your mind.</span>")
				if(client)
					client.prefs.humanity = max(0, client.prefs.humanity-1)
					client.prefs.save_preferences()
					to_chat(src, "<span class='danger'><b>HUMANITY DECREASES.</b></span>")
			return
		if(grab_state > GRAB_PASSIVE)
			drinksomeblood(mob)

/atom/movable/screen/bloodheal
	name = "bloodheal"
	icon = 'code/modules/ziggers/disciplines.dmi'
	icon_state = "bloodheal"
	layer = HUD_LAYER
	plane = HUD_PLANE

/atom/movable/screen/bloodheal/Click()
	if(ishuman(usr))
		var/mob/living/carbon/human/BD = usr
		if(world.time < BD.last_bloodheal_use+30)
			return
		if(world.time < BD.last_bloodheal_click+10)
			return
		BD.last_bloodheal_click = world.time
		if(BD.bloodpool >= 1)
			BD.last_bloodheal_use = world.time
			BD.bloodpool -= 1
			icon_state = "[initial(icon_state)]-on"
			to_chat(BD, "<span class='notice'>You use blood to heal your wounds.</span>")
			BD.adjustBruteLoss(-5, TRUE)
			BD.adjustFireLoss(-5, TRUE)
			BD.update_damage_overlays()
			BD.update_health_hud()
		else
			SEND_SOUND(BD, sound('code/modules/ziggers/need_blood.ogg'))
			to_chat(BD, "<span class='warning'>You don't have enough <b>BLOOD</b> to heal your wounds.</span>")
		BD.update_blood_hud()
	spawn(15)
		icon_state = initial(icon_state)

/atom/movable/screen/bloodpower
	name = "bloodpower"
	icon = 'code/modules/ziggers/disciplines.dmi'
	icon_state = "bloodpower"
	layer = HUD_LAYER
	plane = HUD_PLANE

/atom/movable/screen/bloodpower/Click()
	if(ishuman(usr))
		var/mob/living/carbon/human/BD = usr
		if(world.time < BD.last_bloodpower_use+110)
			return
		if(world.time < BD.last_bloodpower_click+10)
			return
		BD.last_bloodpower_click = world.time
		if(BD.bloodpool >= 3)
			BD.last_bloodpower_use = world.time
			BD.bloodpool -= 3
			icon_state = "[initial(icon_state)]-on"
			to_chat(BD, "<span class='notice'>You use blood to become more powerful.</span>")
			BD.dna.species.punchdamagelow += 10
			BD.dna.species.punchdamagehigh += 10
			BD.physiology.armor.melee += 15
			BD.physiology.armor.bullet += 15
			BD.dna.species.speedmod -= 1
			if(!HAS_TRAIT(BD, TRAIT_IGNORESLOWDOWN))
				ADD_TRAIT(BD, TRAIT_IGNORESLOWDOWN, SPECIES_TRAIT)
		else
			SEND_SOUND(BD, sound('code/modules/ziggers/need_blood.ogg'))
			to_chat(BD, "<span class='warning'>You don't have enough <b>BLOOD</b> to become more powerful.</span>")
		BD.update_blood_hud()
		addtimer(CALLBACK(src, .proc/end_bloodpower), 100)

/atom/movable/screen/bloodpower/proc/end_bloodpower()
	if(ishuman(usr))
		var/mob/living/carbon/human/BD = usr
		to_chat(BD, "<span class='warning'>You feel like your <b>BLOOD</b>-powers slowly decrease.</span>")
		if(BD.dna.species)
			BD.dna.species.punchdamagelow = initial(BD.dna.species.punchdamagelow)
			BD.dna.species.punchdamagehigh = initial(BD.dna.species.punchdamagehigh)
			BD.physiology.armor.melee = initial(BD.physiology.armor.melee)
			BD.physiology.armor.bullet = initial(BD.physiology.armor.bullet)
			BD.dna.species.speedmod = initial(BD.dna.species.speedmod)
			if(HAS_TRAIT(BD, TRAIT_IGNORESLOWDOWN))
				REMOVE_TRAIT(BD, TRAIT_IGNORESLOWDOWN, SPECIES_TRAIT)
	icon_state = initial(icon_state)

//Na budushee
//	H.physiology.armor.melee += 25
//	H.physiology.armor.bullet += 20

/atom/movable/screen/disciplines
	layer = HUD_LAYER
	plane = HUD_PLANE
	var/datum/discipline/dscpln
	var/last_discipline_click = 0
	var/main_state = ""

/atom/movable/screen/disciplines/Click()
	if(ishuman(usr))
		var/mob/living/carbon/human/BD = usr
		if(world.time < last_discipline_click+10)
			return
		if(BD.active_discipline != dscpln)
			return
		last_discipline_click = world.time
		if(BD.bloodpool < dscpln.cost)
			SEND_SOUND(BD, sound('code/modules/ziggers/need_blood.ogg'))
			to_chat(BD, "<span class='warning'>You don't have enough <b>BLOOD</b> to use this discipline.</span>")
			return
		if(dscpln.ranged)
			if(BD.active_discipline)
				icon_state = main_state
				if(BD.active_discipline)
					qdel(BD.active_discipline)
			else
				icon_state = "[main_state]-on"
				BD.active_discipline = new (dscpln)
				BD.active_discipline.HUD = src
		else if(!dscpln.ranged)
			dscpln.activate(BD, BD)
			icon_state = "[main_state]-on"
			spawn(10)
				icon_state = main_state

/mob/living
	var/bloodpool = 7
	var/maxbloodpool = 10

/mob/living/carbon/human/Life()
	update_blood_hud()
	..()

/mob/living/proc/update_blood_hud()
	if(!client || !hud_used)
		return
	maxbloodpool = 10+(13-client.prefs.generation)
	if(hud_used.blood_icon)
		var/emm = round((bloodpool/maxbloodpool)*10)
		if(emm > 10)
			hud_used.blood_icon.icon_state = "blood10"
		if(emm < 0)
			hud_used.blood_icon.icon_state = "blood0"
		else
			hud_used.blood_icon.icon_state = "blood[emm]"
