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
	var/harm_focus = SOUTH

/mob/living/carbon/human/death()
	..()
	if(iskindred(src))
		if(in_frenzy)
			exit_frenzymod()
		if(client)
			if(client.prefs)
				client.prefs.humanity = humanity
				client.prefs.masquerade = masquerade
				client.prefs.save_character()
				client.prefs.save_preferences()
		fire_stacks += 5
		IgniteMob()
		playsound(src, 'code/modules/ziggers/sounds/burning_death.ogg', 80, TRUE)
		SEND_SOUND(src, sound('code/modules/ziggers/sounds/final_death.ogg', 0, 0, 50))
		lying_fix()
		dir = SOUTH
		spawn(5)
			dust(1, 1)

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
		remove_overlay(FIGHT_LAYER)
		var/mutable_appearance/block_overlay = mutable_appearance('code/modules/ziggers/icons.dmi', "block", -FIGHT_LAYER)
		overlays_standing[FIGHT_LAYER] = block_overlay
		apply_overlay(FIGHT_LAYER)
		last_m_intent = m_intent
		if(m_intent == MOVE_INTENT_RUN)
			toggle_move_intent(src)
	else
		to_chat(src, "<span class='warning'>You lower your defense.</span>")
		remove_overlay(FIGHT_LAYER)
		blocking = FALSE
		if(m_intent != last_m_intent)
			toggle_move_intent(src)
		if(hud_used)
			hud_used.block_icon.icon_state = "act_block_off"

/mob/living/carbon/human/attackby(obj/item/W, mob/living/user, params)
	if(user.blocking)
		return
	if(getStaminaLoss() >= 50 && blocking)
		SwitchBlocking()
	if(CheckFrenzyMove() && blocking)
		SwitchBlocking()
	if(user.a_intent == INTENT_GRAB && ishuman(user))
		var/mob/living/carbon/human/ZIG = user
		if(ZIG.getStaminaLoss() < 50 && !ZIG.CheckFrenzyMove())
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
		playsound(src, 'code/modules/ziggers/sounds/parried.ogg', 70, TRUE)
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
	if(getStaminaLoss() >= 50 && blocking)
		SwitchBlocking()
	if(CheckFrenzyMove() && blocking)
		SwitchBlocking()
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
		playsound(src, 'code/modules/ziggers/sounds/parry.ogg', 70, TRUE)
		remove_overlay(FIGHT_LAYER)
		var/mutable_appearance/parry_overlay = mutable_appearance('code/modules/ziggers/icons.dmi', "parry", -FIGHT_LAYER)
		overlays_standing[FIGHT_LAYER] = parry_overlay
		apply_overlay(FIGHT_LAYER)
		parry_cd = world.time
//		update_icon()
		spawn(10)
			clear_parrying()
	return

/mob/living/carbon/human/proc/clear_parrying()
	if(parrying)
		parrying = null
		remove_overlay(FIGHT_LAYER)
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
	var/bloodquality = BLOOD_QUALITY_LOW

/mob/living/carbon/human
	bloodamount = 5
	maxbloodamount = 5
	bloodquality = BLOOD_QUALITY_NORMAL

/atom/movable/screen/drinkblood/Click()
	SEND_SOUND(usr, sound('code/modules/ziggers/sounds/highlight.ogg', 0, 0, 50))
	if(ishuman(usr))
		var/mob/living/carbon/human/BD = usr
		BD.update_blood_hud()
		if(world.time < BD.last_drinkblood_use+30)
			return
		if(world.time < BD.last_drinkblood_click+10)
			return
		BD.last_drinkblood_click = world.time
//		if(BD.bloodpool >= BD.maxbloodpool)
//			SEND_SOUND(BD, sound('code/modules/ziggers/need_blood.ogg'))
//			to_chat(BD, "<span class='warning'>You're full of <b>BLOOD</b>.</span>")
//			return
		if(BD.grab_state > GRAB_PASSIVE)
			if(iskindred(BD.pulling))
				SEND_SOUND(BD, sound('code/modules/ziggers/sounds/need_blood.ogg', 0, 0, 75))
				to_chat(BD, "<span class='warning'>You can't drink <b>BLOOD</b> of your own kind. <b>THIS IS INSANE!</b></span>")
				return
			if(ishuman(BD.pulling))
				var/mob/living/carbon/human/PB = BD.pulling
				if(PB.stat == 4)
					SEND_SOUND(BD, sound('code/modules/ziggers/sounds/need_blood.ogg', 0, 0, 75))
					to_chat(BD, "<span class='warning'>This creature is <b>DEAD</b>.</span>")
					return
				if(PB.bloodamount <= 0)
					SEND_SOUND(BD, sound('code/modules/ziggers/sounds/need_blood.ogg', 0, 0, 75))
					to_chat(BD, "<span class='warning'>There is no <b>BLOOD</b> in this creature.</span>")
					return
				PB.add_bite_animation()
				PB.emote("scream")
			if(isliving(BD.pulling))
				var/mob/living/LV = BD.pulling
				if(LV.bloodamount <= 0)
					SEND_SOUND(BD, sound('code/modules/ziggers/sounds/need_blood.ogg', 0, 0, 75))
					to_chat(BD, "<span class='warning'>There is no <b>BLOOD</b> in this creature.</span>")
					return
				if(LV.stat == 4)
					SEND_SOUND(BD, sound('code/modules/ziggers/sounds/need_blood.ogg', 0, 0, 75))
					to_chat(BD, "<span class='warning'>This creature is <b>DEAD</b>.</span>")
					return
				var/skipface = (BD.wear_mask && (BD.wear_mask.flags_inv & HIDEFACE)) || (BD.head && (BD.head.flags_inv & HIDEFACE))
				if(!skipface)
					playsound(BD, 'code/modules/ziggers/sounds/drinkblood1.ogg', 50, TRUE)
					LV.visible_message("<span class='warning'><b>[BD] bites [LV]'s neck!</b></span>", "<span class='warning'><b>[BD] bites your neck!</b></span>")
					if(CheckEyewitness(LV, BD, 7, FALSE))
						AdjustMasquerade(BD, -1)
					BD.drinksomeblood(LV)
	..()

