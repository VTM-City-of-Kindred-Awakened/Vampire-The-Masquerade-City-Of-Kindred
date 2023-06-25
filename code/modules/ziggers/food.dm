/obj/item/food/vampire
	icon = 'code/modules/ziggers/items.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	w_class = WEIGHT_CLASS_SMALL
	eatsound = 'code/modules/ziggers/sounds/eat.ogg'
	var/biten = FALSE

/obj/item/food/vampire/proc/got_biten()
	if(biten == FALSE)
		biten = TRUE
		icon_state = "[icon_state]-biten"

/obj/item/food/vampire/burger
	name = "burger"
	desc = "The cornerstone of every nutritious breakfast."
	icon_state = "burger"
	bite_consumption = 3
	tastes = list("bun" = 2, "beef patty" = 4)
	foodtypes = GRAIN | MEAT
	food_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/protein = 6, /datum/reagent/consumable/nutriment/vitamin = 1)
	eat_time = 15

/obj/item/food/vampire/donut
	name = "donut"
	desc = "Goes great with robust coffee."
	icon_state = "donut1"
	bite_consumption = 5
	tastes = list("donut" = 1)
	foodtypes = JUNKFOOD | GRAIN | FRIED | SUGAR | BREAKFAST
	food_flags = FOOD_FINGER_FOOD
	food_reagents = list(/datum/reagent/consumable/nutriment = 3, /datum/reagent/consumable/sugar = 3)

/obj/item/food/vampire/donut/Initialize()
	. = ..()
	icon_state = "donut[rand(1, 3)]"

/obj/item/food/vampire/pizza
	name = "pizza slice"
	desc = "A nutritious slice of pizza."
	icon_state = "pizza"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5)
	tastes = list("crust" = 1, "tomato" = 1, "cheese" = 1, "meat" = 1)
	foodtypes = GRAIN | VEGETABLES | DAIRY | MEAT

/obj/item/food/vampire/taco
	name = "taco"
	desc = "A traditional taco with meat, cheese, and lettuce."
	icon_state = "taco"
	food_reagents = list(/datum/reagent/consumable/nutriment = 2, /datum/reagent/consumable/nutriment/protein = 3, /datum/reagent/consumable/nutriment/vitamin = 2)
	tastes = list("taco" = 4, "meat" = 2, "cheese" = 2, "lettuce" = 1)
	foodtypes = MEAT | DAIRY | GRAIN | VEGETABLES

/obj/item/trash/vampirebar
	name = "chocolate bar wrapper"
	icon_state = "bar0"
	icon = 'code/modules/ziggers/items.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'

/obj/item/food/vampire/bar
	name = "chocolate bar"
	desc = "A fast way to reduce hunger."
	icon_state = "bar2"
	food_reagents = list(/datum/reagent/consumable/sugar = 2, /datum/reagent/consumable/nutriment = 1)
	junkiness = 5
	trash_type = /obj/item/trash/vampirebar
	tastes = list("chocolate" = 1)
	food_flags = FOOD_IN_CONTAINER
	foodtypes = JUNKFOOD | SUGAR

/obj/item/food/vampire/bar/proc/open_bar(mob/user)
	to_chat(user, "<span class='notice'>You pull back the wrapper of \the [src].</span>")
	playsound(user.loc, 'sound/items/foodcanopen.ogg', 50)
	icon_state = "bar1"
	reagents.flags |= OPENCONTAINER

/obj/item/food/vampire/bar/attack_self(mob/user)
	if(!is_drainable())
		open_bar(user)
	return ..()

/obj/item/food/vampire/bar/attack(mob/living/M, mob/user, def_zone)
	if (!is_drainable())
		to_chat(user, "<span class='warning'>[src]'s wrapper hasn't been opened!</span>")
		return FALSE
	return ..()

/obj/item/trash/vampirenugget
	name = "chicken nugget bone"
	icon_state = "nugget0"
	icon = 'code/modules/ziggers/items.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'

/obj/item/food/vampire/nugget
	name = "chicken nugget"
	desc = "Big calories for a big man."
	icon_state = "nugget1"
	trash_type = /obj/item/trash/vampirenugget
	bite_consumption = 3
	tastes = list("chicken" = 1)
	foodtypes = MEAT
	food_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/nutriment/protein = 3)
	eat_time = 15

/obj/item/trash/vampirecrisps
	name = "crisps wrapper"
	icon_state = "crisps0"
	icon = 'code/modules/ziggers/items.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'

/obj/item/food/vampire/crisps
	name = "crisps"
	desc = "\"Days\" crisps... Crispy!"
	icon_state = "crisps2"
	trash_type = /obj/item/trash/vampirecrisps
	bite_consumption = 1
	food_reagents = list(/datum/reagent/consumable/nutriment = 1, /datum/reagent/consumable/sugar = 3, /datum/reagent/consumable/salt = 1)
	junkiness = 10
	tastes = list("salt" = 1, "crisps" = 1)
	food_flags = FOOD_IN_CONTAINER
	foodtypes = JUNKFOOD | FRIED
	eatsound = 'code/modules/ziggers/sounds/crisp.ogg'

/obj/item/food/vampire/crisps/proc/open_crisps(mob/user)
	to_chat(user, "<span class='notice'>You pull back the wrapper of \the [src].</span>")
	playsound(user.loc, 'sound/items/foodcanopen.ogg', 50)
	icon_state = "crisps1"
	reagents.flags |= OPENCONTAINER

/obj/item/food/vampire/crisps/attack_self(mob/user)
	if(!is_drainable())
		open_crisps(user)
	return ..()

/obj/item/food/vampire/crisps/attack(mob/living/M, mob/user, def_zone)
	if (!is_drainable())
		to_chat(user, "<span class='warning'>[src]'s wrapper hasn't been opened!</span>")
		return FALSE
	return ..()

/obj/item/food/vampire/icecream
	name = "ice cream"
	desc = "Taste the childhood."
	icon_state = "icecream2"
	food_reagents = list(/datum/reagent/consumable/cream = 2, /datum/reagent/consumable/vanilla = 1, /datum/reagent/consumable/sugar = 4)
	tastes = list("vanilla" = 2, "ice cream" = 2)
	foodtypes = FRUIT | DAIRY | SUGAR

/obj/item/food/vampire/icecream/chocolate
	icon_state = "icecream1"
	tastes = list("chocolate" = 2, "ice cream" = 2)
	food_reagents = list(/datum/reagent/consumable/hot_coco = 4, /datum/reagent/consumable/salt = 1,  /datum/reagent/consumable/cream = 2, /datum/reagent/consumable/vanilla = 1, /datum/reagent/consumable/sugar = 4)

/obj/item/food/vampire/icecream/berry
	icon_state = "icecream3"
	tastes = list("berry" = 2, "ice cream" = 2)
	food_reagents = list(/datum/reagent/consumable/berryjuice = 4, /datum/reagent/consumable/salt = 1,  /datum/reagent/consumable/cream = 2, /datum/reagent/consumable/vanilla = 1, /datum/reagent/consumable/sugar = 4)