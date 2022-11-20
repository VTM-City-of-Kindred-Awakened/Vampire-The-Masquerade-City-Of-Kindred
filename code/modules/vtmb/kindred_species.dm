/* a basic datum базированный датум для расы вампиров. Кланы и дисциплины храняться в другом месте
*/
#define DEFAULT_BLOOD_LOSS 0.2
/datum/species/kindred
	name = "Vampire"
	id = "kindred"
	default_color = "FFFFFF"
	toxic_food = MEAT | VEGETABLES | RAW | JUNKFOOD | GRAIN | FRUIT | DAIRY | FRIED | ALCOHOL | SUGAR | PINEAPPLE
	species_traits = list(EYECOLOR, HAIR,FACEHAIR, LIPS, HAS_FLESH, HAS_BONE)
	inherent_traits = list(TRAIT_ADVANCEDTOOLUSER, TRAIT_VIRUSIMMUNE, TRAIT_NOHUNGER, TRAIT_NOBREATH, TRAIT_TOXIMMUNE, TRAIT_NOCRITDAMAGE)
	use_skintones = TRUE
	limbs_id = "human"
	mutant_bodyparts = list("tail_human" = "None", "ears" = "None", "wings" = "None")
	brutemod = 1	//0.8 bilo
	burnmod = 2
	punchdamagelow = 10
	punchdamagehigh = 20
	dust_anim = "dust-h"
	var/datum/vampireclane/clane

/mob/living
	var/list/knowscontacts = list()

/datum/action/vampireinfo
	name = "About Me"
	desc = "Check assigned role, clane, generation, humanity, masquerade, known disciplines, known contacts etc."
	button_icon_state = "masquerade"
	check_flags = NONE
	var/mob/living/carbon/human/host

/datum/action/vampireinfo/Trigger()
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
		if(host.clane)
			dat += " the [host.clane.name]"
		if(!host.clane)
			dat += " the caitiff"
		if(host.mind.assigned_role)
			dat += ", carrying the [host.mind.assigned_role] role."
		if(!host.mind.assigned_role)
			dat += "."
		dat += "<BR>"
		if(host.generation)
			dat += "I'm from [host.generation] generation.<BR>"
		var/masquerade_level = " followed the Masquerade Tradition perfectly."
		switch(host.masquerade)
			if(4)
				masquerade_level = " broke the Masquerade rule once."
			if(3)
				masquerade_level = " made a couple of Masquerade breaches."
			if(2)
				masquerade_level = " provoked a moderate Masquerade breach."
			if(1)
				masquerade_level = " almost ruined the Masquerade."
			if(0)
				masquerade_level = "'m danger to the Masquerade and my own kind."
		dat += "Camarilla thinks I[masquerade_level]<BR>"
		var/humanity = "I'm out of my mind."
		switch(host.humanity)
			if(8 to 10)
				humanity = "I'm the best example of mercy and kindness."
			if(7)
				humanity = "I have nothing to complain about my humanity."
			if(5 to 6)
				humanity = "I'm slightly above the humane."
			if(4)
				humanity = "I don't care about kine."
			if(2 to 3)
				humanity = "There's nothing bad in murdering for <b>BLOOD</b>."
			if(1)
				humanity = "I'm slowly falling into madness..."
		dat += "[humanity]<BR>"
		if(host.client)
			if(host.clane.clane_disciplines)
				dat += "<b>Known disciplines:</b><BR>"
				if(length(host.clane.clane_disciplines) >= 1)
					var/datype = host.clane.clane_disciplines[1]
					var/datum/discipline/AD = new datype()
					dat += "[AD.name] [host.client.prefs.discipline1level] - [AD.desc]<BR>"
				if(length(host.clane.clane_disciplines) >= 2)
					var/datype = host.clane.clane_disciplines[2]
					var/datum/discipline/AD = new datype()
					dat += "[AD.name] [host.client.prefs.discipline2level] - [AD.desc]<BR>"
				if(length(host.clane.clane_disciplines) >= 3)
					var/datype = host.clane.clane_disciplines[3]
					var/datum/discipline/AD = new datype()
					dat += "[AD.name] [host.client.prefs.discipline3level] - [AD.desc]<BR>"
		if(length(host.knowscontacts) > 0)
			dat += "<b>I know some other of my kind in this city. Need to check my phone, there definetely should be:</b><BR>"
			for(var/i in host.knowscontacts)
				dat += "-[i] contact<BR>"
		host << browse(dat, "window=vampire;size=400x450;border=1;can_resize=1;can_minimize=0")
		onclose(host, "vampire", src)

/datum/species/kindred/spec_life(mob/living/carbon/human/H)
	. = ..()
	SEND_SIGNAL(H, COMSIG_VAMP_WASTEBLOOD, DEFAULT_BLOOD_LOSS)

/datum/species/kindred/on_species_gain(mob/living/carbon/human/C)
	..()
	C.update_body(0)
	C.last_experience = world.time+3000
	var/datum/action/vampireinfo/infor = new()
	infor.host = C
	infor.Grant(C)

/datum/species/kindred/check_roundstart_eligible()
	return TRUE