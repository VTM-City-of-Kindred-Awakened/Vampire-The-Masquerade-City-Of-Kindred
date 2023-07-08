/datum/vampireclane/tremere
	name = "Tremere"
	desc = "The arcane Clan Tremere were once a house of mortal mages who sought immortality but found only undeath. As vampires, they’ve perfected ways to bend their own Blood to their will, employing their sorceries to master and ensorcel both the mortal and vampire world. Their power makes them valuable, but few vampires trust their scheming ways."
	curse = "Blood magic."
	clane_disciplines = list(/datum/discipline/auspex = 1,
														/datum/discipline/dominate = 2,
														/datum/discipline/thaumaturgy = 3)
	male_clothes = "/obj/item/clothing/under/vampire/tremere"
	female_clothes = "/obj/item/clothing/under/vampire/tremere/female"

/datum/vampireclane/tremere/post_gain(mob/living/carbon/human/H)
	var/datum/action/thaumaturgy/T = new()
	T.Grant(H)
	H.faction |= "Tremere"

/datum/action/thaumaturgy
	name = "Thaumaturgy"
	desc = "Blood magic rune drawing."
	button_icon_state = "thaumaturgy"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	var/drawing = FALSE

/datum/action/thaumaturgy/Trigger()
	. = ..()
	var/mob/living/carbon/human/H = owner
	if(H.bloodpool < 2)
		to_chat(H, "<span class='warning'>You need more <b>BLOOD</b> to do that!</span>")
	if(drawing)
		return

	if(istype(H.get_active_held_item(), /obj/item/arcane_tome))
		var/ritual = input(owner, "Choose rune to draw:", "Thaumaturgy") as anything in subtypesof(/obj/ritualrune)
		if(ritual)
			drawing = TRUE
			if(do_after(H, 30, H))
				drawing = FALSE
				new ritual(H.loc)
				H.bloodpool = max(0, H.bloodpool-2)
			else
				drawing = FALSE
	else
		var/ritual = input(owner, "Choose rune to draw:", "Thaumaturgy") as anything in list("???")
		if(ritual)
			drawing = TRUE
			if(do_after(H, 30, H))
				drawing = FALSE
//				var/list/runes = subtypesof(/obj/ritualrune)
				var/rune = pick(subtypesof(/obj/ritualrune))
				new rune(H.loc)
				H.bloodpool = max(0, H.bloodpool-2)
			else
				drawing = FALSE