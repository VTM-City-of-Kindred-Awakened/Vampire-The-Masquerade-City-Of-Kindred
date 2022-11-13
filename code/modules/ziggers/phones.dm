/mob/living/carbon/human
	var/phonevoicetag = 10

/proc/create_unique_phone_number(var/exchange = 513)
	if(length(GLOB.subscribers_numbers_list) < 1)
		create_subscribers_numbers()
	var/subscriber_code = pick(GLOB.subscribers_numbers_list)
	GLOB.subscribers_numbers_list -= subscriber_code
	return "[exchange] [subscriber_code]"

/proc/create_subscribers_numbers()
	for(var/i in 1 to 9999)
		var/ii = "0000"
		switch(i)
			if(1 to 9)
				ii = "000[i]"
			if(10 to 99)
				ii = "00[i]"
			if(100 to 999)
				ii = "0[i]"
			if(1000 to 9999)
				ii = "[i]"
		GLOB.subscribers_numbers_list += ii

/datum/phonecontact
	var/name = "Unknown"
	var/number = ""

/datum/phonecontact/proc/check_global_contacts()
	return

/datum/phonecontact/prince
	name = "Prince"

/datum/phonecontact/prince/check_global_contacts()
	number = GLOB.princenumber

/datum/phonecontact/sheriff
	name = "Sheriff"

/datum/phonecontact/sheriff/check_global_contacts()
	number = GLOB.sheriffnumber

/datum/phonecontact/clerk
	name = "Clerk"

/datum/phonecontact/clerk/check_global_contacts()
	number = GLOB.clerknumber

/datum/phonecontact/barkeeper
	name = "Barkeeper"

/datum/phonecontact/barkeeper/check_global_contacts()
	number = GLOB.barkeepernumber

/datum/phonecontact/dealer
	name = "Dealer"

/datum/phonecontact/dealer/check_global_contacts()
	number = GLOB.dealernumber

/obj/item/vamp/phone
	name = "\improper phone"
	desc = "A portable device to call anyone you want."
	icon = 'code/modules/ziggers/items.dmi'
	icon_state = "phone0"
	inhand_icon_state = "phone0"
	lefthand_file = 'code/modules/ziggers/lefthand.dmi'
	righthand_file = 'code/modules/ziggers/righthand.dmi'
	item_flags = NOBLUDGEON
	flags_1 = HEAR_1
	w_class = WEIGHT_CLASS_TINY
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 100, ACID = 100)
	resistance_flags = FIRE_PROOF | ACID_PROOF

	var/exchange_num = 513
	var/list/contacts = list()
	var/closed = TRUE
	var/number
	var/obj/item/vamp/phone/online
	var/talking = FALSE
	var/choosed_number = ""
	var/last_call = 0
	var/call_sound = 'code/modules/ziggers/call.ogg'

/obj/phonevoice
	name = "unknown voice"
	speech_span = SPAN_ROBOT
	anchored = FALSE
	density = FALSE
	opacity = FALSE

/obj/phonevoice/say(message, bubble_type, list/spans = list(), sanitize = TRUE, datum/language/language = null, ignore_spam = FALSE, forced = null)
	if(message == "" || !message)
		return
	spans |= speech_span
	if(!language)
		language = get_selected_language()
	send_speech(message, 2, src, , spans, message_language=language)
//	speech_span = initial(speech_span)

/obj/item/vamp/phone/Initialize()
	..()
	RegisterSignal(src, COMSIG_MOVABLE_HEAR, .proc/handle_hearing)
	if(!number || number == "")
		number = create_unique_phone_number(exchange_num)
	GLOB.phone_numbers_list += number
	GLOB.phones_list += src

/obj/item/vamp/phone/Destroy()
	GLOB.phone_numbers_list -= number
	GLOB.phones_list -= src
	UnregisterSignal(src, COMSIG_MOVABLE_HEAR)
	..()

/obj/item/vamp/phone/attack_self(mob/user)
	..()
	if(closed)
		closed = FALSE
		icon_state = "phone2"
	else
		user << browse(null, "window=phone")
		closed = TRUE
		icon_state = "phone0"
		talking = FALSE
		if(online)
			online.online = null
			online.talking = FALSE
			online = null

/obj/item/vamp/phone/attack_hand(mob/user)
	if(!closed && user.get_inactive_held_item() == src)
		OpenMenu(user)
	else
		..()

