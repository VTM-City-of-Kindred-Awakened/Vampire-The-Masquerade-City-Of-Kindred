/obj/upgraderune
	name = "Tremere Rune"
	desc = "Learn the secrets of blood, neonate..."
	icon = 'icons/obj/rune.dmi'
	icon_state = "1"
	color = rgb(255,0,0)
	var/datum/sacrifice/sacrifice
	var/points = 0

/datum/sacrifice
	var/name = "Default Sacrifice"
	var/desc = "Make a sacrifice to gain powers you fucking blood-assnigga moron"
	var/obj/item/sacrificeresult
	var/gain = 1