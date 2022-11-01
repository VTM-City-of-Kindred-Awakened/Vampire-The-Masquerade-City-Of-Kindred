SUBSYSTEM_DEF(humannpcpool)
	name = "Human NPC Pool"
	flags = SS_POST_FIRE_TIMING|SS_NO_INIT|SS_BACKGROUND
	priority = FIRE_PRIORITY_NPC
	runlevels = RUNLEVEL_GAME | RUNLEVEL_POSTGAME

	var/list/currentrun = list()

/datum/controller/subsystem/humannpcpool/stat_entry(msg)
	var/list/activelist = GLOB.npc_list
	msg = "NPCS:[length(activelist)]"
	return ..()

/datum/controller/subsystem/humannpcpool/fire(resumed = FALSE)

	if (!resumed)
		var/list/activelist = GLOB.npc_list
		src.currentrun = activelist.Copy()

	//cache for sanic speed (lists are references anyways)
	var/list/currentrun = src.currentrun

	while(currentrun.len)
		var/mob/living/carbon/human/npc/NPC = currentrun[currentrun.len]
		--currentrun.len

		if (QDELETED(NPC)) // Some issue causes nulls to get into this list some times. This keeps it running, but the bug is still there.
			GLOB.npc_list -= NPC
			log_world("Found a null in simple_animals list!")
			continue

		if(!NPC.ckey && NPC.stat <= 2)
			NPC.handle_automated_movement()
		if (MC_TICK_CHECK)
			return