/obj/item/vamp/phone/proc/OpenMenu(var/mob/mobila)
	var/dat = "<center><h2>Phone</h2><BR>"
	if(last_call+100 > world.time && !talking)
		dat += "Calling...<BR>"
		dat += "<a href='byond://?src=[REF(src)];choice=hang'><b>Hang up</b></a><BR>"
	else
		if(online)
			var/who_talking_with = "(+1 707) [online.number]"
			for(var/datum/phonecontact/P in contacts)
				if(P.number == online.number)
					who_talking_with = P.name
			if(talking)
				dat += "Current call: [who_talking_with]<BR>"
				dat += "<a href='byond://?src=[REF(src)];choice=hang'><b>Hang up</b></a><BR>"
			else
				dat += "[who_talking_with] is calling!<BR>"
				dat += "<a href='byond://?src=[REF(src)];choice=accept'><b>Accept</b></a><BR>"
				dat += "<a href='byond://?src=[REF(src)];choice=decline'><b>Decline</b></a><BR>"
		else
			if(number)
				dat += "My number is (+1 707) [number]<BR>"
			dat += "Typed number: [choosed_number]_<BR>"
			dat += "<a href='byond://?src=[REF(src)];choice=1'>1</a>||<a href='byond://?src=[REF(src)];choice=2'>2</a>||<a href='byond://?src=[REF(src)];choice=3'>3</a><BR>"
			dat += "<a href='byond://?src=[REF(src)];choice=4'>4</a>||<a href='byond://?src=[REF(src)];choice=5'>5</a>||<a href='byond://?src=[REF(src)];choice=6'>6</a><BR>"
			dat += "<a href='byond://?src=[REF(src)];choice=7'>7</a>||<a href='byond://?src=[REF(src)];choice=8'>8</a>||<a href='byond://?src=[REF(src)];choice=9'>9</a><BR>"
			dat += "<a href='byond://?src=[REF(src)];choice=space'>_</a>||<a href='byond://?src=[REF(src)];choice=0'>0</a>||<a href='byond://?src=[REF(src)];choice=cage'>#</a><BR>"
			dat += "<a href='byond://?src=[REF(src)];choice=reset'>*</a><BR>"
			dat += "<a href='byond://?src=[REF(src)];choice=call'><b>Call</b></a><BR>"
			dat += "<a href='byond://?src=[REF(src)];choice=contacts'><b>Contacts</b></a><BR>"
			dat += "<a href='byond://?src=[REF(src)];choice=add'><b>Add contact</b></a><BR>"
	dat += "</center>"
	mobila << browse(dat, "window=phone;size=250x350;border=1;can_resize=0;can_minimize=0")
	onclose(mobila, "phone", src)

/obj/item/vamp/phone/proc/Recall(var/obj/item/vamp/phone/abonent, var/mob/usar)
	if(last_call+100 <= world.time && !talking)
		last_call = 0
		if(online)
			playsound(src, 'code/modules/ziggers/phonestop.ogg', 25, FALSE)
			online.online = null
			online = null
	if(!talking && online)
		playsound(src, 'code/modules/ziggers/phone.ogg', 10, FALSE)
		playsound(online, online.call_sound, 25, FALSE)
		addtimer(CALLBACK(src, .proc/Recall, online, usar), 20)
//	usar << browse(null, "window=phone")
//	OpenMenu(usar)

