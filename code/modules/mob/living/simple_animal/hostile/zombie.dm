/mob/living/simple_animal/hostile/zombie
	name = "Shambling Corpse"
	desc = "When there is no more room in hell, the dead will walk on Earth."
	icon = 'code/modules/ziggers/mobs.dmi'
	icon_state = "zombie"
	icon_living = "zombie"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	stat_attack = HARD_CRIT //braains
	maxHealth = 50
	health = 50
	harm_intent_damage = 5
	melee_damage_lower = 21
	melee_damage_upper = 21
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/hallucinations/growl1.ogg'
	a_intent = INTENT_HARM
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	status_flags = CANPUSH
	del_on_death = 1
	bloodpool = 0
	maxbloodpool = 0
	speed = 1

/mob/living/simple_animal/hostile/zombie/Destroy()
	. = ..()
	SSgraveyard.alive_zombies = max(0, SSgraveyard.alive_zombies-1)

/mob/living/simple_animal/hostile/beastmaster/giovanni_zombie
	name = "Shambling Corpse"
	desc = "When there is no more room in hell, the dead will walk on Earth."
	icon = 'code/modules/ziggers/mobs.dmi'
	icon_state = "zombie"
	icon_living = "zombie"
	icon_dead = "zombie_dead"
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	speak_chance = 0
	stat_attack = HARD_CRIT //braains
	maxHealth = 50
	health = 50
	speed = 1
	harm_intent_damage = 5
	melee_damage_lower = 25
	melee_damage_upper = 25
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/hallucinations/growl1.ogg'
	a_intent = INTENT_HARM
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	status_flags = CANPUSH
	faction = list("Giovanni")
	bloodpool = 0
	maxbloodpool = 0

/mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/level1
	name = "ghost"
	desc = "A soul of the dead, spooky."
	icon = 'icons/mob/mob.dmi'
	icon_state = "ghost"
	icon_living = "ghost"
	mob_biotypes = MOB_SPIRIT
	speak_chance = 0
	turns_per_move = 5
	response_help_continuous = "passes through"
	response_help_simple = "pass through"
	a_intent = INTENT_HARM
	healable = 0
	speed = 2
	maxHealth = 50
	health = 50
	harm_intent_damage = 10
	melee_damage_lower = 15
	melee_damage_upper = 15
	del_on_death = 1
	emote_see = list("weeps silently", "groans", "mumbles")
	attack_verb_continuous = "grips"
	attack_verb_simple = "grip"
	attack_sound = 'sound/hallucinations/growl1.ogg'
	speak_emote = list("weeps")
	deathmessage = "wails, disintegrating into a pile of ectoplasm!"
	loot = list(/obj/item/ectoplasm)
	atmos_requirements = list("min_oxy" = 0, "max_oxy" = 0, "min_tox" = 0, "max_tox" = 0, "min_co2" = 0, "max_co2" = 0, "min_n2" = 0, "max_n2" = 0)
	minbodytemp = 0
	maxbodytemp = 1500
	is_flying_animal = TRUE
	pressure_resistance = 300
	gold_core_spawnable = NO_SPAWN //too spooky for science
	light_system = MOVABLE_LIGHT
	light_range = 1 // same glowing as visible player ghosts
	light_power = 2
	faction = list("Giovanni")
	bloodpool = 0
	maxbloodpool = 0

/mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/level2
	maxHealth = 100
	health = 100
	harm_intent_damage = 20
	melee_damage_lower = 20
	melee_damage_upper = 20
/*
/mob/living/simple_animal/hostile/giovanni_zombie/level2/Initialize()
	. = ..()
	give_player()
*/
/mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/level3
	maxHealth = 200
	health = 200
	icon_state = "zombieup"
	icon_living = "zombieup"
	icon_dead = "zombieup_dead"
	harm_intent_damage = 30
	melee_damage_lower = 30
	melee_damage_upper = 30
/*
/mob/living/simple_animal/hostile/giovanni_zombie/level3/Initialize()
	. = ..()
	give_player()
*/
/mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/level4
	maxHealth = 300
	health = 300
	harm_intent_damage = 40
	melee_damage_lower = 40
	melee_damage_upper = 40
	icon_state = "skeleton"
	icon_living = "skeleton"
	icon_dead = "skeleton_dead"
	speed = -1
/*
/mob/living/simple_animal/hostile/giovanni_zombie/level4/Initialize()
	. = ..()
	give_player()
*/
/mob/living/simple_animal/hostile/beastmaster/giovanni_zombie/level5
	maxHealth = 1000
	health = 1000
	harm_intent_damage = 100
	melee_damage_lower = 100
	melee_damage_upper = 100
	icon_state = "zombietop"
	icon_living = "zombietop"
	icon_dead = "zombietop_dead"
	speed = 4
/*
/mob/living/simple_animal/hostile/giovanni_zombie/level5/Initialize()
	. = ..()
	give_player()
*/
/mob/living/simple_animal/hostile/giovanni_zombie/proc/give_player()
	set waitfor = FALSE
	var/list/mob/dead/observer/candidates = pollCandidatesForMob("Do you want to play as summoned ghost?", null, null, null, 50, src)
	for(var/mob/dead/observer/G in GLOB.player_list)
		if(G.key)
			to_chat(G, "<span class='ghostalert'>Someone is summoning a ghost!</span>")
	if(LAZYLEN(candidates))
		var/mob/dead/observer/C = pick(candidates)
		name = C.name
		key = C.key
		visible_message("<span class='danger'>[src] rises with fresh soul!</span>")
		return TRUE
	visible_message("<span class='warning'>[src] remains unsouled...</span>")
	return FALSE