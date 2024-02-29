/obj/werewolf_holder/transformation
	var/mob/living/carbon/human/human_form
	var/mob/living/carbon/werewolf/crinos/crinos_form
	var/mob/living/carbon/werewolf/lupus/lupus_form

	var/transformating = FALSE

/obj/werewolf_holder/transformation/Initialize()
	. = ..()
	crinos_form = new()
	crinos_form.transformator = src
//	crinos_form.forceMove(src)
	lupus_form = new()
	lupus_form.transformator = src
//	lupus_form.forceMove(src)

/obj/werewolf_holder/transformation/proc/trans_gender(mob/trans, form)
	var/matrix/ntransform = matrix(transform) //aka transform.Copy()
	if(iscarbon(trans))
		var/mob/living/carbon/C = trans
		if(C.auspice.rage <= 1 && form != C.auspice.base_breed)
			to_chat(trans, "Not enough rage to transform into anything but [C.auspice.base_breed]")
			return
	switch(form)
		if("Lupus")
			if(iscrinos(trans))
				ntransform.Scale(0.75, 0.75)
			if(ishuman(trans))
				ntransform.Scale(1, 0.75)
		if("Crinos")
			if(islupus(trans))
				ntransform.Scale(1.75, 1.75)
			if(ishuman(trans))
				ntransform.Scale(1.25, 1.5)
		if("Homid")
			if(iscrinos(trans))
				ntransform.Scale(0.75, 0.5)
			if(islupus(trans))
				ntransform.Scale(1, 1.5)
	if(!transformating)
		transformating = TRUE
		switch(form)
			if("Lupus")
				if(trans == lupus_form)
					transformating = FALSE
					return
				animate(trans, transform = ntransform, color = "#000000", time = 30)
				playsound(get_turf(trans), 'code/modules/ziggers/sounds/transform.ogg', 50, FALSE)
				spawn(30)
					var/current_loc = get_turf(trans)
					lupus_form.color = "#000000"
					lupus_form.forceMove(current_loc)
					animate(lupus_form, color = "#FFFFFF", time = 10)
					lupus_form.key = trans.key
					forceMove(lupus_form)
					trans.forceMove(src)
					transformating = FALSE
					animate(trans, transform = null, color = "#FFFFFF", time = 1)
					lupus_form.update_icons()
//					if(lupus_form.auspice.base_breed != "Lupus")
//						adjust_rage(-1, lupus_form)
			if("Crinos")
				if(trans == crinos_form)
					transformating = FALSE
					return
				animate(trans, transform = ntransform, color = "#000000", time = 30)
				playsound(get_turf(trans), 'code/modules/ziggers/sounds/transform.ogg', 50, FALSE)
				spawn(30)
					var/current_loc = get_turf(trans)
					crinos_form.color = "#000000"
					crinos_form.forceMove(current_loc)
					animate(crinos_form, color = "#FFFFFF", time = 10)
					crinos_form.key = trans.key
					forceMove(crinos_form)
					trans.forceMove(src)
					transformating = FALSE
					animate(trans, transform = null, color = "#FFFFFF", time = 1)
					crinos_form.update_icons()
//					if(crinos_form.auspice.base_breed != "Crinos")
//						adjust_rage(-1, crinos_form)
			if("Homid")
				if(trans == human_form)
					transformating = FALSE
					return
				animate(trans, transform = ntransform, color = "#000000", time = 30)
				playsound(get_turf(trans), 'code/modules/ziggers/sounds/transform.ogg', 50, FALSE)
				spawn(30)
					var/current_loc = get_turf(trans)
					human_form.color = "#000000"
					human_form.forceMove(current_loc)
					animate(human_form, color = "#FFFFFF", time = 10)
					human_form.key = trans.key
					forceMove(human_form)
					trans.forceMove(src)
					transformating = FALSE
					animate(trans, transform = null, color = "#FFFFFF", time = 1)
//					if(human_form.auspice.base_breed != "Homid")
//						adjust_rage(-1, human_form)

/obj/werewolf_holder/transformation/proc/fast_trans_gender(mob/trans, form)
	switch(form)
		if("Lupus")
			if(trans == lupus_form)
				return
			var/current_loc = get_turf(trans)
			lupus_form.forceMove(current_loc)
			lupus_form.key = trans.key
			forceMove(lupus_form)
			trans.forceMove(src)
		if("Crinos")
			if(trans == crinos_form)
				return
			var/current_loc = get_turf(trans)
			crinos_form.forceMove(current_loc)
			crinos_form.key = trans.key
			forceMove(crinos_form)
			trans.forceMove(src)
		if("Homid")
			if(trans == human_form)
				return
			var/current_loc = get_turf(trans)
			human_form.forceMove(current_loc)
			human_form.key = trans.key
			forceMove(human_form)
			trans.forceMove(src)