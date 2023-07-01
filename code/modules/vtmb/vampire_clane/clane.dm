/mob/living/carbon/human
	var/datum/vampireclane/clane
//Дополнительная игровая логика должна храниться в компоненте
GLOBAL_LIST_INIT(basic_disciplines, list(/datum/discipline/animalism)) //сюда написать основные дисциплины когда я их сделаю
/*
В этом датуме хранится декларативное описание кланов, для того чтобы из этой реализации делать в рантайме инстанс компонента клана
А также это помогает для панельки чарсетапа*/
/datum/vampireclane
	var/name = "каитиф лол))))))" //в нейм только дефайны
	var/desc = "Ну описание клана"
	var/list/clane_disciplines = list() //датумы дисциплин
	var/datum/outfit/clane_outfit
	var/curse = "МОРЛОК ТЫ ГАНДОН ПИДОРАС УБИВАЕШЬ НАС БЕЗ ПРИЧИНЫ ЛИШЬ ПОТОМУ ЧТО МЫ КАИТИФФЫ"
	var/list/allowed_jobs = list()
	var/list/denied_jobs = list()
	var/clane_curse //Здесь должен быть сигнал
	var/alt_sprite
	var/no_hair
	var/no_facial
	var/humanitymod = 1
	var/frenzymod = 1
	var/start_humanity = 7
	var/haircuts
	var/violating_appearance
	var/male_clothes
	var/female_clothes
//	var/datum/action/innate/drink_blood/sosalka = new
//Дополнительная игровая логика должна храниться в компоненте

/datum/vampireclane/proc/on_gain(var/mob/living/carbon/human/H)
	if(alt_sprite)
		H.skin_tone = "albino"
		H.dna.species.limbs_id = alt_sprite
		H.update_body_parts()
		H.update_body()
		H.update_icon()
//	if(no_hair)
//		H.facial_hairstyle = "Shaved"
//		H.hairstyle = "Bald"
//		H.update_hair()

/datum/vampireclane/proc/post_gain(var/mob/living/carbon/human/H)