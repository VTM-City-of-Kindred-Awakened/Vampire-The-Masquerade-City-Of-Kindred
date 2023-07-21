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

/obj/item/reagent_containers/food/drinks/coffee/vampire
	name = "coffee"
	desc = "Careful, the beverage you're about to enjoy is extremely hot."
	icon_state = "coffee"
	icon = 'code/modules/ziggers/items.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	list_reagents = list(/datum/reagent/consumable/coffee = 30)
	spillable = TRUE
	resistance_flags = FREEZE_PROOF
	isGlass = FALSE
	foodtype = BREAKFAST

/obj/item/reagent_containers/food/drinks/coffee/vampire/robust
	name = "robust coffee"
	icon_state = "coffee-alt"

/obj/item/reagent_containers/food/drinks/beer/vampire
	name = "beer"
	desc = "Beer."
	icon_state = "beer"
	icon = 'code/modules/ziggers/items.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	list_reagents = list(/datum/reagent/consumable/ethanol/beer = 30)
	foodtype = GRAIN | ALCOHOL
	custom_price = PAYCHECK_EASY

/obj/item/reagent_containers/food/drinks/bottle/vampirecola
	name = "cola bottle"
	desc = "Coca cola espuma..."
	icon_state = "cola1"
	icon = 'code/modules/ziggers/items.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	isGlass = FALSE
	list_reagents = list(/datum/reagent/consumable/space_cola = 100)
	foodtype = SUGAR
	age_restricted = FALSE

/obj/item/reagent_containers/food/drinks/bottle/vampirewater
	name = "water bottle"
	desc = "H2O."
	icon_state = "water1"
	icon = 'code/modules/ziggers/items.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	isGlass = FALSE
	list_reagents = list(/datum/reagent/water = 100)
	age_restricted = FALSE

/obj/item/reagent_containers/food/drinks/soda_cans/vampirecola
	name = "cola"
	desc = "Coca cola espuma..."
	icon_state = "cola2"
	icon = 'code/modules/ziggers/items.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	list_reagents = list(/datum/reagent/consumable/space_cola = 50)
	foodtype = SUGAR

/obj/item/reagent_containers/food/drinks/soda_cans/vampiresoda
	name = "soda"
	desc = "More water..."
	icon_state = "soda"
	icon = 'code/modules/ziggers/items.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	list_reagents = list(/datum/reagent/consumable/sodawater = 50)
	foodtype = SUGAR

/obj/item/reagent_containers/food/condiment/vampiremilk
	name = "milk"
	icon_state = "milk"
	icon = 'code/modules/ziggers/items.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	list_reagents = list(/datum/reagent/consumable/milk = 50)
	fill_icon_thresholds = null

/obj/machinery/mineral/equipment_vendor/fastfood
	name = "order menu"
	desc = "Order some fastfood here."
	icon = 'code/modules/ziggers/props.dmi'
	icon_state = "menu"
	icon_deny = "menu"
	prize_list = list()

/obj/machinery/mineral/equipment_vendor/fastfood/AltClick(mob/user)
	. = ..()
	if(points)
		for(var/i in 1 to points)
			new /obj/item/stack/dollar(loc)
		points = 0

