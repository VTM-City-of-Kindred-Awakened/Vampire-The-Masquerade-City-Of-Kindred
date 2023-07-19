/datum/vampireclane/tzimisce
	name = "Tzimisce"
	desc = "If someone were to call a Tzimisce inhuman and sadistic, the Tzimisce would probably commend them for their perspicacity, and then demonstrate that their mortal definition of sadism was laughably inadequate. The Tzimisce have left the human condition behind gladly, and now focus on transcending the limitations of the vampiric state. At a casual glance or a brief conversation, a Tzimisce appears to be one of the more pleasant vampires. Polite, intelligent, and inquisitive, they seem a stark contrast to the howling Sabbat mobs or even the apparently more humane Brujah or Nosferatu. However, upon closer inspection, it becomes clear that this is merely a mask hiding something alien and monstrous."
	curse = "Grounded to material domain."
//	alt_sprite = "tzi"
//	no_hair = TRUE
//	no_facial = TRUE	//FUCK WRONG RULEBOOK
	clane_disciplines = list(/datum/discipline/auspex = 1,
														/datum/discipline/dominate = 2,
														/datum/discipline/vicissitude = 3)
	violating_appearance = FALSE
	male_clothes = "/obj/item/clothing/under/vampire/sport"
	female_clothes = "/obj/item/clothing/under/vampire/red"
	enlightement = TRUE
	var/hided = FALSE
	var/additional_hands = FALSE
	var/additional_wings = FALSE
	var/additional_centipede = FALSE
	var/additional_armor = FALSE
	var/stealing_appearance = FALSE

/datum/action/basic_vicissitude
	name = "Vicissitude Upgrades"
	desc = "Upgrade your body..."
	button_icon_state = "basic"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	var/used = FALSE

/datum/action/basic_vicissitude/Trigger()
	. = ..()
	var/mob/living/carbon/human/H = owner
	var/datum/vampireclane/tzimisce/TZ = H.clane
	if(TZ.hided)
		return
	if(used)
		return
	var/upgrade = input(owner, "Choose basic upgrade:", "Vicissitude Upgrades") as null|anything in list("Skin armor", "Centipede legs", "Second pair of arms", "Leather wings")
	if(upgrade)
		H.clane.violating_appearance = TRUE
		used = TRUE
		switch(upgrade)
			if("Skin armor")
				TZ.additional_armor = TRUE
				H.dna.species.limbs_id = "tziarmor"
				H.skin_tone = "albino"
				H.hairstyle = "Bald"
				H.physiology.armor.melee = H.physiology.armor.melee+50
				H.physiology.armor.bullet = H.physiology.armor.bullet+50
				H.update_body()
				H.update_hair()
			if("Centipede legs")
				TZ.additional_centipede = TRUE
				H.remove_overlay(PROTEAN_LAYER)
				var/mutable_appearance/centipede_overlay = mutable_appearance('code/modules/ziggers/64x64.dmi', "centipede", -PROTEAN_LAYER)
				centipede_overlay.pixel_z = -16
				centipede_overlay.pixel_w = -16
				H.overlays_standing[PROTEAN_LAYER] = centipede_overlay
				H.apply_overlay(PROTEAN_LAYER)
			if("Second pair of arms")
				TZ.additional_hands = TRUE
				var/limbs = H.held_items.len
				H.change_number_of_hands(limbs+2)
				H.remove_overlay(PROTEAN_LAYER)
				var/mutable_appearance/hands2_overlay = mutable_appearance('code/modules/ziggers/icons.dmi', "2hands", -PROTEAN_LAYER)
				hands2_overlay.color = "#[skintone2hex(H.skin_tone)]"
				H.overlays_standing[PROTEAN_LAYER] = hands2_overlay
				H.apply_overlay(PROTEAN_LAYER)
			if("Leather wings")
				TZ.additional_wings = TRUE
				H.dna.species.GiveSpeciesFlight(H)

