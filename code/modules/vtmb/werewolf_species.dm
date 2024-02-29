/datum/species/garou
	name = "Werewolf"
	id = "garou"
	default_color = "FFFFFF"
	toxic_food = PINEAPPLE
	species_traits = list(EYECOLOR, HAIR, FACEHAIR, LIPS, HAS_FLESH, HAS_BONE)
	inherent_traits = list(TRAIT_ADVANCEDTOOLUSER, TRAIT_VIRUSIMMUNE)
	use_skintones = TRUE
	limbs_id = "human"
	wings_icon = "Dragon"
	mutant_bodyparts = list("tail_human" = "None", "ears" = "None", "wings" = "None")
	brutemod = 1
	heatmod = 1
	burnmod = 1
	punchdamagelow = 10
	punchdamagehigh = 20
	dust_anim = "dust-h"
	donation = TRUE

/mob/living/carbon
	var/datum/auspice/auspice
	var/obj/werewolf_holder/transformation/transformator

/datum/action/garouinfo
	name = "About Me"
	desc = "Check assigned role, auspice, generation, humanity, masquerade, known disciplines, known contacts etc."
	button_icon_state = "masquerade"
	check_flags = NONE
	var/mob/living/carbon/host

/datum/action/garouinfo/Trigger()
	if(host)
		var/dat = {"
			<style type="text/css">

			body {
				background-color: #090909; color: white;
			}

			</style>
			"}
		dat += "<center><h2>Memories</h2><BR></center>"
		dat += "[icon2html(getFlatIcon(host), host)]I am "
		if(host.real_name)
			dat += "[host.real_name],"
		if(!host.real_name)
			dat += "Unknown,"
		dat += " [host.auspice.tribe] [host.auspice.base_breed]"
//		if(host.clane)
//			dat += " the [host.clane.name]"
//		if(!host.clane)
//			dat += " the caitiff"

		if(host.mind)

			if(host.mind.assigned_role)
				if(host.mind.special_role)
					dat += ", carrying the [host.mind.assigned_role] (<font color=red>[host.mind.special_role]</font>) role."
				else
					dat += ", carrying the [host.mind.assigned_role] role."
			if(!host.mind.assigned_role)
				dat += "."
			dat += "<BR>"
		if(host.mind.special_role)
			for(var/datum/antagonist/A in host.mind.antag_datums)
				if(A.objectives)
					dat += "[printobjectives(A.objectives)]<BR>"

		dat += "<b>Physique</b>: [host.physique]<BR>"
		dat += "<b>Social</b>: [host.social]<BR>"
		dat += "<b>Mentality</b>: [host.mentality]<BR>"
		dat += "<b>Cruelty</b>: [host.blood]<BR>"
		if(host.friend_name)
			dat += "<b>Friend: [host.friend_name]</b><BR>"
		if(host.enemy_name)
			dat += "<b>Enemy: [host.enemy_name]</b><BR>"
		if(host.lover_name)
			dat += "<b>Lover: [host.lover_name]</b><BR>"
		if(length(host.knowscontacts) > 0)
			dat += "<b>I know some other of my kind in this city. Need to check my phone, there definetely should be:</b><BR>"
			for(var/i in host.knowscontacts)
				dat += "-[i] contact<BR>"
		host << browse(dat, "window=vampire;size=400x450;border=1;can_resize=1;can_minimize=0")
		onclose(host, "vampire", src)

/datum/species/garou/on_species_gain(mob/living/carbon/human/C)
	. = ..()
//	ADD_TRAIT(C, TRAIT_NOBLEED, HIGHLANDER)
	C.update_body(0)
	C.last_experience = world.time+3000
	var/datum/action/garouinfo/infor = new()
	infor.host = C
	infor.Grant(C)
	C.transformator = new(C)
	C.transformator.human_form = C

/datum/species/garou/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	for(var/datum/action/garouinfo/VI in C.actions)
		qdel(VI)

/datum/species/garou/check_roundstart_eligible()
	return FALSE

/proc/adjust_rage(var/amount, var/mob/living/carbon/C)
	if(amount > 0)
		SEND_SOUND(C, sound('code/modules/ziggers/sounds/rage_increase.ogg', 0, 0, 75))
		to_chat(C, "<span class='userdanger'><b>RAGE INCREASES</b></span>")
		C.auspice.rage = min(10, C.auspice.rage+amount)
	if(amount < 0)
		C.auspice.rage = max(0, C.auspice.rage+amount)
		SEND_SOUND(C, sound('code/modules/ziggers/sounds/rage_decrease.ogg', 0, 0, 75))
		to_chat(C, "<span class='userdanger'><b>RAGE DECREASES</b></span>")
		if(C.auspice.rage == 0)
			C.transformator.trans_gender(C, C.auspice.base_breed)
	C.update_rage_hud()

/proc/adjust_gnosis(var/amount, var/mob/living/carbon/C)
	if(amount > 0)
		SEND_SOUND(C, sound('code/modules/ziggers/sounds/rage_increase.ogg', 0, 0, 75))
		to_chat(C, "<span class='boldnotice'><b>GNOSIS INCREASES</b></span>")
		C.auspice.gnosis = min(C.auspice.start_gnosis, C.auspice.gnosis+amount)
	if(amount < 0)
		C.auspice.gnosis = max(0, C.auspice.gnosis+amount)
		SEND_SOUND(C, sound('code/modules/ziggers/sounds/rage_decrease.ogg', 0, 0, 75))
		to_chat(C, "<span class='boldnotice'><b>GNOSIS DECREASES</b></span>")
//		if(C.auspice.gnosis == 0)
//			C.transformator.trans_gender(C, C.auspice.base_breed)
	C.update_rage_hud()