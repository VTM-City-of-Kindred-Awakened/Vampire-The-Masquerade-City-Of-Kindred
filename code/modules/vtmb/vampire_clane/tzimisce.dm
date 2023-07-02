/datum/vampireclane/tzimisce
	name = "Tzimisce"
	desc = "If someone were to call a Tzimisce inhuman and sadistic, the Tzimisce would probably commend them for their perspicacity, and then demonstrate that their mortal definition of sadism was laughably inadequate. The Tzimisce have left the human condition behind gladly, and now focus on transcending the limitations of the vampiric state. At a casual glance or a brief conversation, a Tzimisce appears to be one of the more pleasant vampires. Polite, intelligent, and inquisitive, they seem a stark contrast to the howling Sabbat mobs or even the apparently more humane Brujah or Nosferatu. However, upon closer inspection, it becomes clear that this is merely a mask hiding something alien and monstrous."
	curse = "Grounded to material domain."
	alt_sprite = "tzi"
	no_hair = TRUE
	no_facial = TRUE
	clane_disciplines = list(/datum/discipline/auspex = 1,
														/datum/discipline/dominate = 2,
														/datum/discipline/vicissitude = 3)
	violating_appearance = TRUE
	male_clothes = "/obj/item/clothing/under/vampire/sport"
	female_clothes = "/obj/item/clothing/under/vampire/red"

/datum/vampireclane/tzimisce/on_gain(mob/living/carbon/human/H)
	..()
	H.add_quirk(/datum/quirk/ground_heirloom)
	H.faction |= "Tzimisce"

/datum/vampireclane/tzimisce/post_gain(mob/living/carbon/human/H)
	if(H.mind)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_floor)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_stool)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_biter)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_fister)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_tanker)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_heart)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_eyes)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_med)
		H.mind.teach_crafting_recipe(/datum/crafting_recipe/tzi_trench)
	var/obj/item/organ/cyberimp/arm/surgery/S = new()
	S.Insert(H)
	if(H.dna)
		if(H.dna.species)
			H.dna.species.inherent_traits |= TRAIT_EASYDISMEMBER
			H.dna.species.inherent_traits |= TRAIT_LIMBATTACHMENT

/datum/crafting_recipe/tzi_trench
	name = "Leather-Bone Trenchcoat (Armor)"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 50, /obj/item/spine = 1)
	result = /obj/item/clothing/suit/vampire/trench/tzi
	always_available = FALSE
	category = CAT_TZIMISCE

/datum/crafting_recipe/tzi_med
	name = "Medical Hand (Healing)"
	time = 50
	reqs = list(/obj/item/stack/human_flesh = 35, /obj/item/bodypart/r_arm = 1, /obj/item/organ/heart = 1, /obj/item/organ/tongue = 1)
	result = /obj/item/organ/cyberimp/arm/medibeam
	always_available = FALSE
	category = CAT_TZIMISCE

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