/datum/vampireclane/tzimisce/proc/switch_masquerade(var/mob/living/carbon/human/H)
	if(!additional_hands && !additional_wings && !additional_centipede && !additional_armor)
		return
	if(stealing_appearance)
		return
	if(!hided)
		hided = TRUE
		violating_appearance = FALSE
		if(additional_hands)
			var/limbs = H.held_items.len
			H.change_number_of_hands(limbs-2)
			H.remove_overlay(PROTEAN_LAYER)
		if(additional_wings)
			H.dna.species.RemoveSpeciesFlight(H)
		if(additional_centipede)
			H.remove_overlay(PROTEAN_LAYER)
		if(additional_armor)
			H.dna.species.limbs_id = initial(H.dna.species.limbs_id)
			H.update_body()
	else
		hided = FALSE
		violating_appearance = TRUE
		if(additional_hands)
			var/limbs = H.held_items.len
			H.change_number_of_hands(limbs+2)
			H.remove_overlay(PROTEAN_LAYER)
			var/mutable_appearance/hands2_overlay = mutable_appearance('code/modules/ziggers/icons.dmi', "2hands", -PROTEAN_LAYER)
			hands2_overlay.color = "#[skintone2hex(H.skin_tone)]"
			H.overlays_standing[PROTEAN_LAYER] = hands2_overlay
			H.apply_overlay(PROTEAN_LAYER)
		if(additional_wings)
			H.dna.species.GiveSpeciesFlight(H)
		if(additional_centipede)
			H.remove_overlay(PROTEAN_LAYER)
			var/mutable_appearance/centipede_overlay = mutable_appearance('code/modules/ziggers/64x64.dmi', "centipede", -PROTEAN_LAYER)
			centipede_overlay.pixel_z = -16
			centipede_overlay.pixel_w = -16
			H.overlays_standing[PROTEAN_LAYER] = centipede_overlay
			H.apply_overlay(PROTEAN_LAYER)
		if(additional_armor)
			H.dna.species.limbs_id = "tziarmor"
			H.update_body()

/datum/vampireclane/tzimisce/on_gain(mob/living/carbon/human/H)
	..()
	H.add_quirk(/datum/quirk/ground_heirloom)
	H.faction |= "Tzimisce"

/datum/vampireclane/tzimisce/post_gain(mob/living/carbon/human/H)
	..()
	var/datum/action/vicissitude/U = new()
	U.Grant(H)
	var/datum/action/basic_vicissitude/BV = new()
	BV.Grant(H)
	if(H.mind)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_floor)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_stool)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_biter)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_fister)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_tanker)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_heart)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_eyes)
//		H.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_med)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_trench)
	var/obj/item/organ/cyberimp/arm/surgery/S = new()
	S.Insert(H)

/datum/crafting_recipe/tzi_trench
	name = "Leather-Bone Trenchcoat (Armor)"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 50, /obj/item/spine = 1)
	result = /obj/item/clothing/suit/vampire/trench/tzi
	always_available = FALSE
	category = CAT_TZIMISCE

/*
/datum/crafting_recipe/tzi_med
	name = "Medical Hand (Healing)"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 35, /obj/item/bodypart/r_arm = 1, /obj/item/organ/heart = 1, /obj/item/organ/tongue = 1)
	result = /obj/item/organ/cyberimp/arm/medibeam
	always_available = FALSE
	category = CAT_TZIMISCE
*/

/datum/crafting_recipe/tzi_heart
	name = "Second Heart (Antistun)"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 25, /obj/item/organ/heart = 1)
	result = /obj/item/organ/cyberimp/brain/anti_stun/tzi
	always_available = FALSE
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_eyes
	name = "Better Eyes (Nightvision)"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 15, /obj/item/organ/eyes = 1)
	result = /obj/item/organ/eyes/night_vision/nightmare
	always_available = FALSE
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_floor
	name = "Gut Floor"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 1, /obj/item/guts = 1)
	result = /obj/effect/decal/gut_floor
	always_available = FALSE
	category = CAT_TZIMISCE

