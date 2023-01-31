//CAMARILLA

/datum/job/vamp/prince
	title = "Prince"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD|DEADMIN_POSITION_SECURITY
	department_head = list("Justicar")
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Camarilla and the Traditions"
	selection_color = "#bd3327"
	req_admin_notify = 1
	minimal_player_age = 14
	exp_requirements = 180
	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_CAMARILLIA

	outfit = /datum/outfit/job/prince

	access = list() 			//See get_access()
	minimal_access = list() 	//See get_access()
	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SEC

	liver_traits = list(TRAIT_ROYAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_PRINCE

	minimal_generation = 10

	my_contact_is_important = TRUE
	known_contacts = list("Sheriff",
												"Clerk",
												"Barkeeper")

	duty = "Represent interests of Camarilla and maintain Masquerade."

/datum/job/prince/get_access()
	return get_all_accesses()

/datum/job/prince/announce(mob/living/carbon/human/H)
	..()
	SSticker.OnRoundstart(CALLBACK(GLOBAL_PROC, .proc/minor_announce, "Prince [H.real_name] in the city!"))

/datum/outfit/job/prince
	name = "Prince"
	jobtype = /datum/job/prince

	id = /obj/item/card/id/prince
	glasses = /obj/item/clothing/glasses/vampire/sun
	gloves = /obj/item/clothing/gloves/vampire/latex
	uniform =  /obj/item/clothing/under/vampire/prince
	suit = /obj/item/clothing/suit/vampire/trench/alt
	shoes = /obj/item/clothing/shoes/vampire
	l_pocket = /obj/item/vamp/phone/prince
	r_pocket = /obj/item/vamp/keys/prince
	backpack_contents = list(/obj/item/gun/ballistic/automatic/vampire/deagle=1, /obj/item/passport=1, /obj/item/cockclock=1)


	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	implants = list(/obj/item/implant/mindshield)
//	accessory = /obj/item/clothing/accessory/medal/gold/captain

/datum/outfit/job/prince/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/vampire/prince/female
		shoes = /obj/item/clothing/shoes/vampire/heels

/obj/effect/landmark/start/prince
	name = "Prince"
	icon_state = "Prince"

/datum/job/vamp/sheriff
	title = "Sheriff"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD|DEADMIN_POSITION_SECURITY
	department_head = list("Prince")
	head_announce = list(RADIO_CHANNEL_SECURITY)
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the prince"
	selection_color = "#bd3327"
	req_admin_notify = 1
	minimal_player_age = 14
	exp_requirements = 300
	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_SECURITY

	outfit = /datum/outfit/job/sheriff

	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM, TRAIT_ROYAL_METABOLISM)

	access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_ARMORY, ACCESS_COURT, ACCESS_WEAPONS, ACCESS_MECH_SECURITY,
					ACCESS_FORENSICS_LOCKERS, ACCESS_MORGUE, ACCESS_MAINT_TUNNELS, ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_AUX_BASE,
					ACCESS_RESEARCH, ACCESS_ENGINE, ACCESS_MINING, ACCESS_MEDICAL, ACCESS_CONSTRUCTION, ACCESS_MAILSORTING, ACCESS_EVA, ACCESS_TELEPORTER,
					ACCESS_HEADS, ACCESS_HOS, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_GATEWAY, ACCESS_MAINT_TUNNELS, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_ARMORY, ACCESS_COURT, ACCESS_WEAPONS, ACCESS_MECH_SECURITY,
					ACCESS_FORENSICS_LOCKERS, ACCESS_MORGUE, ACCESS_MAINT_TUNNELS, ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_AUX_BASE,
					ACCESS_RESEARCH, ACCESS_ENGINE, ACCESS_MINING, ACCESS_MEDICAL, ACCESS_CONSTRUCTION, ACCESS_MAILSORTING, ACCESS_EVA,
					ACCESS_HEADS, ACCESS_HOS, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_GATEWAY, ACCESS_MAINT_TUNNELS, ACCESS_MINERAL_STOREROOM)
	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SEC

	display_order = JOB_DISPLAY_ORDER_SHERIFF
	bounty_types = CIV_JOB_SEC

	minimal_generation = 11

	my_contact_is_important = TRUE
	known_contacts = list("Prince")

	duty = "Protect the Prince at any cost."

