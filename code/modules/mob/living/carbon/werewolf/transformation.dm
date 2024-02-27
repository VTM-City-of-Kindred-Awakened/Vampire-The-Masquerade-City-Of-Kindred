/obj/werewolf_holder/transformation
	var/mob/living/carbon/human/human_form
	var/mob/living/carbon/werewolf/crinos/crinos_form
	var/mob/living/carbon/werewolf/lupus/lupus_form

/obj/werewolf_holder/transformation/Initialize()
	. = ..()
	crinos_form = new()
	crinos_form.transformator = src
	lupus_form = new()
	lupus_form.transformator = src

/obj/werewolf_holder/transformation/proc/trans_gender(mob/trans, form)
	var/current_loc = get_turf(trans)
	switch(form)
		if("Lupus")
			if(trans == lupus_form)
				return
			lupus_form.forceMove(current_loc)
			lupus_form.key = trans.key
			forceMove(lupus_form)
			trans.forceMove(src)
		if("Crinos")
			if(trans == crinos_form)
				return
			crinos_form.forceMove(current_loc)
			crinos_form.key = trans.key
			forceMove(crinos_form)
			trans.forceMove(src)
		if("Homid")
			if(trans == human_form)
				return
			human_form.forceMove(current_loc)
			human_form.key = trans.key
			forceMove(human_form)
			trans.forceMove(src)