/mob/living/carbon/human
	var/datum/vampire_clane/clane
//Дополнительная игровая логика должна храниться в компоненте
GLOBAL_LIST_INIT(basic_disciplines, list(/datum/discipline/animalism)) //сюда написать основные дисциплины когда я их сделаю
/*
В этом датуме хранится декларативное описание кланов, для того чтобы из этой реализации делать в рантайме инстанс компонента клана
А также это помогает для панельки чарсетапа*/
/datum/vampire_clane
	var/name = "каитиф лол))))))" //в нейм только дефайны
	var/desc = "Ну описание клана"
	var/list/clane_disciplines = list() //датумы дисциплин
	var/datum/outfit/clane_outfit
	var/curse = "МОРЛОК ТЫ ГАНДОН ПИДОРАС УБИВАЕШЬ НАС БЕЗ ПРИЧИНЫ ЛИШЬ ПОТОМУ ЧТО МЫ ХОХЛЫ"
	var/list/allowed_jobs = list()
	var/list/denied_jobs = list()
	var/clane_curse //Здесь должен быть сигнал
	var/alt_sprite
	var/no_hair
//	var/datum/action/innate/drink_blood/sosalka = new
//Дополнительная игровая логика должна храниться в компоненте
/datum/species/kindred/on_species_gain(mob/living/carbon/human/C)
	..()
//		var/datum/preferences/Pref = C.client.prefs
//		C.clane = new C.client.prefs.clane()
	C.skin_tone = "albino"
	C.update_body(0)
//	if(Pref.clane.clane_outfit)
//		C.equipOutfit(Pref.clane.clane_outfit)
//	if(Pref.clane.clane_disciplines && Pref.clane.name && Pref.clane.desc)
//		AddComponent(/datum/component/vampire, Pref.clane.name, Pref.clane.desc, Pref.generation, Pref.clane.clane_disciplines, Pref.masquerade)
//	if(Pref.clane.clane_curse)
//		SEND_SIGNAL(src, Pref.clane.clane_curse)

/datum/vampire_clane/proc/on_gain(var/mob/living/carbon/human/H)
	if(alt_sprite)
		H.dna.species.limbs_id = "nosferatu"
		H.update_body_parts()
		H.update_body()
		H.update_icon()
//	if(no_hair)
//		H.facial_hairstyle = "Shaved"
//		H.hairstyle = "Bald"
//		H.update_hair()