/datum/outfit/job/sheriff
	name = "Sheriff"
	jobtype = /datum/job/vamp/sheriff

	id = /obj/item/card/id/sheriff
	uniform = /obj/item/clothing/under/vampire/sheriff
	belt = /obj/item/melee/vampirearms/katana
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	suit = /obj/item/clothing/suit/vampire/vest
	gloves = /obj/item/clothing/gloves/vampire/leather
//	head = /obj/item/clothing/head/hos/beret
	glasses = /obj/item/clothing/glasses/vampire/sun
	r_pocket = /obj/item/vamp/keys/sheriff
	l_pocket = /obj/item/vamp/phone/sheriff
	backpack_contents = list(/obj/item/gun/ballistic/automatic/vampire/deagle=1, /obj/item/melee/vampirearms/stake=3, /obj/item/passport=1, /obj/item/cockclock=1)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	implants = list(/obj/item/implant/mindshield)

/datum/outfit/job/sheriff/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/vampire/sheriff/female

/obj/effect/landmark/start/sheriff
	name = "Sheriff"
	icon_state = "Sheriff"

/datum/job/vamp/clerk
	title = "Clerk"
	auto_deadmin_role_flags = DEADMIN_POSITION_HEAD
	department_head = list("Prince")
	head_announce = list(RADIO_CHANNEL_SUPPLY, RADIO_CHANNEL_SERVICE)
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the prince"
	selection_color = "#bd3327"
	req_admin_notify = 1
	minimal_player_age = 10
	exp_requirements = 180
	exp_type = EXP_TYPE_CREW
	exp_type_department = EXP_TYPE_NEUTRALS

	outfit = /datum/outfit/job/clerk

	access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_COURT, ACCESS_WEAPONS,
						ACCESS_MEDICAL, ACCESS_PSYCHOLOGY, ACCESS_ENGINE, ACCESS_CHANGE_IDS, ACCESS_AI_UPLOAD, ACCESS_EVA, ACCESS_HEADS,
						ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_MAINT_TUNNELS, ACCESS_BAR, ACCESS_JANITOR, ACCESS_CONSTRUCTION, ACCESS_MORGUE,
						ACCESS_CREMATORIUM, ACCESS_KITCHEN, ACCESS_CARGO, ACCESS_MAILSORTING, ACCESS_QM, ACCESS_HYDROPONICS, ACCESS_LAWYER,
						ACCESS_THEATRE, ACCESS_CHAPEL_OFFICE, ACCESS_LIBRARY, ACCESS_RESEARCH, ACCESS_MINING, ACCESS_VAULT, ACCESS_MINING_STATION,
						ACCESS_MECH_MINING, ACCESS_MECH_ENGINE, ACCESS_MECH_SCIENCE, ACCESS_MECH_SECURITY, ACCESS_MECH_MEDICAL,
						ACCESS_HOP, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_GATEWAY, ACCESS_MINERAL_STOREROOM, ACCESS_AUX_BASE, ACCESS_TELEPORTER)
	minimal_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_COURT, ACCESS_WEAPONS,
						ACCESS_MEDICAL, ACCESS_PSYCHOLOGY, ACCESS_ENGINE, ACCESS_CHANGE_IDS, ACCESS_AI_UPLOAD, ACCESS_EVA, ACCESS_HEADS,
						ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_MAINT_TUNNELS, ACCESS_BAR, ACCESS_JANITOR, ACCESS_CONSTRUCTION, ACCESS_MORGUE,
						ACCESS_CREMATORIUM, ACCESS_KITCHEN, ACCESS_CARGO, ACCESS_MAILSORTING, ACCESS_QM, ACCESS_HYDROPONICS, ACCESS_LAWYER,
						ACCESS_MECH_MINING, ACCESS_MECH_ENGINE, ACCESS_MECH_SCIENCE, ACCESS_MECH_SECURITY, ACCESS_MECH_MEDICAL,
						ACCESS_THEATRE, ACCESS_CHAPEL_OFFICE, ACCESS_LIBRARY, ACCESS_RESEARCH, ACCESS_MINING, ACCESS_VAULT, ACCESS_MINING_STATION,
						ACCESS_HOP, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_GATEWAY, ACCESS_MINERAL_STOREROOM, ACCESS_AUX_BASE, ACCESS_TELEPORTER)
	paycheck = PAYCHECK_COMMAND
	paycheck_department = ACCOUNT_SRV
	bounty_types = CIV_JOB_RANDOM

	liver_traits = list(TRAIT_ROYAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_CLERK

	minimal_generation = 12

	my_contact_is_important = TRUE
	known_contacts = list("Prince")

	duty = "Represent interest of the Prince to other kindred."

/datum/outfit/job/clerk
	name = "Clerk"
	jobtype = /datum/job/vamp/clerk

	id = /obj/item/card/id/clerk
	uniform = /obj/item/clothing/under/vampire/clerk
	shoes = /obj/item/clothing/shoes/vampire/brown
//	head = /obj/item/clothing/head/hopcap
	l_pocket = /obj/item/vamp/phone/clerk
	r_pocket = /obj/item/vamp/keys/clerk
	backpack_contents = list(/obj/item/passport=1, /obj/item/cockclock=1)

/datum/outfit/job/clerk/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/vampire/clerk/female
		shoes = /obj/item/clothing/shoes/vampire/heels

/obj/effect/landmark/start/clerk
	name = "Clerk"
	icon_state = "Clerk"

/datum/job/vamp/agent
	title = "Camarilla Agent"
	auto_deadmin_role_flags = DEADMIN_POSITION_SECURITY
	department_head = list("Prince")
	faction = "Vampire"
	total_positions = 5
	spawn_positions = 5
	supervisors = "the prince"
	selection_color = "#bd3327"
	minimal_player_age = 7
	exp_requirements = 300
	exp_type = EXP_TYPE_CREW

	outfit = /datum/outfit/job/agent

	access = list(ACCESS_MAINT_TUNNELS, ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_MAINT_TUNNELS, ACCESS_MECH_SECURITY, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_FORENSICS_LOCKERS, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_SECURITY, ACCESS_SEC_DOORS, ACCESS_BRIG, ACCESS_COURT, ACCESS_WEAPONS, ACCESS_MECH_SECURITY, ACCESS_MINERAL_STOREROOM) // See /datum/job/officer/get_access()
	paycheck = PAYCHECK_HARD
	paycheck_department = ACCOUNT_SEC

	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_AGENT
	bounty_types = CIV_JOB_SEC
	known_contacts = list("Prince")

	duty = "Work for the Prince and follow orders."

/datum/outfit/job/agent
	name = "Camarilla Agent"
	jobtype = /datum/job/vamp/agent

	id = /obj/item/card/id/camarilla
	uniform = /obj/item/clothing/under/vampire/agent
	gloves = /obj/item/clothing/gloves/vampire/work
	suit = /obj/item/clothing/suit/vampire/trench
	shoes = /obj/item/clothing/shoes/vampire
	r_pocket = /obj/item/vamp/keys/camarilla
	l_pocket = /obj/item/vamp/phone/camarilla
	backpack_contents = list(/obj/item/passport=1, /obj/item/cockclock=1, /obj/item/melee/vampirearms/stake=3)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	implants = list(/obj/item/implant/mindshield)

/obj/effect/landmark/start/camarillaagent
	name = "Camarilla Agent"
	icon_state = "Camarilla Agent"

//NEUTRALS

/datum/job/vamp/graveyard
	title = "Graveyard Keeper"
	department_head = list("Clerk")
	faction = "Vampire"
	total_positions = 3
	spawn_positions = 3
	supervisors = "the Camarilla or the Anarchs"
	selection_color = "#e3e3e3"

	outfit = /datum/outfit/job/graveyard

	access = list(ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_QM, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM, ACCESS_AUX_BASE)
	minimal_access = list(ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MAILSORTING, ACCESS_MINERAL_STOREROOM, ACCESS_AUX_BASE)
	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_CAR

	display_order = JOB_DISPLAY_ORDER_GRAVEYARD
	bounty_types = CIV_JOB_MINE

	duty = "Protect the Graveyard Gates from the undead."

/datum/outfit/job/graveyard
	name = "Graveyard Keeper"
	jobtype = /datum/job/vamp/graveyard

	shoes = /obj/item/clothing/shoes/vampire/jackboots
//	gloves = /obj/item/clothing/gloves/color/black
	uniform = /obj/item/clothing/under/vampire/graveyard
	suit = /obj/item/clothing/suit/vampire/trench
	glasses = /obj/item/clothing/glasses/vampire/yellow
	gloves = /obj/item/clothing/gloves/vampire/work
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/graveyard
	r_hand = /obj/item/melee/vampirearms/shovel
	backpack_contents = list(/obj/item/passport=1, /obj/item/cockclock=1)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

/obj/effect/landmark/start/graveyardkeeper
	name = "Graveyard Keeper"
	icon_state = "Graveyard Keeper"

/datum/job/vamp/vdoctor
	title = "Doctor"
	department_head = list("Clerk")
	faction = "Vampire"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the Camarilla or the Anarchs"
	selection_color = "#e3e3e3"

	outfit = /datum/outfit/job/vdoctor

	access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_PHARMACY, ACCESS_CHEMISTRY, ACCESS_VIROLOGY, ACCESS_MECH_MEDICAL, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_MEDICAL, ACCESS_MORGUE, ACCESS_SURGERY, ACCESS_MECH_MEDICAL, ACCESS_MINERAL_STOREROOM, ACCESS_PHARMACY)
	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_MED

	liver_traits = list(TRAIT_MEDICAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_DOCTOR
	bounty_types = CIV_JOB_MED

	duty = "Collect blood by helping mortals at the Clinic."

/datum/outfit/job/vdoctor
	name = "Doctor"
	jobtype = /datum/job/vamp/vdoctor

	id = /obj/item/card/id/clinic
	uniform = /obj/item/clothing/under/vampire/nurse
	shoes = /obj/item/clothing/shoes/vampire/white
	suit =  /obj/item/clothing/suit/vampire/labcoat
	gloves = /obj/item/clothing/gloves/vampire/latex
	l_hand = /obj/item/storage/firstaid/medical
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/clinic
	backpack_contents = list(/obj/item/passport=1, /obj/item/cockclock=1)

	backpack = /obj/item/storage/backpack
	satchel = /obj/item/storage/backpack/satchel
	duffelbag = /obj/item/storage/backpack/duffelbag

	skillchips = list(/obj/item/skillchip/entrails_reader, /obj/item/skillchip/quickcarry)

/obj/effect/landmark/start/vdoctor
	name = "Doctor"
	icon_state = "Doctor"

/datum/job/vamp/vjanitor
	title = "Street Janitor"
	department_head = list("Barkeeper")
	faction = "Vampire"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the Camarilla or the Anarchs"
	selection_color = "#e3e3e3"

	outfit = /datum/outfit/job/vjanitor

	access = list(ACCESS_JANITOR, ACCESS_MAINT_TUNNELS, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_JANITOR, ACCESS_MAINT_TUNNELS, ACCESS_MINERAL_STOREROOM)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV

	display_order = JOB_DISPLAY_ORDER_STREETJAN

	duty = "Clean up all traces of Masquerade violations."

/datum/outfit/job/vjanitor
	name = "Street Janitor"
	jobtype = /datum/job/vamp/vjanitor

	id = /obj/item/card/id/cleaning
	uniform = /obj/item/clothing/under/vampire/janitor
	l_pocket = /obj/item/vamp/phone
	r_pocket = /obj/item/vamp/keys/cleaning
	shoes = /obj/item/clothing/shoes/vampire/jackboots/work
	gloves = /obj/item/clothing/gloves/vampire/cleaning
	backpack_contents = list(/obj/item/passport=1, /obj/item/cockclock=1)

/obj/effect/landmark/start/vjanitor
	name = "Street Janitor"
	icon_state = "Street Janitor"

/datum/job/vamp/archivist
	title = "Archivist"
	department_head = list("Barkeeper")
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Camarilla or the Anarchs"
	selection_color = "#e3e3e3"

	outfit = /datum/outfit/job/archivist

	access = list(ACCESS_LIBRARY, ACCESS_AUX_BASE, ACCESS_MINING_STATION)
	minimal_access = list(ACCESS_LIBRARY, ACCESS_AUX_BASE, ACCESS_MINING_STATION)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV

	display_order = JOB_DISPLAY_ORDER_ARCHIVIST

	duty = "Keep a census of events and provide information to neonates."

/datum/outfit/job/archivist
	name = "Archivist"
	jobtype = /datum/job/vamp/archivist

	id = /obj/item/card/id/archive
	glasses = /obj/item/clothing/glasses/vampire/perception
	suit = /obj/item/clothing/suit/vampire/trench/archive
	shoes = /obj/item/clothing/shoes/vampire
	gloves = /obj/item/clothing/gloves/vampire/latex
	uniform = /obj/item/clothing/under/vampire/archivist
	r_pocket = /obj/item/vamp/keys/archive
	l_pocket = /obj/item/vamp/phone
	accessory = /obj/item/clothing/accessory/pocketprotector/full
	backpack_contents = list(/obj/item/passport=1, /obj/item/cockclock=1)

/datum/outfit/job/archivist/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/vampire/archivist/female
		shoes = /obj/item/clothing/shoes/vampire/heels

/obj/effect/landmark/start/archivist
	name = "Archivist"
	icon_state = "Archivist"

//ANARCHS

/datum/job/vamp/barkeeper
	title = "Barkeeper"
	department_head = list("Justicar")
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Anarchs and the Traditions"
	selection_color = "#434343"

	outfit = /datum/outfit/job/barkeeper

	access = list(ACCESS_HYDROPONICS, ACCESS_BAR, ACCESS_KITCHEN, ACCESS_MORGUE, ACCESS_WEAPONS, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	minimal_access = list(ACCESS_BAR, ACCESS_MINERAL_STOREROOM, ACCESS_THEATRE)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV
	display_order = JOB_DISPLAY_ORDER_BARKEEPER
	bounty_types = CIV_JOB_DRINK

	minimal_generation = 11

	my_contact_is_important = TRUE
	known_contacts = list("Prince",
												"Dealer")

	duty = "Lead the Anarchs in the City."

/datum/outfit/job/barkeeper
	name = "Barkeeper"
	jobtype = /datum/job/vamp/barkeeper

	id = /obj/item/card/id/anarch
	glasses = /obj/item/clothing/glasses/vampire/sun
	uniform = /obj/item/clothing/under/vampire/bar
	suit = /obj/item/clothing/suit/vampire/jacket/better
	shoes = /obj/item/clothing/shoes/vampire
	gloves = /obj/item/clothing/gloves/vampire/work
	l_pocket = /obj/item/vamp/phone/barkeeper
	r_pocket = /obj/item/vamp/keys/bar
	backpack_contents = list(/obj/item/passport=1, /obj/item/cockclock=1)

/datum/outfit/job/barkeeper/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/vampire/bar/female
		shoes = /obj/item/clothing/shoes/vampire/heels

/obj/effect/landmark/start/barkeeper
	name = "Barkeeper"
	icon_state = "Barkeeper"

/datum/job/vamp/bouncer
	title = "Bouncer"
	department_head = list("Barkeeper")
	faction = "Vampire"
	total_positions = 3
	spawn_positions = 3
	supervisors = "the barkeeper"
	selection_color = "#434343"

	outfit = /datum/outfit/job/bouncer

	access = list(ACCESS_LAWYER, ACCESS_COURT, ACCESS_SEC_DOORS)
	minimal_access = list(ACCESS_LAWYER, ACCESS_COURT, ACCESS_SEC_DOORS)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_SRV

	mind_traits = list(TRAIT_DONUT_LOVER)
	liver_traits = list(TRAIT_LAW_ENFORCEMENT_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_BOUNCER
	known_contacts = list("Barkeeper")

	duty = "Work for the Barkeeper."

/datum/outfit/job/bouncer
	name = "Bouncer"
	jobtype = /datum/job/vamp/bouncer

	id = /obj/item/card/id/anarch
	uniform = /obj/item/clothing/under/vampire/bouncer
	suit = /obj/item/clothing/suit/vampire/jacket
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	r_pocket = /obj/item/vamp/keys/anarch
	l_pocket = /obj/item/vamp/phone/anarch
	r_hand = /obj/item/melee/vampirearms/baseball
	backpack_contents = list(/obj/item/passport=1, /obj/item/cockclock=1, /obj/item/melee/vampirearms/stake=3)

/obj/effect/landmark/start/bouncer
	name = "Bouncer"
	icon_state = "Bouncer"

/datum/job/vamp/dealer
	title = "Dealer"
	department_head = list("Justicar")
	faction = "Vampire"
	total_positions = 1
	spawn_positions = 1
	supervisors = "the Anarchs and the Traditions"
	selection_color = "#434343"
	exp_type_department = EXP_TYPE_SUPPLY // This is so the jobs menu can work properly

	outfit = /datum/outfit/job/dealer

	access = list(ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_QM, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM, ACCESS_VAULT, ACCESS_AUX_BASE)
	minimal_access = list(ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_QM, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM, ACCESS_VAULT, ACCESS_AUX_BASE)
	paycheck = PAYCHECK_MEDIUM
	paycheck_department = ACCOUNT_CAR

	liver_traits = list(TRAIT_PRETENDER_ROYAL_METABOLISM)

	display_order = JOB_DISPLAY_ORDER_DEALER
	bounty_types = CIV_JOB_RANDOM

	minimal_generation = 12

	my_contact_is_important = TRUE
	known_contacts = list("Barkeeper")

	duty = "Provide weapons to other kindred in the city."

/datum/outfit/job/dealer
	name = "Dealer"
	jobtype = /datum/job/vamp/dealer

	id = /obj/item/card/id/dealer
	uniform = /obj/item/clothing/under/vampire/suit
	shoes = /obj/item/clothing/shoes/vampire/brown
	glasses = /obj/item/clothing/glasses/vampire/sun
	l_pocket = /obj/item/vamp/phone/dealer
	r_pocket = /obj/item/vamp/keys/supply
	backpack_contents = list(/obj/item/passport=1, /obj/item/cockclock=1)

/datum/outfit/job/dealer/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/vampire/suit/female
		shoes = /obj/item/clothing/shoes/vampire/heels/red

/obj/effect/landmark/start/dealer
	name = "Dealer"
	icon_state = "Dealer"

/datum/job/vamp/supply
	title = "Supply Technician"
	department_head = list("Dealer")
	faction = "Vampire"
	total_positions = 3
	spawn_positions = 3
	supervisors = "the dealer"
	selection_color = "#434343"

	outfit = /datum/outfit/job/supply

	access = list(ACCESS_MAINT_TUNNELS, ACCESS_MAILSORTING, ACCESS_CARGO, ACCESS_QM, ACCESS_MINING, ACCESS_MECH_MINING, ACCESS_MINING_STATION, ACCESS_MINERAL_STOREROOM)
	minimal_access = list(ACCESS_MAINT_TUNNELS, ACCESS_CARGO, ACCESS_MAILSORTING, ACCESS_MINERAL_STOREROOM, ACCESS_MECH_MINING)
	paycheck = PAYCHECK_EASY
	paycheck_department = ACCOUNT_CAR
	display_order = JOB_DISPLAY_ORDER_SUPPLY
	bounty_types = CIV_JOB_RANDOM
	known_contacts = list("Barkeeper")

	duty = "Manage deliveries and supplies for kindred in the City."

/datum/outfit/job/supply
	name = "Supply Technician"
	jobtype = /datum/job/vamp/supply

	id = /obj/item/card/id/supplytech
	uniform = /obj/item/clothing/under/vampire/supply
	gloves = /obj/item/clothing/gloves/vampire/work
	l_pocket = /obj/item/vamp/phone/anarch
	r_pocket = /obj/item/vamp/keys/supply
	shoes = /obj/item/clothing/shoes/vampire/jackboots
	backpack_contents = list(/obj/item/passport=1, /obj/item/cockclock=1)

/obj/effect/landmark/start/supplytechnician
	name = "Supply Technician"
	icon_state = "Supply Technician"

//ASS ISTANTS

/datum/job/vamp/citizen
	title = "Citizen"
	faction = "Vampire"
	total_positions = -1
	spawn_positions = -1
	supervisors = "the Traditions"
	selection_color = "#7e7e7e"
	access = list()			//See /datum/job/assistant/get_access()
	minimal_access = list()	//See /datum/job/assistant/get_access()
	outfit = /datum/outfit/job/citizen
	antag_rep = 7
	paycheck = PAYCHECK_ASSISTANT // Get a job. Job reassignment changes your paycheck now. Get over it.

	access = list(ACCESS_MAINT_TUNNELS)
	liver_traits = list(TRAIT_GREYTIDE_METABOLISM)

	paycheck_department = ACCOUNT_CIV
	display_order = JOB_DISPLAY_ORDER_CITIZEN

	duty = "Follow the Traditions, or other laws provided by the current authority among your kind."

/datum/outfit/job/citizen
	name = "Citizen"
	jobtype = /datum/job/vamp/citizen
	l_pocket = /obj/item/vamp/phone
	id = /obj/item/cockclock
	backpack_contents = list(/obj/item/passport=1)

/datum/outfit/job/citizen/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == MALE)
		shoes = /obj/item/clothing/shoes/vampire
		if(H.clane.male_clothes)
			uniform = text2path(H.clane.male_clothes)
	else
		shoes = /obj/item/clothing/shoes/vampire/heels
		if(H.clane.female_clothes)
			uniform = text2path(H.clane.female_clothes)

/obj/effect/landmark/start/citizen
	name = "Citizen"
	icon_state = "Assistant"


//ID

/obj/item/card/id/prince
	name = "leader badge"
	id_type_name = "leader badge"
	desc = "King in the castle!"
	icon = 'code/modules/ziggers/items.dmi'
	icon_state = "id6"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	worn_icon = 'code/modules/ziggers/worn.dmi'
	worn_icon_state = "id6"

/obj/item/card/id/sheriff
	name = "head security badge"
	id_type_name = "head security badge"
	desc = "A badge which shows honour and dedication."
	icon = 'code/modules/ziggers/items.dmi'
	icon_state = "id4"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	worn_icon = 'code/modules/ziggers/worn.dmi'
	worn_icon_state = "id4"

/obj/item/card/id/camarilla
	name = "security badge"
	id_type_name = "security badge"
	desc = "A badge which shows honour and dedication."
	icon = 'code/modules/ziggers/items.dmi'
	icon_state = "id3"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	worn_icon = 'code/modules/ziggers/worn.dmi'
	worn_icon_state = "id3"

/obj/item/card/id/clerk
	name = "clerk badge"
	id_type_name = "clerk badge"
	desc = "A badge which shows buerocracy qualification."
	icon = 'code/modules/ziggers/items.dmi'
	icon_state = "id1"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	worn_icon = 'code/modules/ziggers/worn.dmi'
	worn_icon_state = "id1"

/obj/item/card/id/anarch
	name = "biker badge"
	id_type_name = "biker badge"
	desc = "A badge which shows protest and anarchy."
	icon = 'code/modules/ziggers/items.dmi'
	icon_state = "id5"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	worn_icon = 'code/modules/ziggers/worn.dmi'
	worn_icon_state = "id5"

/obj/item/card/id/clinic
	name = "medical badge"
	id_type_name = "medical badge"
	desc = "A badge which shows medical qualification."
	icon = 'code/modules/ziggers/items.dmi'
	icon_state = "id2"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	worn_icon = 'code/modules/ziggers/worn.dmi'
	worn_icon_state = "id2"

/obj/item/card/id/archive
	name = "librarian badge"
	id_type_name = "librarian badge"
	desc = "A badge which shows the love to books."
	icon = 'code/modules/ziggers/items.dmi'
	icon_state = "id7"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	worn_icon = 'code/modules/ziggers/worn.dmi'
	worn_icon_state = "id7"

/obj/item/card/id/cleaning
	name = "janitor badge"
	id_type_name = "janitor badge"
	desc = "A badge which shows cleaning employment."
	icon = 'code/modules/ziggers/items.dmi'
	icon_state = "id8"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	worn_icon = 'code/modules/ziggers/worn.dmi'
	worn_icon_state = "id8"

/obj/item/card/id/dealer
	name = "business badge"
	id_type_name = "business badge"
	desc = "A badge which shows business."
	icon = 'code/modules/ziggers/items.dmi'
	icon_state = "id9"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	worn_icon = 'code/modules/ziggers/worn.dmi'
	worn_icon_state = "id9"

/obj/item/card/id/supplytech
	name = "technician badge"
	id_type_name = "technician badge"
	desc = "A badge which shows supply employment."
	icon = 'code/modules/ziggers/items.dmi'
	icon_state = "id10"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	worn_icon = 'code/modules/ziggers/worn.dmi'
	worn_icon_state = "id10"

/obj/item/card/id/hunter
	name = "cross"
	id_type_name = "cross"
	desc = "When you come into the land that the Lord your God is giving you, you must not learn to imitate the abhorrent practices of those nations. No one shall be found among you who makes a son or daughter pass through fire, or who practices divination, or is a soothsayer, or an augur, or a sorcerer, or one who casts spells, or who consults ghosts or spirits, or who seeks oracles from the dead. For whoever does these things is abhorrent to the Lord; it is because of such abhorrent practices that the Lord your God is driving them out before you (Deuteronomy 18:9-12)."
	icon = 'code/modules/ziggers/items.dmi'
	icon_state = "id11"
	inhand_icon_state = "card-id"
	lefthand_file = 'icons/mob/inhands/equipment/idcards_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/idcards_righthand.dmi'
	onflooricon = 'code/modules/ziggers/onfloor.dmi'
	worn_icon = 'code/modules/ziggers/worn.dmi'
	worn_icon_state = "id11"