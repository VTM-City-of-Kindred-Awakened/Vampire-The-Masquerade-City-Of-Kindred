/obj/item/arcane_tome
	name = "arcane tome"
	desc = "The secrets of Blood Magic..."
	icon_state = "arcane"
	icon = 'code/modules/ziggers/items.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	w_class = WEIGHT_CLASS_SMALL
	var/list/rituals = list()

/obj/item/arcane_tome/Initialize()
	. = ..()
	for(var/i in subtypesof(/datum/ritual))
		if(i)
			var/datum/ritual/R = new i()
			rituals |= R

/obj/ritualrune
	name = "Tremere Rune"
	desc = "Learn the secrets of blood, neonate..."
	icon = 'code/modules/ziggers/icons.dmi'
	icon_state = "rune1"
	color = rgb(255,0,0)
	flags_1 = HEAR_1
	var/datum/ritual/ritual

/datum/ritual
	var/name = "Ritual"
	var/desc = "Blood shitting"
	var/rune_sprite = "rune1"
	var/word = "IDI NAH"
	var/sacrifice
	var/result

/mob/living
	var/thaumaturgy_knowledge = FALSE

/obj/ritualrune/proc/complete()
	if(ritual)
		if(ritual.result)
			new ritual.result(loc)
	qdel(src)

/obj/ritualrune/proc/handle_hearing(datum/source, list/hearing_args)
	if(!ritual)
		return
	var/message = hearing_args[HEARING_RAW_MESSAGE]
	if(hearing_args[HEARING_SPEAKER])
		if(isliving(hearing_args[HEARING_SPEAKER]))
			var/mob/living/L = hearing_args[HEARING_SPEAKER]
			if(L.thaumaturgy_knowledge)
				if(message == ritual.word)
					if(ritual.sacrifice)
						for(var/atom/A in loc)
							if(A == ritual.sacrifice)
								qdel(A)
					complete()

/datum/ritual/blood_guardian
	name = "Blood Guardian"
	desc = "Creates the Blood Guardian to protect tremere or his domain."
	rune_sprite = "rune1"
	word = "UR'JOLA"
//	sacrifice =
//	result =

/datum/ritual/blood_trap
	name = "Blood Trap"
	desc = "Creates the Blood Trap to protect tremere or his domain."
	rune_sprite = "rune2"
	word = "DUH'K A'U"

/datum/ritual/blood_wall
	name = "Blood Wall"
	desc = "Creates the Blood Wall to protect tremere or his domain."
	rune_sprite = "rune3"
	word = "SOT'PY"

