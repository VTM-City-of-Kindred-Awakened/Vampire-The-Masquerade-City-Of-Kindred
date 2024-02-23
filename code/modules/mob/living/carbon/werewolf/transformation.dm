/datum/weretransing		//NO TRAINS ALLOWED
	var/atom/transformation/transformation

	var/damage = 0

	var/sprite_color = "black"
	var/sprite_scar = 0
	var/sprite_hair = 0
	var/sprite_hair_color = "#000000"
	var/sprite_eye_color = "#FFFFFF"

/datum/weretransing/proc/pref_transition(var/my_key)
	return

/atom/transformation
	var/mob/living/carbon/owner
	var/datum/weretransing/form_datum

	var/mob/living/carbon/human/human_form
	var/mob/living/carbon/werewolf/crinos/crinos_form
	var/mob/living/carbon/werewolf/lupus/lupus_form

/atom/transformation/Initialize()
	. = ..()
	if(isliving(loc))
		var/mob/living/L = loc
		if(L.key)
			form_datum.pref_transition("[L.key]")
		if(istype(loc, /mob/living/carbon/werewolf/lupus))
			lupus_form = loc
		if(istype(loc, /mob/living/carbon/werewolf/crinos))
			crinos_form = loc
		if(istype(loc, /mob/living/carbon/human))
			human_form = loc

		if(!human_form)
			human_form = new(src)
		if(!crinos_form)
			crinos_form = new(src)
		if(!lupus_form)
			lupus_form = new(src)

/atom/transformation/proc/trans_gender(mob/trans, form)
	var/current_loc = get_turf(owner)
	switch(form)
		if("Lupus")
			if(trans == lupus_form)
				return
			lupus_form.forceMove(current_loc)
			trans.forceMove(src)
			lupus_form.key = trans.key
		if("Crinos")
			if(trans == crinos_form)
				return
			crinos_form.forceMove(current_loc)
			trans.forceMove(src)
			crinos_form.key = trans.key
		if("Human")
			if(trans == human_form)
				return
			human_form.forceMove(current_loc)
			trans.forceMove(src)
			human_form.key = trans.key
