/datum/species/ghoul
	name = "Ghoul"
	id = "ghoul"
	default_color = "FFFFFF"
	toxic_food = RAW
	species_traits = list(EYECOLOR, HAIR, FACEHAIR, LIPS, HAS_FLESH, HAS_BONE)
	inherent_traits = list(TRAIT_ADVANCEDTOOLUSER, TRAIT_VIRUSIMMUNE, TRAIT_NOCRITDAMAGE, TRAIT_LIMBATTACHMENT)
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
				dat += ", carrying the [host.mind.assigned_role] (<font color=red>[host.mind.special_role]</font>) role."
			else
				dat += ", carrying the [host.mind.assigned_role] role."
		if(!host.mind.assigned_role)
			dat += "."
		dat += "<BR>"
		if(G.master)
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
	var/datum/action/blood_heal/bloodheal = new()
	bloodheal.Grant(C)
	var/datum/action/take_vitae/TV = new()
	TV.Grant(C)
	C.generation = 13
	C.bloodpool = 10
	C.maxbloodpool = 10
	C.maxHealth = 100
	C.health = 100

/datum/species/ghoul/on_species_loss(mob/living/carbon/human/C, datum/species/new_species, pref_load)
	. = ..()
	for(var/datum/action/ghoulinfo/GI in C.actions)
		qdel(GI)
	for(var/datum/action/blood_heal/BH in C.actions)
		qdel(BH)
	for(var/datum/action/take_vitae/TV in C.actions)
		qdel(TV)

/datum/action/take_vitae
	name = "Take Vitae"
	desc = "Take vitae from a Vampire by force."
	button_icon_state = "ghoul"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	var/taking = FALSE

/datum/action/take_vitae/Trigger()
	if(istype(owner, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = owner
		if(istype(H.pulling, /mob/living/carbon/human))
			var/mob/living/carbon/human/VIT = H.pulling
			if(iskindred(VIT))
				if(VIT.bloodpool)
					if(VIT.getBruteLoss() > 30)
						taking = TRUE
						if(do_mob(owner, VIT, 10 SECONDS))
							taking = FALSE
							H.drunked_of |= "[VIT.dna.real_name]"
							H.adjustBruteLoss(-25, TRUE)
							H.adjustFireLoss(-25, TRUE)
							VIT.bloodpool = max(0, VIT.bloodpool-1)
							H.bloodpool = min(H.maxbloodpool, H.bloodpool+1)
							to_chat(owner, "<span class='warning'>You feel precious <b>VITAE</b> entering your mouth and suspending your addiction.</span>")
							return
						else
							taking = FALSE
							return
					else
						to_chat(owner, "<span class='warning'>Damage [VIT] before taking vitae.</span>")
						return
				else
					to_chat(owner, "<span class='warning'>There is not enough <b>VITAE</b> in [VIT] to feed your addiction.</span>")
					return
			else
				to_chat(owner, "<span class='warning'>You don't sense the <b>VITAE</b> in [VIT].</span>")
				return

/datum/action/blood_heal
	name = "Blood Heal"
	desc = "Use vitae in your blood to heal your wounds."
	button_icon_state = "bloodheal"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	var/last_heal = 0
	var/level = 1

/datum/action/blood_heal/Trigger()
	if(istype(owner, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = owner
		if(HAS_TRAIT(H, TRAIT_COFFIN_THERAPY))
			if(!istype(H.loc, /obj/structure/closet/crate/coffin))
				to_chat(usr, "<span class='warning'>You need to be in a coffin to use that!</span>")
				return
		if(H.bloodpool < 1)
			to_chat(owner, "<span class='warning'>You don't have enough <b>BLOOD</b> to do that!</span>")
			SEND_SOUND(H, sound('code/modules/ziggers/sounds/need_blood.ogg', 0, 0, 75))
			return
		if(last_heal+30 >= world.time)
			return
		last_heal = world.time
		H.bloodpool = max(0, H.bloodpool-1)
		playsound(H, 'code/modules/ziggers/sounds/bloodhealing.ogg', 50, FALSE)
		H.adjustBruteLoss(-10*level, TRUE)
		H.adjustFireLoss(-10*level, TRUE)
		if(length(H.all_wounds))
			var/datum/wound/W = pick(H.all_wounds)
			W.remove_wound()
		H.update_damage_overlays()
		H.update_health_hud()
		H.visible_message("<span class='warning'>Some of [H]'s visible injuries disappear!</span>", "<span class='warning'>Some of your injuries disappear!</span>")

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
				H.client.prefs.exper = min(calculate_mob_max_exper(H), H.client.prefs.exper+5+H.experience_plus)
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
		if(last_vitae+3000 < world.time)
			last_vitae = world.time
			if(H.bloodpool > 1)
				H.bloodpool = max(1, H.bloodpool-1)
			else
				if(prob(20))
					to_chat(H, "<span class='userdanger'><b>I NEED VITAE...</b></span>")
					H.Stun(10)

/mob/living
	var/last_bloodpool_restore = 0

/datum/species/human/spec_life(mob/living/carbon/human/H)
	. = ..()
	if(H.last_bloodpool_restore+600 <= world.time)
		H.last_bloodpool_restore = world.time
		H.bloodpool = min(H.maxbloodpool, H.bloodpool+1)

	if(H.client && H.stat <= 2)
		if(H.client.prefs)
			if(H.client.prefs.humanity != H.humanity)
				H.client.prefs.humanity = H.humanity
				H.client.prefs.save_preferences()
				H.client.prefs.save_character()
			if(H.last_experience+600 <= world.time)
				H.client.prefs.exper = min(calculate_mob_max_exper(H), H.client.prefs.exper+5+H.experience_plus)
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