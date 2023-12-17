/mob/living/carbon/werewolf/update_damage_overlays() //aliens don't have damage overlays.
	return

/mob/living/carbon/werewolf/update_body() // we don't use the bodyparts or body layers for aliens.
	return

/mob/living/carbon/werewolf/update_body_parts()//we don't use the bodyparts layer for aliens.
	return

/mob/living/carbon/werewolf/crinos/update_icons()
	cut_overlays()
	for(var/I in overlays_standing)
		add_overlay(I)

	var/asleep = IsSleeping()
	if(stat == DEAD)
		//If we mostly took damage from fire
		if(getFireLoss() > 125)
			icon_state = "alien[caste]_husked"
		else
			icon_state = "alien[caste]_dead"

	else if((stat == UNCONSCIOUS && !asleep) || stat == HARD_CRIT || stat == SOFT_CRIT || IsParalyzed())
		icon_state = "alien[caste]_unconscious"
	else if(leap_on_click)
		icon_state = "alien[caste]_pounce"

	else if(body_position == LYING_DOWN)
		icon_state = "alien[caste]_sleep"
	else if(mob_size == MOB_SIZE_LARGE)
		icon_state = "alien[caste]"
		if(drooling)
			add_overlay("alienspit_[caste]")
	else
		icon_state = "alien[caste]"
		if(drooling)
			add_overlay("alienspit")

	if(leaping)
		if(alt_icon == initial(alt_icon))
			var/old_icon = icon
			icon = alt_icon
			alt_icon = old_icon
		icon_state = "alien[caste]_leap"
		pixel_x = base_pixel_x - 32
		pixel_y = base_pixel_y - 32
	else
		if(alt_icon != initial(alt_icon))
			var/old_icon = icon
			icon = alt_icon
			alt_icon = old_icon
	pixel_x = base_pixel_x + body_position_pixel_x_offset
	pixel_y = base_pixel_y + body_position_pixel_y_offset
	update_inv_hands()
	update_inv_handcuffed()

/mob/living/carbon/werewolf/crinos/regenerate_icons()
	if(!..())
	//	update_icons() //Handled in update_transform(), leaving this here as a reminder
		update_transform()

/mob/living/carbon/werewolf/crinos/update_transform() //The old method of updating lying/standing was update_icons(). Aliens still expect that.
	. = ..()
	update_icons()