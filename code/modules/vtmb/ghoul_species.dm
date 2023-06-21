/datum/species/ghoul
	name = "Ghoul"
	id = "ghoul"
	default_color = "FFFFFF"
	toxic_food = RAW
	species_traits = list(EYECOLOR, HAIR, FACEHAIR, LIPS, HAS_FLESH, HAS_BONE)
	inherent_traits = list(TRAIT_ADVANCEDTOOLUSER, TRAIT_VIRUSIMMUNE, TRAIT_NOCRITDAMAGE)
	use_skintones = TRUE
	limbs_id = "human"
	mutant_bodyparts = list("tail_human" = "None", "ears" = "None", "wings" = "None")
	brutemod = 1	//0.8 bilo
	burnmod = 1
	punchdamagelow = 10
	punchdamagehigh = 20
	dust_anim = "dust-h"
	var/mob/living/carbon/human/master
	var/changed_master = FALSE
	var/last_vitae = 0

/datum/action/ghoulinfo
	name = "About Me"
	desc = "Check assigned role, master, humanity, masquerade, known contacts etc."
	button_icon_state = "masquerade"
	check_flags = NONE
	var/mob/living/carbon/human/host

/datum/action/ghoulinfo/Trigger()
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
		var/datum/species/ghoul/G
		if(host.dna.species.name == "Ghoul")
			G = host.dna.species
			dat += " the ghoul"

		if(host.mind.assigned_role)
			if(host.mind.special_role)
				dat += ", carrying the <font color=red>[host.mind.special_role]</font> role."
			else
				dat += ", carrying the [host.mind.assigned_role] role."
		if(!host.mind.assigned_role)
			dat += "."
		dat += "<BR>"
		dat += "My Regnant is [G.master.real_name], I should obey their wants.<BR>"
		if(G.master.clane)
			if(G.master.clane.name != "Caitiff")
				dat += "Regnant's clan is [G.master.clane], maybe I can try some of it's disciplines..."
		if(host.mind.special_role)
			for(var/datum/antagonist/A in host.mind.antag_datums)
				if(A.objectives)
					dat += "[printobjectives(A.objectives)]<BR>"
		else
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
		if(length(host.knowscontacts) > 0)
			dat += "<b>I know some other of my kind in this city. Need to check my phone, there definetely should be:</b><BR>"
			for(var/i in host.knowscontacts)
				dat += "-[i] contact<BR>"
		host << browse(dat, "window=vampire;size=400x450;border=1;can_resize=1;can_minimize=0")
		onclose(host, "ghoul", src)

/datum/species/ghoul/on_species_gain(mob/living/carbon/human/C)
	..()
	C.update_body(0)
	C.last_experience = world.time+3000
	var/datum/action/ghoulinfo/infor = new()
	infor.host = C
	infor.Grant(C)

/datum/species/ghoul/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	for(var/datum/action/ghoulinfo/GI in C.actions)
		qdel(GI)

/datum/species/ghoul/check_roundstart_eligible()
	return TRUE

/datum/species/ghoul/spec_life(mob/living/carbon/human/H)
	. = ..()
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
			if(H.humanity <= 2)
				if(prob(5))
					if(prob(50))
						H.Stun(20)
						to_chat(H, "<span class='warning'>You stop in fear and remember your crimes against humanity...</span>")
						H.emote("cry")
					else
						to_chat(H, "<span class='warning'>You feel the rage rising as your last sins come to your head...</span>")
						H.drop_all_held_items()
						H.emote("scream")
		if(last_vitae+6000 < world.time && prob(20))
			to_chat(H, "<span class='userdanger'><b>I NEED VITAE...</b></span>")
			H.Stun(10)

/datum/species/human/spec_life(mob/living/carbon/human/H)
	. = ..()
	if(H.client && H.stat <= 2)
		if(H.client.prefs)
			if(H.client.prefs.humanity != H.humanity)
				H.client.prefs.humanity = H.humanity
				H.client.prefs.save_preferences()
				H.client.prefs.save_character()
			if(H.last_experience+600 <= world.time)
				H.client.prefs.exper = min(1440, H.client.prefs.exper+1)
				H.client.prefs.save_preferences()
				H.client.prefs.save_character()
				H.last_experience = world.time

			if(H.humanity <= 2)
				if(prob(5))
					if(prob(50))
						H.Stun(10)
						to_chat(H, "<span class='warning'>You stop in fear and remember your crimes against humanity...</span>")
						H.emote("cry")
					else
						to_chat(H, "<span class='warning'>You feel the rage rising as your last sins come to your head...</span>")
						H.drop_all_held_items()
						H.emote("scream")