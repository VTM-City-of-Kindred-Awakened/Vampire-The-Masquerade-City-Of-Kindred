/mob/living/simple_animal/hostile/zombie
	name = "Shambling Corpse"
	desc = "When there is no more room in hell, the dead will walk in outer space."
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

/mob/living/simple_animal/hostile/zombie/Destroy()
	. = ..()
	SSgraveyard.alive_zombies = max(0, SSgraveyard.alive_zombies-1)