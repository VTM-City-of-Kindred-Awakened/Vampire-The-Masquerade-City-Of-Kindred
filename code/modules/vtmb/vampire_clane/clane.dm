/mob/living/carbon/human
	var/datum/vampire_clane/clane
//Дополнительная игровая логика должна храниться в компоненте
GLOBAL_LIST_INIT(basic_disciplines, list()) //сюда написать основные дисциплины когда я их сделаю
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
	var/datum/action/innate/drink_blood/sosalka = new
//Дополнительная игровая логика должна храниться в компоненте
/datum/species/kindred/on_species_gain(mob/living/carbon/human/C)
	..()
	C.skin_tone = "albino"
	C.update_body(0)
	var/datum/preferences/Pref = C.client.prefs
	C.clane = new Pref.Clane()
	if(Pref.Clane.clane_outfit)
		C.equipOutfit(Pref.Clane.clane_outfit)
	if(Pref.Clane.clane_disciplines && Pref.Clane.name && Pref.Clane.desc)
		AddComponent(/datum/component/vampire, Pref.Clane.name, Pref.Clane.desc, Pref.generation, Pref.Clane.clane_disciplines, Pref.masquerade)
	if(Pref.Clane.clane_curse)
		SEND_SIGNAL(src, Pref.Clane.clane_curse)
