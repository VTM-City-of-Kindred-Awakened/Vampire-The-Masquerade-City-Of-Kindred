/obj/minespot
	name = "mine spot start"
	desc = "Spot a mine."
	icon = 'code/modules/ziggers/mineswapper.dmi'
	icon_state = "unknown"
	plane = GAME_PLANE
	layer = BELOW_OBJ_LAYER
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF | FREEZE_PROOF
	anchored = TRUE
	var/marked = FALSE
	var/bomb = FALSE
	var/uncovered = FALSE

/obj/minespot/playable
	name = "mine spot"

/obj/minespot/playable/Initialize()
	. = ..()
	if(prob(40))
		bomb = TRUE

/obj/minespot/proc/uncover()
	if(bomb)
		icon_state = "boom"
		explosion(loc,5,5,5,5)
		return
	var/amount_of_bombs = 0
	for(var/obj/minespot/M in range(1, src))
		if(M.bomb)
			amount_of_bombs += 1
	icon_state = "[amount_of_bombs]"
//	if(amount_of_bombs == 0)
//		for(var/obj/minespot/M in range(1, src))
//			M.uncover()

/obj/minespot/attack_hand(mob/user)
	. = ..()
	if(uncovered)
		return
	uncovered = TRUE
	if(bomb)
		icon_state = "boom"
		explosion(loc,5,5,5,5)
	else
		var/amount_of_bombs = 0
		for(var/obj/minespot/M in range(1, src))
			if(M.bomb)
				amount_of_bombs = min(8, amount_of_bombs+1)
			if(M.marked)
				amount_of_bombs = max(0, amount_of_bombs-1)
		icon_state = "[amount_of_bombs]"
		if(amount_of_bombs == 0)
			for(var/obj/minespot/M in range(1, src))
				M.uncover()

/mob/living/carbon/human/CtrlClickOn(atom/A)
	. = ..()
	if(istype(A, /obj/minespot))
		var/obj/minespot/M = A
		if(!M.uncovered)
			if(!M.marked)
				M.icon_state = "marked"
				M.marked = TRUE
			else
				M.icon_state = "unknown"
				M.marked = FALSE