SUBSYSTEM_DEF(blackout)
	name = "Blackout"
	init_order = INIT_ORDER_DEFAULT
	wait = 600
	priority = FIRE_PRIORITY_VERYLOW

/datum/controller/subsystem/blackout/fire()
	for(var/obj/generator/G in GLOB.generators)
		if(prob(10))
			G.brek()
		G.fuel_remain = max(0, G.fuel_remain-50)
		if(G.fuel_remain == 0)
			G.brek()