/atom/movable/screen/bloodheal
	name = "Bloodheal"
	icon = 'code/modules/ziggers/disciplines.dmi'
	icon_state = "bloodheal"
	layer = HUD_LAYER
	plane = HUD_PLANE

/atom/movable/screen/bloodheal/Click()
	SEND_SOUND(usr, sound('code/modules/ziggers/sounds/highlight.ogg', 0, 0, 50))
	if(ishuman(usr))
		var/mob/living/carbon/human/BD = usr
		if(world.time < BD.last_bloodheal_use+30)
			return
		if(world.time < BD.last_bloodheal_click+10)
			return
		BD.last_bloodheal_click = world.time
		if(BD.bloodpool >= 1)
			playsound(usr, 'code/modules/ziggers/sounds/bloodhealing.ogg', 50, FALSE)
			BD.last_bloodheal_use = world.time
			BD.bloodpool -= 1
			icon_state = "[initial(icon_state)]-on"
			to_chat(BD, "<span class='notice'>You use blood to heal your wounds.</span>")
			if(BD.getBruteLoss() + BD.getBruteLoss() >= 25)
				BD.visible_message("<span class='warning'>Some of [BD]'s visible injuries disappear!</span>", "<span class='warning'>Some of your injuries disappear!</span>")
			BD.adjustBruteLoss(-10, TRUE)
			var/datum/wound/W = pick(BD.all_wounds)
			W.remove_wound()
			BD.adjustFireLoss(-10, TRUE)
			BD.update_damage_overlays()
			BD.update_health_hud()
		else
			SEND_SOUND(BD, sound('code/modules/ziggers/sounds/need_blood.ogg', 0, 0, 75))
			to_chat(BD, "<span class='warning'>You don't have enough <b>BLOOD</b> to heal your wounds.</span>")
		BD.update_blood_hud()
	spawn(15)
		icon_state = initial(icon_state)

/atom/movable/screen/bloodpower
	name = "Bloodpower"
	icon = 'code/modules/ziggers/disciplines.dmi'
	icon_state = "bloodpower"
	layer = HUD_LAYER
	plane = HUD_PLANE

/atom/movable/screen/bloodpower/Click()
	SEND_SOUND(usr, sound('code/modules/ziggers/sounds/highlight.ogg', 0, 0, 50))
	if(ishuman(usr))
		var/mob/living/carbon/human/BD = usr
		if(world.time < BD.last_bloodpower_use+110)
			return
		if(world.time < BD.last_bloodpower_click+10)
			return
		BD.last_bloodpower_click = world.time
		if(BD.bloodpool >= 3)
			playsound(usr, 'code/modules/ziggers/sounds/bloodhealing.ogg', 50, FALSE)
			BD.last_bloodpower_use = world.time
			BD.bloodpool -= 3
			icon_state = "[initial(icon_state)]-on"
			to_chat(BD, "<span class='notice'>You use blood to become more powerful.</span>")
			BD.dna.species.punchdamagehigh += 5
			BD.physiology.armor.melee += 15
			BD.physiology.armor.bullet += 15
			if(!HAS_TRAIT(BD, TRAIT_IGNORESLOWDOWN))
				ADD_TRAIT(BD, TRAIT_IGNORESLOWDOWN, SPECIES_TRAIT)
			BD.update_blood_hud()
			addtimer(CALLBACK(src, .proc/end_bloodpower), 100)
		else
			SEND_SOUND(BD, sound('code/modules/ziggers/sounds/need_blood.ogg', 0, 0, 75))
			to_chat(BD, "<span class='warning'>You don't have enough <b>BLOOD</b> to become more powerful.</span>")

/atom/movable/screen/bloodpower/proc/end_bloodpower()
	if(ishuman(usr))
		var/mob/living/carbon/human/BD = usr
		to_chat(BD, "<span class='warning'>You feel like your <b>BLOOD</b>-powers slowly decrease.</span>")
		if(BD.dna.species)
			BD.dna.species.punchdamagehigh -= 5
			BD.physiology.armor.melee -= 15
			BD.physiology.armor.bullet -= 15
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
	var/last_discipline_use = 0
	var/main_state = ""
	var/active = FALSE

