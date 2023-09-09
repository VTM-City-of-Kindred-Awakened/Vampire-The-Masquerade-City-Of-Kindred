/mob/living
	var/elysium_checks = 0
	var/bloodhunted = FALSE

/atom/movable/screen/alert/bloodhunt
	name = "Blood Hunt Is Going On"
	icon_state = "bloodhunt"

/atom/movable/screen/alert/bloodhunt/Click()
	for(var/mob/living/carbon/human/H in SSbloodhunt.hunted)
		if(H)
			var/area/A = get_area(H)
			to_chat(usr, "[icon2html(getFlatIcon(H), usr)][H.dna.real_name], [H.mind.assigned_role]. Was last seen at [A.name]")

/mob/living/proc/check_elysium(var/instant = FALSE)
	if(!ishuman(src))
		return
	var/area/vtm/V
	if(istype(get_area(src), /area/vtm))
		V = get_area(src)
		var/mob/living/carbon/human/H = src
		if(V.zone_owner == H.frakcja)
			return
		for(var/mob/living/carbon/human/HU in SSbloodhunt.hunted)
			if(HU)
				if(HU.real_name == H.real_name)
					return
	to_chat(src, "<span class='userdanger'><b>You feel like your actions are against the rules...</b></span>")
	if(instant)
		SSbloodhunt.announce_hunted(src)
		if(V)
			V.break_elysium()
	else
		elysium_checks = elysium_checks+1
		if(elysium_checks > 2)
			SSbloodhunt.announce_hunted(src)
			if(V)
				V.break_elysium()


SUBSYSTEM_DEF(bloodhunt)
	name = "Blood Hunt"
	init_order = INIT_ORDER_DEFAULT
	wait = 300
	priority = FIRE_PRIORITY_DEFAULT

	var/list/hunted = list()

/datum/controller/subsystem/bloodhunt/fire()
	update_shit()

/datum/controller/subsystem/bloodhunt/proc/update_shit()
	for(var/mob/living/L in hunted)
		if(QDELETED(L))
			hunted -= L
	if(length(hunted))
		for(var/mob/living/carbon/human/H in GLOB.player_list)
			if(iskindred(H) || isghoul(H))
				H.throw_alert("bloodhunt", /atom/movable/screen/alert/bloodhunt)
	else
		for(var/mob/living/carbon/human/H in GLOB.player_list)
			if(iskindred(H) || isghoul(H))
				H.clear_alert("bloodhunt")

/datum/controller/subsystem/bloodhunt/proc/announce_hunted(var/mob/living/target)
	if(!ishuman(target))
		return
	var/mob/living/carbon/human/H = target
	if(!H.bloodhunted)
		H.bloodhunted = TRUE
		to_chat(world, "<b>The Blood Hunt after <span class='warning'>[H.dna.real_name]</span> has been announced!</b>")
		SEND_SOUND(world, sound('code/modules/ziggers/sounds/announce.ogg'))
		hunted += H
		update_shit()