/obj/effect/decal/gut_floor
	name = "gut floor"
	icon = 'code/modules/ziggers/tiles.dmi'
	icon_state = "tzimisce_floor"

/datum/action/vicissitude
	name = "Vicissitude Appearance"
	desc = "Steal the appearance of your victim."
	button_icon_state = "vicissitude"
	check_flags = AB_CHECK_HANDS_BLOCKED|AB_CHECK_IMMOBILE|AB_CHECK_LYING|AB_CHECK_CONSCIOUS
	var/original_hair
	var/original_facehair
	var/original_skintone
	var/original_gender
	var/original_bodytype
	var/original_haircolor
	var/original_facialhaircolor
	var/original_bodysprite
	var/original_eyecolor
	var/original_realname
	var/original_age
	var/furry_changed = FALSE

/datum/action/vicissitude/Trigger()
	. = ..()
	var/mob/living/carbon/human/H = owner
//	H.put_in_r_hand(new /obj/item/chameleon(H))
	var/list/nibbers = list()
	for(var/mob/living/carbon/human/HU in oviewers(6, H))
		if(HU)
			nibbers += HU
	if(!furry_changed)
		if(length(nibbers) >= 1)
			var/victim = input(owner, "Choose victim to copy:", "Vicissitude Appearance") as null|mob in nibbers
			if(victim)
				var/datum/vampireclane/tzimisce/TZ = H.clane
				TZ.stealing_appearance = TRUE
				TZ.switch_masquerade(H)
				original_hair = H.hairstyle
				original_facehair = H.facial_hairstyle
				original_skintone = H.skin_tone
				original_gender = H.gender
				original_bodytype = H.body_type
				original_haircolor = H.hair_color
				original_facialhaircolor = H.facial_hair_color
				original_bodysprite = H.dna.species.limbs_id
				original_eyecolor = H.eye_color
				original_realname = H.real_name
				original_age = H.age
				playsound(get_turf(H), 'code/modules/ziggers/sounds/vicissitude.ogg', 100, TRUE, -6)
				H.Stun(10)
				H.do_jitter_animation(10)
				var/mob/living/carbon/human/ZV = victim
				H.hairstyle = ZV.hairstyle
				H.facial_hairstyle = H.facial_hairstyle
				H.skin_tone = ZV.skin_tone
				H.gender = ZV.gender
				H.body_type = ZV.body_type
				H.hair_color = ZV.hair_color
				H.facial_hair_color = ZV.facial_hair_color
				H.dna.species.limbs_id = ZV.dna.species.limbs_id
				H.eye_color = ZV.eye_color
				H.real_name = ZV.real_name
				H.name = H.real_name
				H.age = ZV.age
				H.update_body()
				H.update_hair()
				H.update_body_parts()
				furry_changed = TRUE
			else
				return
		else
			to_chat(H, "<span class='warning'>You see no soul which can be copied...</span>")
			return
		return
	else
		var/datum/vampireclane/tzimisce/TZ = H.clane
		TZ.stealing_appearance = FALSE
		TZ.switch_masquerade(H)
		playsound(get_turf(H), 'code/modules/ziggers/sounds/vicissitude.ogg', 100, TRUE, -6)
		H.Stun(10)
		H.do_jitter_animation(10)
		H.hairstyle = original_hair
		H.facial_hairstyle = original_facehair
		H.skin_tone = original_skintone
		H.gender = original_gender
		H.body_type = original_bodytype
		H.hair_color = original_haircolor
		H.facial_hair_color = original_facialhaircolor
		H.dna.species.limbs_id = original_bodysprite
		H.eye_color = original_eyecolor
		H.real_name = original_realname
		H.name = H.real_name
		H.age = original_age
		H.update_body()
		H.update_hair()
		H.update_body_parts()
		furry_changed = FALSE
		return

/obj/effect/decal/gut_floor/Initialize()
	. = ..()
	var/turf/open/T = get_turf(src)
	if(T)
		T.slowdown = -1

/obj/effect/decal/gut_floor/Destroy()
	. = ..()
	var/turf/open/T = get_turf(src)
	if(T)
		T.slowdown = initial(T.slowdown)