/atom/MouseEntered(location,control,params)
	if(isturf(src) || ismob(src) || isobj(src))
		if(loc && ishuman(usr))
			var/mob/living/carbon/human/H = usr
			if(H.a_intent == INTENT_HARM)
				H.face_atom(src)
				H.harm_focus = H.dir

/mob/living/carbon/human/Move(atom/newloc, direct, glide_size_override)
	..()
	if(a_intent == INTENT_HARM)
		setDir(harm_focus)
	else
		harm_focus = dir

/mob/living/Click()
	if(ishuman(usr) && usr != src)
		var/mob/living/carbon/human/SH = usr
		for(var/atom/movable/screen/disciplines/DISCP in SH.hud_used.static_inventory)
			if(DISCP)
				if(DISCP.active)
					DISCP.range_activate(src, SH)
					SH.face_atom(src)
					return
	..()

/atom/Click(location,control,params)
	if(!isobserver(usr))
		usr.client.show_popup_menus = FALSE
	else
		usr.client.show_popup_menus = TRUE
	if(ishuman(usr))
		if(isopenturf(src.loc) || isopenturf(src))
			var/list/modifiers = params2list(params)
			var/mob/living/carbon/human/HUY = usr
			if(!HUY.get_active_held_item() && Adjacent(usr))
				if(LAZYACCESS(modifiers, "right"))
					var/list/shit = list()
					var/obj/item/item_to_pick
					var/turf/T
					if(isturf(src))
						T = src
					else
						T = src.loc
					for(var/obj/item/I in T)
						if(I)
							if(!I.anchored)
								shit[I.name] = I
						if(length(shit) == 1)
							item_to_pick = I
					if(length(shit) >= 2)
						var/result = input(usr, "Select the item you want to pick up.", "Pick up") as null|anything in shit
						if(result)
							item_to_pick = shit[result]
						else
							return
					if(item_to_pick)
						HUY.put_in_active_hand(item_to_pick)
						return
	..()

/mob/living/carbon/human
	var/atom/movable/screen/disciplines/toggled

/atom/movable/screen/disciplines/Click()
	var/dadelay = dscpln.delay
	if(dscpln.leveldelay)
		dadelay = dscpln.delay*dscpln.level
	SEND_SOUND(usr, sound('code/modules/ziggers/sounds/highlight.ogg', 0, 0, 50))
	if(ishuman(usr))
		var/mob/living/carbon/human/BD = usr
		if(world.time < last_discipline_click+5)
			return
		if(world.time < last_discipline_use+dadelay+5)
			return
		last_discipline_click = world.time
		if(active)
			active = FALSE
			BD.toggled = null
			icon_state = main_state
			return
		if(BD.bloodpool < dscpln.cost)
			SEND_SOUND(BD, sound('code/modules/ziggers/sounds/need_blood.ogg', 0, 0, 75))
			to_chat(BD, "<span class='warning'>You don't have enough <b>BLOOD</b> to use this discipline.</span>")
			return
		if(dscpln.ranged)
			for(var/atom/movable/screen/disciplines/DISCP in BD.hud_used.static_inventory)
				if(DISCP)
					if(DISCP.active && DISCP != src && DISCP.dscpln.ranged)
						DISCP.active = FALSE
						BD.toggled = null
						DISCP.icon_state = DISCP.main_state
			active = TRUE
			BD.toggled = src
			icon_state = "[main_state]-on"
		else if(!dscpln.ranged)
			last_discipline_use = world.time
			icon_state = "[main_state]-on"
			dscpln.activate(BD, BD)
			spawn(dadelay)
				icon_state = main_state

/atom/movable/screen/disciplines/proc/range_activate(var/mob/living/trgt, var/mob/living/carbon/human/cstr)
	if(cstr.bloodpool < dscpln.cost)
		icon_state = main_state
		active = FALSE
		SEND_SOUND(cstr, sound('code/modules/ziggers/sounds/need_blood.ogg', 0, 0, 75))
		to_chat(cstr, "<span class='warning'>You don't have enough <b>BLOOD</b> to use this discipline.</span>")
		return
	dscpln.activate(trgt, cstr)
	last_discipline_use = world.time
	active = FALSE
	icon_state = main_state

/mob/living
	var/bloodpool = 7
	var/maxbloodpool = 10
	var/generation = 13
	var/humanity = 7
	var/masquerade = 5
	var/last_masquerade_violation = 0

/mob/living/carbon/human/Life()
	update_blood_hud()
	update_shadow()
	handle_vampire_music()
	..()


/mob/living/proc/update_blood_hud()
	if(!client || !hud_used)
		return
	maxbloodpool = 10+((13-generation)*2)
	if(hud_used.blood_icon)
		var/emm = round((bloodpool/maxbloodpool)*10)
		if(emm > 10)
			hud_used.blood_icon.icon_state = "blood10"
		if(emm < 0)
			hud_used.blood_icon.icon_state = "blood0"
		else
			hud_used.blood_icon.icon_state = "blood[emm]"
