/datum/action/gift
	icon_icon = 'code/modules/ziggers/werewolf_abilities.dmi'
	check_flags = AB_CHECK_IMMOBILE|AB_CHECK_CONSCIOUS
	var/rage_req = 0
	var/gnosis_req = 0
	var/cool_down = 0

	var/allowed_to_proceed = FALSE

/datum/action/gift/Trigger()
	. = ..()
	if(istype(owner, /mob/living/carbon))
		var/mob/living/carbon/H = owner
		if(rage_req)
			if(H.auspice.rage < rage_req)
				to_chat(owner, "<span class='warning'>You don't have enough <b>RAGE</b> to do that!</span>")
				SEND_SOUND(owner, sound('code/modules/ziggers/sounds/werewolf_cast_failed.ogg', 0, 0, 75))
				allowed_to_proceed = FALSE
				return
			if(H.auspice.gnosis < gnosis_req)
				to_chat(owner, "<span class='warning'>You don't have enough <b>GNOSIS</b> to do that!</span>")
				SEND_SOUND(owner, sound('code/modules/ziggers/sounds/werewolf_cast_failed.ogg', 0, 0, 75))
				allowed_to_proceed = FALSE
				return
		if(cool_down+200 >= world.time)
			allowed_to_proceed = FALSE
			return
		cool_down = world.time
		allowed_to_proceed = TRUE
		if(rage_req)
			adjust_rage(-rage_req, owner, FALSE)
		if(gnosis_req)
			adjust_gnosis(-gnosis_req, owner, FALSE)
		to_chat(owner, "<span class='notice'>You activate the [name]...</span>")

/datum/action/gift/falling_touch
	name = "Falling Touch"
	desc = "This Gift allows the Garou to send her foe sprawling with but a touch."
	button_icon_state = "falling_touch"
	rage_req = 1

/datum/action/gift/falling_touch/Trigger()
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/H = owner
		playsound(get_turf(owner), 'code/modules/ziggers/sounds/falling_touch.ogg', 75, FALSE)
		H.put_in_active_hand(new /obj/item/melee/touch_attack/werewolf(H))

/datum/action/gift/inspiration
	name = "Inspiration"
	desc = "The Garou with this Gift lends new resolve and righteous anger to his brethren."
	button_icon_state = "inspiration"
//	rage_req = 1

/mob/living/carbon
	var/inspired = FALSE

/mob/living/carbon/Life()
	. = ..()
	if(inspired)
		if(stat != DEAD)
			adjustBruteLoss(-4, TRUE)
			var/obj/effect/celerity/C = new(get_turf(src))
			C.appearance = appearance
			C.dir = dir
			var/matrix/ntransform = matrix(C.transform)
			ntransform.Scale(2, 2)
			animate(C, transform = ntransform, alpha = 0, time = 3)

/mob/living/carbon/proc/inspired()
	inspired = TRUE
	to_chat(src, "<span class='notice'>You feel inspired...</span>")
	spawn(150)
		to_chat(src, "<span class='warning'>You no longer feel inspired...</span>")
		inspired = FALSE

/datum/action/gift/inspiration/Trigger()
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/H = owner
		playsound(get_turf(owner), 'code/modules/ziggers/sounds/inspiration.ogg', 75, FALSE)
		H.emote("scream")
		for(var/mob/living/carbon/C in range(5, owner))
			if(C)
				if(iswerewolf(C) || isgarou(C))
					if(C.auspice.tribe == H.auspice.tribe)
						C.inspired()

/datum/action/gift/razor_claws
	name = "Razor Claws"
	desc = "By raking his claws over stone, steel, or another hard surface, the Ahroun hones them to razor sharpness."
	button_icon_state = "razor_claws"
	rage_req = 1

/datum/action/gift/razor_claws/Trigger()
	. = ..()
	if(allowed_to_proceed)
		if(ishuman(owner))
			playsound(get_turf(owner), 'code/modules/ziggers/sounds/razor_claws.ogg', 75, FALSE)
			var/mob/living/carbon/human/H = owner
			H.dna.species.attack_verb = "slash"
			H.dna.species.attack_sound = 'sound/weapons/slash.ogg'
			H.dna.species.miss_sound = 'sound/weapons/slashmiss.ogg'
			H.dna.species.punchdamagelow = 25
			H.dna.species.punchdamagehigh = 25
			to_chat(owner, "<span class='notice'>You feel your claws sharpening...</span>")
			spawn(150)
				H.dna.species.attack_verb = initial(H.dna.species.attack_verb)
				H.dna.species.attack_sound = initial(H.dna.species.attack_sound)
				H.dna.species.miss_sound = initial(H.dna.species.miss_sound)
				H.dna.species.punchdamagelow = initial(H.dna.species.punchdamagelow)
				H.dna.species.punchdamagehigh = initial(H.dna.species.punchdamagehigh)
				to_chat(owner, "<span class='warning'>Your claws are not sharp anymore...</span>")
		else
			playsound(get_turf(owner), 'code/modules/ziggers/sounds/razor_claws.ogg', 75, FALSE)
			var/mob/living/carbon/H = owner
			H.melee_damage_lower = H.melee_damage_lower+20
			H.melee_damage_upper = H.melee_damage_upper+20
			to_chat(owner, "<span class='notice'>You feel your claws sharpening...</span>")
			spawn(150)
				H.melee_damage_lower = initial(H.melee_damage_lower)
				H.melee_damage_upper = initial(H.melee_damage_upper)
				to_chat(owner, "<span class='warning'>Your claws are not sharp anymore...</span>")