/datum/crafting_recipe/tzi_stool
	name = "Arm Stool"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 5, /obj/item/bodypart/r_arm = 2, /obj/item/bodypart/l_arm = 2)
	result = /obj/structure/chair/old/tzimisce
	always_available = FALSE
	category = CAT_TZIMISCE

/obj/structure/chair/old/tzimisce
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "tzimisce_stool"

/obj/item/guts
	name = "guts"
	desc = "Just blood and guts..."
	icon_state = "guts"
	icon = 'code/modules/ziggers/items.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	w_class = WEIGHT_CLASS_SMALL

/obj/item/spine
	name = "spine"
	desc = "If only I had control..."
	icon_state = "spine"
	icon = 'code/modules/ziggers/items.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	w_class = WEIGHT_CLASS_SMALL

/datum/crafting_recipe/tzi_biter
	name = "Biting Abomination"
	time = 100
	reqs = list(/obj/item/stack/human_flesh = 5, /obj/item/bodypart/r_arm = 2, /obj/item/bodypart/l_arm = 2, /obj/item/spine = 1)
	result = /mob/living/simple_animal/hostile/biter
	always_available = FALSE
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_fister
	name = "Punching Abomination"
	time = 100
	reqs = list(/obj/item/stack/human_flesh = 10, /obj/item/bodypart/r_arm = 1, /obj/item/bodypart/l_arm = 1, /obj/item/spine = 1, /obj/item/guts = 1)
	result = /mob/living/simple_animal/hostile/fister
	always_available = FALSE
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_tanker
	name = "Fat Abomination"
	time = 100
	reqs = list(/obj/item/stack/human_flesh = 15, /obj/item/bodypart/r_arm = 1, /obj/item/bodypart/l_arm = 1, /obj/item/bodypart/r_leg = 1, /obj/item/bodypart/l_leg = 1, /obj/item/spine = 1, /obj/item/guts = 5)
	result = /mob/living/simple_animal/hostile/tanker
	always_available = FALSE
	category = CAT_TZIMISCE

/mob/living/simple_animal/hostile/biter
	name = "biter"
	desc = "A ferocious, fang-bearing creature that resembles a spider."
	icon = 'code/modules/ziggers/mobs.dmi'
	icon_state = "biter"
	icon_living = "biter"
	icon_dead = "biter_dead"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	speak_chance = 0
	turns_per_move = 5
	butcher_results = list(/obj/item/stack/human_flesh = 5)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	emote_taunt = list("gnashes")
	speed = 0
	maxHealth = 25
	health = 25

	harm_intent_damage = 8
	obj_damage = 50
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/weapons/bite.ogg'
	speak_emote = list("gnashes")

	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 1500
	faction = list("Tzimisce")
	pressure_resistance = 200
	bloodquality = BLOOD_QUALITY_LOW
	bloodpool = 2
	maxbloodpool = 2

/mob/living/simple_animal/hostile/fister
	name = "fister"
	desc = "True abomination walking on both hands."
	icon = 'code/modules/ziggers/mobs.dmi'
	icon_state = "fister"
	icon_living = "fister"
	icon_dead = "fister_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	maxHealth = 50
	health = 50
	butcher_results = list(/obj/item/stack/human_flesh = 10)
	harm_intent_damage = 5
	melee_damage_lower = 21
	melee_damage_upper = 21
	attack_verb_continuous = "punches"
	attack_verb_simple = "punch"
	attack_sound = 'sound/weapons/punch1.ogg'
	a_intent = INTENT_HARM
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	status_flags = CANPUSH
	faction = list("Tzimisce")
	bloodquality = BLOOD_QUALITY_LOW
	bloodpool = 5
	maxbloodpool = 5

