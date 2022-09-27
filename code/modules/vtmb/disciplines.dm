/datum/discipline
	var/name = "Shit Aggresively"
	var/desc = "Shit with blood, cope and seethe"
	var/icon_state
	var/cost = 2
	var/last_activate = 0

/datum/discipline/proc/activate(var/mob/living/target, var/mob/living/caster)
	if(!caster)
		return
	if(world.time < last_activate+100)
		return
	if(!target)
		var/choice = input(caster, "Choose your target", "Available Targets") as mob in oviewers(4, caster)
		if(choice)
			target = choice
		else
			return
	if(caster.bloodpool < cost)
		SEND_SOUND(caster, sound('code/modules/ziggers/need_blood.ogg'))
		to_chat(caster, "<span class='warning'>You don't have enough <b>BLOOD</b> to use this discipline.</span>")
		return
	last_activate = world.time
	caster.bloodpool -= cost

/datum/discipline/animalism
	name = "Animalism"
	desc = "Summons Spectral Wolf over your targets."
	icon_state = "animalism"
	cost = 2

/datum/discipline/animalism/activate(mob/living/target, mob/living/caster)
	..()
	target.apply_damage(25, BRUTE, BODY_ZONE_CHEST)