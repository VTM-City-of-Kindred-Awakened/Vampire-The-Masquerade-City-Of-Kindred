SUBSYSTEM_DEF(bad_guys_party)
	name = "Bad Guys Party"
	init_order = INIT_ORDER_DEFAULT
	wait = 1200
	priority = FIRE_PRIORITY_DEFAULT

	var/threat = 0	//Bigger number - less chance

	var/list/candidates = list()
	var/datum/antagonist/role