/obj/machinery/mineral/equipment_vendor/fastfood/bacotell
	prize_list = list(new /datum/data/mining_equipment("pizza",	/obj/item/food/vampire/pizza,	15),
		new /datum/data/mining_equipment("taco",	/obj/item/food/vampire/taco,	10),
		new /datum/data/mining_equipment("burger",	/obj/item/food/vampire/burger,	20),
		new /datum/data/mining_equipment("cola bottle",	/obj/item/reagent_containers/food/drinks/bottle/vampirecola,	10),
		new /datum/data/mining_equipment("cola can",	/obj/item/reagent_containers/food/drinks/soda_cans/vampirecola,	5)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/bubway
	prize_list = list(new /datum/data/mining_equipment("donut",	/obj/item/food/vampire/donut,	5),
		new /datum/data/mining_equipment("burger",	/obj/item/food/vampire/burger,	10),
		new /datum/data/mining_equipment("coffee",	/obj/item/reagent_containers/food/drinks/coffee/vampire,	5),
		new /datum/data/mining_equipment("robust coffee",	/obj/item/reagent_containers/food/drinks/coffee/vampire/robust,	10)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/gummaguts
	prize_list = list(new /datum/data/mining_equipment("chicken nugget",	/obj/item/food/vampire/nugget,	5),
		new /datum/data/mining_equipment("burger",	/obj/item/food/vampire/burger,	15),
		new /datum/data/mining_equipment("pizza",	/obj/item/food/vampire/pizza,	10),
		new /datum/data/mining_equipment("cola bottle",	/obj/item/reagent_containers/food/drinks/bottle/vampirecola,	10),
		new /datum/data/mining_equipment("cola can",	/obj/item/reagent_containers/food/drinks/soda_cans/vampirecola,	5)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/products
	prize_list = list(new /datum/data/mining_equipment("chocolate bar",	/obj/item/food/vampire/bar,	3),
		new /datum/data/mining_equipment("crisps",	/obj/item/food/vampire/crisps,	5),
		new /datum/data/mining_equipment("water bottle",	/obj/item/reagent_containers/food/drinks/bottle/vampirewater,	5),
		new /datum/data/mining_equipment("soda can",	/obj/item/reagent_containers/food/drinks/soda_cans/vampiresoda,	3),
		new /datum/data/mining_equipment("cola bottle",	/obj/item/reagent_containers/food/drinks/bottle/vampirecola,	7),
		new /datum/data/mining_equipment("cola can",	/obj/item/reagent_containers/food/drinks/soda_cans/vampirecola,	5),
		new /datum/data/mining_equipment("milk",	/obj/item/reagent_containers/food/condiment/vampiremilk,	5),
		new /datum/data/mining_equipment("beer bottle",	/obj/item/reagent_containers/food/drinks/beer/vampire,	10)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/clothing
	prize_list = list(new /datum/data/mining_equipment("clothes",	/obj/item/clothing/under/vampire/larry,	15),
		new /datum/data/mining_equipment("clothes",	/obj/item/clothing/under/vampire/bandit,	15),
		new /datum/data/mining_equipment("clothes",	/obj/item/clothing/under/vampire/biker,	15),
		new /datum/data/mining_equipment("clothes",	/obj/item/clothing/under/vampire/mechanic,	20),
		new /datum/data/mining_equipment("clothes",	/obj/item/clothing/under/vampire/sport,	20),
		new /datum/data/mining_equipment("clothes",	/obj/item/clothing/under/vampire/office,	20),
		new /datum/data/mining_equipment("clothes",	/obj/item/clothing/under/vampire/emo,	20),
		new /datum/data/mining_equipment("clothes",	/obj/item/clothing/under/vampire/black,	20),
		new /datum/data/mining_equipment("clothes",	/obj/item/clothing/under/vampire/red,	20),
		new /datum/data/mining_equipment("clothes",	/obj/item/clothing/under/vampire/gothic,	20),
		new /datum/data/mining_equipment("clothes",	/obj/item/clothing/under/vampire/sexy,	25),
		new /datum/data/mining_equipment("clothes",	/obj/item/clothing/under/vampire/pimp,	25),
		new /datum/data/mining_equipment("clothes",	/obj/item/clothing/under/vampire/rich,	25),
		new /datum/data/mining_equipment("clothes",	/obj/item/clothing/under/vampire/business,	25),
		new /datum/data/mining_equipment("shoes",	/obj/item/clothing/shoes/vampire,	10),
		new /datum/data/mining_equipment("shoes",	/obj/item/clothing/shoes/vampire/brown,	10),
		new /datum/data/mining_equipment("shoes",	/obj/item/clothing/shoes/vampire/white,	10),
		new /datum/data/mining_equipment("shoes",	/obj/item/clothing/shoes/vampire/jackboots,	10),
		new /datum/data/mining_equipment("shoes",	/obj/item/clothing/shoes/vampire/jackboots/work,	10),
		new /datum/data/mining_equipment("shoes",	/obj/item/clothing/shoes/vampire/sneakers,	10),
		new /datum/data/mining_equipment("shoes",	/obj/item/clothing/shoes/vampire/sneakers/red,	10),
		new /datum/data/mining_equipment("shoes",	/obj/item/clothing/shoes/vampire/heels,	10),
		new /datum/data/mining_equipment("shoes",	/obj/item/clothing/shoes/vampire/heels/red,	10),
		new /datum/data/mining_equipment("suit",	/obj/item/clothing/suit/vampire/coat,	15),
		new /datum/data/mining_equipment("suit",	/obj/item/clothing/suit/vampire/coat/alt,	15),
		new /datum/data/mining_equipment("suit",	/obj/item/clothing/suit/vampire/jacket,	15),
		new /datum/data/mining_equipment("suit",	/obj/item/clothing/suit/vampire/trench,	15),
		new /datum/data/mining_equipment("suit",	/obj/item/clothing/suit/vampire/trench/alt,	15),
		new /datum/data/mining_equipment("suit",	/obj/item/clothing/suit/vampire/labcoat,	15),
		new /datum/data/mining_equipment("glasses",	/obj/item/clothing/glasses/vampire/yellow,	20),
		new /datum/data/mining_equipment("glasses",	/obj/item/clothing/glasses/vampire/sun,	20),
		new /datum/data/mining_equipment("glasses",	/obj/item/clothing/glasses/vampire/perception,	20),
		new /datum/data/mining_equipment("hat",	/obj/item/clothing/head/vampire/bandana,	10),
		new /datum/data/mining_equipment("hat",	/obj/item/clothing/head/vampire/bandana/red,	10),
		new /datum/data/mining_equipment("hat",	/obj/item/clothing/head/vampire/bandana/black,	10),
		new /datum/data/mining_equipment("hat",	/obj/item/clothing/head/vampire/beanie,	10),
		new /datum/data/mining_equipment("hat",	/obj/item/clothing/head/vampire/beanie/black,	10),
		new /datum/data/mining_equipment("hat",	/obj/item/clothing/head/vampire/beanie/homeless,	10),
		new /datum/data/mining_equipment("neck",	/obj/item/clothing/neck/vampire/scarf,	10),
		new /datum/data/mining_equipment("neck",	/obj/item/clothing/neck/vampire/scarf/red,	10),
		new /datum/data/mining_equipment("neck",	/obj/item/clothing/neck/vampire/scarf/blue,	10),
		new /datum/data/mining_equipment("neck",	/obj/item/clothing/neck/vampire/scarf/green,	10),
		new /datum/data/mining_equipment("neck",	/obj/item/clothing/neck/vampire/scarf/white,	10)
	)

/obj/food_cart
	name = "food cart"
	desc = "Ding-aling ding dong. Get your cholesterine!"
	icon = 'code/modules/ziggers/32x48.dmi'
	icon_state = "vat1"
	density = TRUE
	anchored = TRUE
	layer = ABOVE_MOB_LAYER

/obj/food_cart/Initialize()
	. = ..()
	icon_state = "vat[rand(1, 3)]"

/obj/machinery/mineral/equipment_vendor/fastfood/america
	prize_list = list(new /datum/data/mining_equipment("revolver",	/obj/item/gun/ballistic/vampire/revolver,	50),
		new /datum/data/mining_equipment("desert eagle",	/obj/item/gun/ballistic/automatic/vampire/deagle,	150),
		new /datum/data/mining_equipment("mini uzi",	/obj/item/gun/ballistic/automatic/vampire/uzi,	250),
		new /datum/data/mining_equipment("AR-15 rifle",		/obj/item/gun/ballistic/automatic/vampire/ar15,	500),
		new /datum/data/mining_equipment("sniper rifle",		/obj/item/gun/ballistic/automatic/vampire/sniper,	500),
		new /datum/data/mining_equipment("AUG carbine",		/obj/item/gun/ballistic/automatic/vampire/aug,	750),
		new /datum/data/mining_equipment("fishing rod",		/obj/item/fishing_rod,	50),
		new /datum/data/mining_equipment("9mm ammo",	/obj/item/ammo_box/vampire/c9mm,	150),
		new /datum/data/mining_equipment(".44 ammo",	/obj/item/ammo_box/vampire/c44,	200),
		new /datum/data/mining_equipment("5.56 ammo",	/obj/item/ammo_box/vampire/c556,	300),
		new /datum/data/mining_equipment("mini uzi magazine",	/obj/item/ammo_box/magazine/vamp9mm,	25),
		new /datum/data/mining_equipment("desert eagle magazine",	/obj/item/ammo_box/magazine/m44,	25),
		new /datum/data/mining_equipment("AR-15 rifle magazine",	/obj/item/ammo_box/magazine/vamp556,	25),
		new /datum/data/mining_equipment("AUG carbine magazine",	/obj/item/ammo_box/magazine/vampaug,	25),
		new /datum/data/mining_equipment("knife",	/obj/item/melee/vampirearms/knife,	50),
		new /datum/data/mining_equipment("baseball bat",	/obj/item/melee/vampirearms/baseball,	100),
		new /datum/data/mining_equipment("real katana",	/obj/item/melee/vampirearms/katana,	500),
		new /datum/data/mining_equipment("donut",	/obj/item/food/vampire/donut,	10)
	)

/obj/machinery/mineral/equipment_vendor/fastfood/illegal
	prize_list = list(new /datum/data/mining_equipment("morphine syringe",	/obj/item/reagent_containers/syringe/contraband/morphine,	100),
		new /datum/data/mining_equipment("crank syringe",	/obj/item/reagent_containers/syringe/contraband/crank,	100),
		new /datum/data/mining_equipment("krokodil syringe",	/obj/item/reagent_containers/syringe/contraband/krokodil,	100),
		new /datum/data/mining_equipment("LSD pill bottle",		/obj/item/storage/pill_bottle/lsd,	50),
		new /datum/data/mining_equipment("LSD pill",		/obj/item/reagent_containers/pill/lsd,	10),
		new /datum/data/mining_equipment("cannabis puff",		/obj/item/clothing/mask/cigarette/rollie/cannabis,	25),
		new /datum/data/mining_equipment("cannabis leaf",	/obj/item/food/grown/cannabis,	10),
		new /datum/data/mining_equipment("incendiary 5.56 ammo",	/obj/item/ammo_box/vampire/c556/incendiary,	200),
		new /datum/data/mining_equipment("stake",	/obj/item/melee/vampirearms/stake,	50)
		)