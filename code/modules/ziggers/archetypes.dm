/mob/living/carbon/human
	var/datum/archetype/human_archetype
/mob/living/carbon/human/proc/get_archetype(datum/archetype/arch)
	human_archetype = new arch
	arch.owner = src
	arch.on_gain()
/datum/archetype
	var/name = "Morlok"
	var/desc = "Дает невосприимчивость к заклинаниям и полное сопротивление магическому урону.\
	Продолжительность уменьшается с каждым использованием. Некоторые способности могут проходить сквозь невосприимчивость к заклинаниям."
	var/mob/living/carbon/owner
/datum/archetype/proc/on_gain()
	ADD_TRAIT(owner, TRAIT_ANTIMAGIC, TRAIT_GENERIC)
	to_chat(owner, "вы крутой")

/datum/archetype/proc/on_lose()
	REMOVE_TRAIT(owner, TRAIT_ANTIMAGIC, TRAIT_GENERIC)
