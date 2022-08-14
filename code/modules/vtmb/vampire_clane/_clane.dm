/mob/living/carbon/human
	var/datum/vampire_clane/clane
// Тут храниться базовая логика класса клана кровосись
//Дополнительная игровая логика должна храниться в компоненте
GLOBAL_LIST_INIT(basic_disciplines, list()) //сюда написать основные дисциплины когда я их сделаю
/datum/vampire_clane
	var/name = "каитиф лол))))))"
	var/desc = "Ну описание клана"
	var/list/clan_disciplines = list() //датумы дисциплин
	var/datum/outfit/clane_outfit
	var/curse = "МОРЛОК ТЫ ГАНДОН ПИДОРАС УБИВАЕШЬ НАС БЕЗ ПРИЧИНЫ ЛИШЬ ПОТОМУ ЧТО МЫ ХОХЛЫ"
	var/datum/component/clane_component //хрень для dcs
	var/list/allowed_jobs = list()
	var/list/denied_jobs = list()
/datum/vampire_clane/proc/pre_event(mob/living/carbon/human/victim)
	return
/datum/vampire_clane/proc/post_event(mob/living/carbon/human/victim)
	return
//Дополнительная игровая логика должна храниться в компоненте

/mob/living/carbon/human/proc/set_clane(datum/vampire_clane/vamp_clane)
	vamp_clane.pre_event(src)
	src.clane = new vamp_clane
	vamp_clane.post_event(src)
	equipOutfit(vamp_clane.clane_outfit)
	AddComponent(vamp_clane.clane_component)