/mob/living/simple_animal/hostile/tanker
	name = "tanker"
	desc = "The peak of abominations armor. Unbelievably undamagable..."
	icon = 'code/modules/ziggers/mobs.dmi'
	icon_state = "tanker"
	icon_living = "tanker"
	icon_dead = "tanker_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	maxHealth = 300
	health = 300
	butcher_results = list(/obj/item/stack/human_flesh = 20)
	harm_intent_damage = 5
	melee_damage_lower = 21
	melee_damage_upper = 21
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	a_intent = INTENT_HARM
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	faction = list("Tzimisce")
	bloodquality = BLOOD_QUALITY_LOW
	bloodpool = 7
	maxbloodpool = 7

/mob/living/simple_animal/hostile/gangrel
	name = "Gangrel Form"
	desc = "The peak of abominations armor. Unbelievably undamagable..."
	icon = 'code/modules/ziggers/32x48.dmi'
	icon_state = "gangrel_f"
	icon_living = "gangrel_f"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	maxHealth = 300
	health = 300
	butcher_results = list(/obj/item/stack/human_flesh = 20)
	harm_intent_damage = 5
	melee_damage_lower = 25
	melee_damage_upper = 25
	attack_verb_continuous = "slashes"
	attack_verb_simple = "slash"
	attack_sound = 'sound/weapons/slash.ogg'
	a_intent = INTENT_HARM
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	bloodpool = 10
	maxbloodpool = 10

/mob/living/simple_animal/hostile/gangrel/better
	maxHealth = 500
	health = 500
	melee_damage_lower = 35
	melee_damage_upper = 35

/mob/living/simple_animal/hostile/gangrel/best
	icon_state = "gangrel_m"
	icon_living = "gangrel_m"
	maxHealth = 700
	health = 700
	melee_damage_lower = 50
	melee_damage_upper = 50

/mob/living/simple_animal/hostile/biter/hostile
	faction = list("hostile")

/mob/living/simple_animal/hostile/fister/hostile
	faction = list("hostile")

/mob/living/simple_animal/hostile/tanker/hostile
	faction = list("hostile")

/obj/item/ground_heir
	name = "bag of ground"
	desc = "Boghatyrskaya sila taitsa zdies'..."
	icon_state = "dirt"
	icon = 'code/modules/ziggers/icons.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	w_class = WEIGHT_CLASS_SMALL

/obj/item/stack/human_flesh
	name = "human flesh"
	desc = "What the fuck..."
	singular_name = "human flesh"
	icon_state = "human"
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	mats_per_unit = list(/datum/material/pizza = MINERAL_MATERIAL_AMOUNT)
	merge_type = /obj/item/stack/human_flesh
	max_amount = 50

/obj/item/stack/human_flesh/fifty
	amount = 50
/obj/item/stack/human_flesh/twenty
	amount = 20
/obj/item/stack/human_flesh/ten
	amount = 10
/obj/item/stack/human_flesh/five
	amount = 5

/obj/item/stack/human_flesh/update_icon_state()
	var/amount = get_amount()
	switch(amount)
		if(30 to INFINITY)
			icon_state = "human_3"
		if(10 to 30)
			icon_state = "human_2"
		else
			icon_state = "human"

/obj/item/extra_arm
	name = "extra arm installer"
	desc = "Distantly related to the technology of the Man-Machine Interface, this state-of-the-art syndicate device adapts your nervous and circulatory system to the presence of an extra limb..."
	icon = 'code/modules/ziggers/icons.dmi'
	icon_state = "vicissitude"
	var/used = FALSE

/obj/item/extra_arm/attack_self(mob/living/carbon/M)
	if(!used)
		var/limbs = M.held_items.len
		M.change_number_of_hands(limbs+1)
		used = TRUE
		icon_state = "extra_arm_none"
		M.visible_message("<span class='notice'>[M] presses a button on [src], and you hear a disgusting noise.</span>", "<span class='notice'>You feel a sharp sting as [src] plunges into your body.</span>")
		to_chat(M, "<span class='notice'>You feel more dexterous.</span>")
		playsound(get_turf(M), 'sound/misc/splort.ogg', 50, 1)
		desc += "Looks like it's been used up."

//GiveSpeciesFlight(mob/living/carbon/human/H)