/datum/action/gift/beast_speech
	name = "Beast Speech"
	desc = "The werewolf with this Gift may communicate with any animals from fish to mammals."
	button_icon_state = "beast_speech"
//	gnosis_req = 1

/datum/action/gift/call_of_the_wyld
	name = "Call Of The Wyld"
	desc = "The werewolf may send her howl far beyond the normal range of hearing and imbue it with great emotion, stirring the hearts of fellow Garou and chilling the bones of all others."
	button_icon_state = "call_of_the_wyld"
	rage_req = 1
//	awo1

/datum/action/gift/mindspeak
	name = "Mindspeak"
	desc = "By invoking the power of waking dreams, the Garou can place any chosen characters into silent communion."
	button_icon_state = "mindspeak"
	gnosis_req = 1

/datum/action/gift/resist_pain
	name = "Resist Pain"
	desc = "Through force of will, the Philodox is able to ignore the pain of his wounds and continue acting normally."
	button_icon_state = "resist_pain"
	rage_req = 1

/datum/action/gift/scent_of_the_true_form
	name = "Scent Of The True Form"
	desc = "This Gift allows the Garou to determine the true nature of a person."
	button_icon_state = "scent_of_the_true_form"
	gnosis_req = 1

/datum/action/gift/truth_of_gaia
	name = "Truth Of Gaia"
	desc = "As judges of the Litany, Philodox have the ability to sense whether others have spoken truth or falsehood."
	button_icon_state = "truth_of_gaia"
//	rage_req = 1

/datum/action/gift/mothers_touch
	name = "Mother's Touch"
	desc = "The Garou is able to heal the wounds of any living creature, aggravated or otherwise, simply by laying hands over the afflicted area."
	button_icon_state = "mothers_touch"
	gnosis_req = 1

/datum/action/gift/mothers_touch/Trigger()
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/H = owner
		H.put_in_active_hand(new /obj/item/melee/touch_attack/mothers_touch(H))

/datum/action/gift/sense_wyrm
	name = "Sense Wyrm"
	desc = "This Gift allows the werewolf to sense the presence of Wyrm."
	button_icon_state = "sense_wyrm"
	rage_req = 1

/datum/action/gift/sense_wyrm/Trigger()
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/C = owner
		C.sight = SEE_MOBS|SEE_OBJS
		playsound(get_turf(owner), 'code/modules/ziggers/sounds/sense_wyrm.ogg', 75, FALSE)
		to_chat(owner, "<span class='notice'>You feel your sense sharpening...</span>")
		spawn(200)
			C.sight = initial(C.sight)
			to_chat(owner, "<span class='warning'>You no longer sense anything more than normal...</span>")

/datum/action/gift/spirit_speech
	name = "Spirit Speech"
	desc = "This Gift allows the Garou to communicate with encountered spirits."
	button_icon_state = "spirit_speech"
	gnosis_req = 1

/datum/action/gift/blur_of_the_milky_eye
	name = "Blur Of The Milky Eye"
	desc = "The Garou�s form becomes a shimmering blur, allowing him to pass unnoticed among others."
	button_icon_state = "blur_of_the_milky_eye"
	gnosis_req = 1

/datum/action/gift/infectious_laughter/Trigger()
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/C = owner
		C.obfuscate_level = 3
		C.alpha = 36
		playsound(get_turf(owner), 'code/modules/ziggers/sounds/milky_blur.ogg', 75, FALSE)
		spawn(200)
			C.obfuscate_level = 0
			C.alpha = 255

/datum/action/gift/open_seal
	name = "Open Seal"
	desc = "With this Gift, the Garou can open nearly any sort of closed or locked physical device."
	button_icon_state = "open_seal"
//	gnosis_req = 1

/datum/action/gift/infectious_laughter
	name = "Infectious Laughter"
	desc = "When the Ragabash laughs, those around her are compelled to follow along, forgetting their grievances."
	button_icon_state = "infectious_laughter"
	rage_req = 1

/datum/action/gift/infectious_laughter/Trigger()
	. = ..()
	if(allowed_to_proceed)
		var/mob/living/carbon/C = owner
		C.emote("laugh")
		C.Stun(10)
		playsound(get_turf(owner), 'code/modules/ziggers/sounds/infectious_laughter.ogg', 100, FALSE)
		for(var/mob/living/L in oviewers(4, src))
			if(L)
				L.emote("laugh")
				L.Stun(20)