/obj/item/vamp/phone/Topic(href, href_list)
	..()
	var/mob/living/U = usr
	if(usr.canUseTopic(src, BE_CLOSE, FALSE, NO_TK) && !href_list["close"] && !closed)
		switch(href_list["choice"])
			if("hang")
				last_call = 0
				if(talking)
					talking = FALSE
					if(online)
						online.talking = FALSE
				if(online)
					playsound(online, 'code/modules/ziggers/phonestop.ogg', 25, FALSE)
					online.online = null
					online = null
			if("accept")
				if(online)
					talking = TRUE
					online.online = src
					online.talking = TRUE
					for(var/mob/living/L in oviewers(online))
						L << browse(null, "window=phone")
						online.OpenMenu(L)
			if("decline")
				talking = FALSE
				if(online)
					playsound(online, 'code/modules/ziggers/phonestop.ogg', 25, FALSE)
					online.online = null
					online.talking = FALSE
					online = null
			if("call")
				for(var/obj/item/vamp/phone/PHN in GLOB.phones_list)
					if(PHN.number == choosed_number)
						if(!PHN.online && !PHN.talking)
							last_call = world.time
							online = PHN
							PHN.online = src
							Recall(online, usr)
						else
							to_chat(usr, "<span class='notice'>Abonent is busy.</span>")
				if(online)
					for(var/mob/living/L in oviewers(online))
						L << browse(null, "window=phone")
						online.OpenMenu(L)
				else
					if(choosed_number == "#111")
						call_sound = 'code/modules/ziggers/call.ogg'
						to_chat(usr, "<span class='notice'>Settings are now reset to default.</span>")
					else if(choosed_number == "#228")
						call_sound = 'code/modules/ziggers/nokia.ogg'
						to_chat(usr, "<span class='notice'>Code activated.</span>")
					else if(choosed_number == "#666")
						call_sound = 'sound/voice/human/malescream_6.ogg'
						to_chat(usr, "<span class='notice'>Code activated.</span>")
					else if(choosed_number == "#34")
						usr << link("https://rule34.xxx/index.php?page=post&s=list&tags=werewolf")
						to_chat(usr, "<span class='notice'>Code activated.</span>")
					else
						to_chat(usr, "<span class='notice'>Invalid number.</span>")
			if("contacts")
				var/list/shit = list()
				for(var/datum/phonecontact/CNTCT in contacts)
					if(CNTCT)
						shit += CNTCT.name
				if(length(shit) >= 1)
					var/result = input(usr, "Select a contact", "Contact Selection") as null|anything in shit
					if(result)
						for(var/datum/phonecontact/CNTCT in contacts)
							if(CNTCT.name == result)
								if(CNTCT.number == "")
									CNTCT.check_global_contacts()
									if(CNTCT.number == "")
										to_chat(usr, "<span class='notice'>Sorry, [CNTCT.name] still got no actual number.</span>")
								choosed_number = CNTCT.number
			if("add")
				var/new_contact = input(usr, "Input phone number", "Add Contact")  as text|null
				if(new_contact)
					var/datum/phonecontact/NEWC = new()
					NEWC.number = "[new_contact]"
					contacts += NEWC
					var/new_contact_name = input(usr, "Input name", "Add Contact")  as text|null
					if(new_contact_name)
						NEWC.name = "[new_contact_name]"
					else
						var/numbrr = length(contacts)+1
						NEWC.name = "Contact [numbrr]"
			if("1")
				choosed_number += "1"
			if("2")
				choosed_number += "2"
			if("3")
				choosed_number += "3"
			if("4")
				choosed_number += "4"
			if("5")
				choosed_number += "5"
			if("6")
				choosed_number += "6"
			if("7")
				choosed_number += "7"
			if("8")
				choosed_number += "8"
			if("9")
				choosed_number += "9"
			if("0")
				choosed_number += "0"
			if("space")
				choosed_number += " "
			if("cage")
				choosed_number += "#"
			if("reset")
				choosed_number = ""
		U << browse(null, "window=phone")
		OpenMenu(usr)
		playsound(src, 'sound/machines/terminal_select.ogg', 15, TRUE)
	else
		U << browse(null, "window=phone")

/obj/item/vamp/phone/proc/handle_hearing(datum/source, list/hearing_args)
	var/message = hearing_args[HEARING_RAW_MESSAGE]
	if(online && talking)
		if(hearing_args[HEARING_SPEAKER])
			if(isliving(hearing_args[HEARING_SPEAKER]))
				var/voice_saying = "unknown voice"
				var/spchspn = SPAN_ROBOT
				switch(get_dist(src, hearing_args[HEARING_SPEAKER]))
					if(3 to INFINITY)
						return
					if(1 to 2)
						spchspn = "small"
					else
						spchspn = SPAN_ROBOT
				if(ishuman(hearing_args[HEARING_SPEAKER]))
					var/mob/living/carbon/human/SPK = hearing_args[HEARING_SPEAKER]
					voice_saying = "[age2agedescription(SPK.age)] [SPK.gender] voice ([SPK.phonevoicetag])"
				var/obj/phonevoice/VOIC = new(online)
				VOIC.name = voice_saying
				VOIC.speech_span = spchspn
				VOIC.say("[message]")
				playsound(online, 'code/modules/ziggers/phonetalk.ogg', 50, FALSE)
				qdel(VOIC)