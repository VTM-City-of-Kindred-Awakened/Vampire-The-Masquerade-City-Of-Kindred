/datum/component/vampire
	dupe_mode = COMPONENT_DUPE_UNIQUE
	var/clane_name
	var/desc
	var/list/spec_disciplines = list()
	var/blood_amount
	var/generation
	var/masquerade_current
/datum/component/vampire/Initialize(_name, _desc, _generation, _disciplines, _masquerade)
	if(!ishuman(parent)) return COMPONENT_INCOMPATIBLE
	clane_name = _name
	desc = _desc
	generation = _generation
	spec_disciplines = _disciplines
	//generate_actions

/datum/component/vampire/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_VAMP_DRINKBLOOD, .proc/add_drinked_blood)
	//RegisterSignal(parent, COMSIG_VAMP_CURSE_NOSFERATU, .proc/izurodovat) не готов
	//RegisterSignal(parent, COMSIG_VAMP_CURSE_MALKAVIAN, .proc/SdelatShizom) не готово
	//RegisterSignal(parent, COMSIG_VAMP_SEENBYPEOPLE, .proc/seen_by_people) пока не готово
	RegisterSignal(parent, COMSIG_VAMP_WASTEBLOOD, .proc/wasteblood)
/datum/component/vampire/proc/wasteblood(waste_amount)
	blood_amount = blood_amount - waste_amount
/datum/component/vampire/proc/add_drinked_blood(given_amount)
	blood_amount = blood_amount + given_amount
