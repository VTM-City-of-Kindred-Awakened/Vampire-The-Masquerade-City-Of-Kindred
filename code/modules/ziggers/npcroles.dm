/datum/socialrole/bandit
	s_tones = list("caucasian3",
								"latino",
								"mediterranean",
								"asian1",
								"asian2",
								"arab",
								"indian",
								"african1",
								"african2")

	min_age = 18
	max_age = 45
	preferedgender = MALE
	male_names = null
	surnames = null

	hair_colors = list("040404",	//Black
											"120b05",	//Dark Brown
											"342414",	//Brown
											"554433")	//Light Brown
	male_hair = list("Balding Hair",
										"Bedhead",
										"Bedhead 2",
										"Bedhead 3",
										"Boddicker",
										"Business Hair",
										"Business Hair 2",
										"Business Hair 3",
										"Business Hair 4",
										"Coffee House",
										"Combover",
										"Crewcut",
										"Father",
										"Flat Top",
										"Gelled Back",
										"Joestar",
										"Keanu Hair",
										"Oxton",
										"Volaju")
	male_facial = list("Beard (Abraham Lincoln)",
											"Beard (Chinstrap)",
											"Beard (Full)",
											"Beard (Cropped Fullbeard)",
											"Beard (Hipster)",
											"Beard (Neckbeard)",
											"Beard (Three o Clock Shadow)",
											"Beard (Five o Clock Shadow)",
											"Beard (Seven o Clock Shadow)",
											"Moustache (Hulk Hogan)",
											"Moustache (Watson)",
											"Sideburns (Elvis)",
											"Sideburns",
											"Shaved")

	shoes = list(/obj/item/clothing/shoes/vampire/sneakers,
								/obj/item/clothing/shoes/vampire/sneakers/red,
								/obj/item/clothing/shoes/vampire/jackboots)
	uniforms = list(/obj/item/clothing/under/vampire/larry,
									/obj/item/clothing/under/vampire/bandit,
									/obj/item/clothing/under/vampire/biker)
	hats = list(/obj/item/clothing/head/vampire/bandana,
							/obj/item/clothing/head/vampire/bandana/red,
							/obj/item/clothing/head/vampire/bandana/black,
							/obj/item/clothing/head/vampire/beanie,
							/obj/item/clothing/head/vampire/beanie/black)
	pockets = list(/obj/item/stack/dollar/rand,
					/obj/item/vamp/keys/hack)

	male_phrases = list("Ну и на что уставился, олух?",
											"Чмоня, я тебя сейчас не понял. Ты чё домагаешься до меня?",
											"Что тебе от меня нужно, мазафака?",
											"Я вижу тебе удалось проебать где-то свой страх, чумба.",
											"Пиздуй, пока я тебе промеж глаз не зарядил битой!",
											"Отвали, чёртова либераха...",
											"Тебе на более понятном языке объяснить?",
											"Съеби.",
											"Отвянь.",
											"Иди нахуй.")
	neutral_phrases = list("Ну и на что уставился, олух?",
											"Чмоня, я тебя сейчас не понял. Ты чё домагаешься до меня?",
											"Что тебе от меня нужно, мазафака?",
											"Я вижу тебе удалось проебать где-то свой страх, чумба.",
											"Пиздуй, пока я тебе промеж глаз не зарядил битой!",
											"Отвали, чёртова либераха...",
											"Тебе на более понятном языке объяснить?",
											"Съеби.",
											"Отвянь.",
											"Иди нахуй.")
	random_phrases = list("Йоу, нигга!",
												"Эхх, сейчас бы грабануть цыпочку...",
												"В чём дело, бро?",
												"Хочу, блять, поздороваться.",
												"Я тебя видал на рынке, бурда!",
												"Слыхал? Жопа нам всем скоро...",
												"Оо-о, братюня...")
	answer_phrases = list("Да держусь как-то...",
												"Вообще пиздец.",
												"Хуёво, нигга.",
												"Я тебя вообще знаю, чертила?",
												"Точняк.",
												"Ээ-эумм...",
												"Хорошенько я посрал.")
	help_phrases = list("Срань Господня!",
											"УЙДИ, СГИНЬ НАХУЙ!!",
											"Чё за херня?!",
											"Ебать тебя в жопу, гавно!",
											"Валыны достаём, братва!",
											"Пиу-пау, лежау-сосау!!")

/datum/socialrole/usualmale
	s_tones = list("albino",
								"caucasian1",
								"caucasian2",
								"caucasian3")

	min_age = 18
	max_age = 85
	preferedgender = MALE
	male_names = null
	surnames = null

	hair_colors = list("040404",	//Black
										"120b05",	//Dark Brown
										"342414",	//Brown
										"554433",	//Light Brown
										"695c3b",	//Dark Blond
										"ad924e",	//Blond
										"dac07f",	//Light Blond
										"802400",	//Ginger
										"a5380e",	//Ginger alt
										"ffeace",	//Albino
										"650b0b",	//Punk Red
										"14350e",	//Punk Green
										"080918")	//Punk Blue
	male_hair = list("Balding Hair",
										"Bedhead",
										"Bedhead 2",
										"Bedhead 3",
										"Boddicker",
										"Business Hair",
										"Business Hair 2",
										"Business Hair 3",
										"Business Hair 4",
										"Coffee House",
										"Combover",
										"Crewcut",
										"Father",
										"Flat Top",
										"Gelled Back",
										"Joestar",
										"Keanu Hair",
										"Oxton",
										"Volaju")
	male_facial = list("Beard (Abraham Lincoln)",
											"Beard (Chinstrap)",
											"Beard (Full)",
											"Beard (Cropped Fullbeard)",
											"Beard (Hipster)",
											"Beard (Neckbeard)",
											"Beard (Three o Clock Shadow)",
											"Beard (Five o Clock Shadow)",
											"Beard (Seven o Clock Shadow)",
											"Moustache (Hulk Hogan)",
											"Moustache (Watson)",
											"Sideburns (Elvis)",
											"Sideburns",
											"Shaved")

	shoes = list(/obj/item/clothing/shoes/vampire/sneakers,
								/obj/item/clothing/shoes/vampire,
								/obj/item/clothing/shoes/vampire/brown)
	uniforms = list(/obj/item/clothing/under/vampire/mechanic,
									/obj/item/clothing/under/vampire/sport,
									/obj/item/clothing/under/vampire/office,
									/obj/item/clothing/under/vampire/sexy,
									/obj/item/clothing/under/vampire/pimp,
									/obj/item/clothing/under/vampire/emo)
	pockets = list(/obj/item/vamp/keys/npc,
					/obj/item/stack/dollar/rand)

	male_phrases = list("Что тебе нужно, дружище?",
											"Я не понимаю, что вам от меня нужно?",
											"Вы что-то хотели?",
											"Я спешу, не задерживайте меня пожалуйста.",
											"Сходи поищи себе компанию в баре...",
											"Не могу говорить сейчас.",
											"Хорошая ночь, правда?",
											"Эхх...",
											"Даже не знаю, что сказать.",
											"У меня всё.")
	neutral_phrases = list("Что тебе нужно, дружище?",
												"Я не понимаю, что вам от меня нужно?",
												"Вы что-то хотели?",
												"Я спешу, не задерживайте меня пожалуйста.",
												"Сходи поищи себе компанию в баре...",
												"Не могу говорить сейчас.",
												"Хорошая ночь, правда?",
												"Эхх...",
												"Даже не знаю, что сказать.",
												"У меня всё.")
	random_phrases = list("Хэй, приятель!",
												"Эхх, сейчас бы пинту пива...",
												"В чём дело, друг?",
												"Хочу поприветствоваться.",
												"Ого, а мы встречались раньше?",
												"Слышали? Что-то неладное творится в городе.",
												"Оо-о, чувак...")
	answer_phrases = list("Стараюсь...",
												"Неописуемо.",
												"Плохо, друг.",
												"Вы кажется перепутали меня с кем-то.",
												"Да, точно.",
												"О'ке-ей...",
												"Хорошо.")
	help_phrases = list("О Боже!",
											"Уйдите, не подходите ко мне!!",
											"Что же это такое творится?!",
											"Прекратите!",
											"Кто-нибудь, помогите!",
											"Мамочка!")

/datum/socialrole/usualfemale
	s_tones = list("albino",
								"caucasian1",
								"caucasian2",
								"caucasian3")

	min_age = 18
	max_age = 85
	preferedgender = FEMALE
	female_names = null
	surnames = null

	hair_colors = list("040404",	//Black
										"120b05",	//Dark Brown
										"342414",	//Brown
										"554433",	//Light Brown
										"695c3b",	//Dark Blond
										"ad924e",	//Blond
										"dac07f",	//Light Blond
										"802400",	//Ginger
										"a5380e",	//Ginger alt
										"ffeace",	//Albino
										"650b0b",	//Punk Red
										"14350e",	//Punk Green
										"080918")	//Punk Blue
	female_hair = list("Ahoge",
										"Long Bedhead",
										"Beehive",
										"Beehive 2",
										"Bob Hair",
										"Bob Hair 2",
										"Bob Hair 3",
										"Bob Hair 4",
										"Bobcurl",
										"Braided",
										"Braided Front",
										"Braid (Short)",
										"Braid (Low)",
										"Bun Head",
										"Bun Head 2",
										"Bun Head 3",
										"Bun (Large)",
										"Bun (Tight)",
										"Double Bun",
										"Emo",
										"Emo Fringe",
										"Feather",
										"Gentle",
										"Long Hair 1",
										"Long Hair 2",
										"Long Hair 3",
										"Long Over Eye",
										"Long Emo",
										"Long Fringe",
										"Ponytail",
										"Ponytail 2",
										"Ponytail 3",
										"Ponytail 4",
										"Ponytail 5",
										"Ponytail 6",
										"Ponytail 7",
										"Ponytail (High)",
										"Ponytail (Short)",
										"Ponytail (Long)",
										"Ponytail (Country)",
										"Ponytail (Fringe)",
										"Poofy",
										"Short Hair Rosa",
										"Shoulder-length Hair",
										"Volaju")

	shoes = list(/obj/item/clothing/shoes/vampire/heels,
								/obj/item/clothing/shoes/vampire/sneakers,
								/obj/item/clothing/shoes/vampire/jackboots)
	uniforms = list(/obj/item/clothing/under/vampire/black,
									/obj/item/clothing/under/vampire/red,
									/obj/item/clothing/under/vampire/gothic)
	pockets = list(/obj/item/vamp/keys/npc,
					/obj/item/stack/dollar/rand)

	female_phrases = list("Что вы задумали?",
											"Я не понимаю, что вам от меня нужно?",
											"Вы что-то хотели?",
											"Я спешу, не задерживайте меня пожалуйста.",
											"Поищите какую-нибудь другую подружку...",
											"Не могу говорить сейчас.",
											"Хорошая ночь, правда?",
											"Эхх...",
											"Даже не знаю, что сказать.",
											"У меня всё.")
	neutral_phrases = list("Что вы задумали?",
												"Я не понимаю, что вам от меня нужно?",
												"Вы что-то хотели?",
												"Я спешу, не задерживайте меня пожалуйста.",
												"Поищите какую-нибудь другую подружку...",
												"Не могу говорить сейчас.",
												"Хорошая ночь, правда?",
												"Эхх...",
												"Даже не знаю, что сказать.",
												"У меня всё.")
	random_phrases = list("Хэй, пышка!",
												"Эхх, сейчас бы вина...",
												"В чём дело?",
												"Приветики.",
												"Ого, а мы встречались раньше?",
												"Слышали? Что-то неладное творится в городе.",
												"Оо-о, ничего себе...")
	answer_phrases = list("Стараюсь...",
												"Неописуемо.",
												"Плохо, пупсик.",
												"Вы кажется перепутали меня с кем-то.",
												"Да, точно.",
												"О'ке-ей...",
												"Хорошо.")
	help_phrases = list("О Боже!",
											"Уйдите, не подходите ко мне!!",
											"Что же это такое творится?!",
											"Прекратите!",
											"Кто-нибудь, помогите!",
											"На помощь!")

/datum/socialrole/poormale
	s_tones = list("albino",
								"caucasian1",
								"caucasian2",
								"caucasian3")

	min_age = 45
	max_age = 85
	preferedgender = MALE
	male_names = null
	surnames = null

	hair_colors = list("040404",	//Black
										"120b05",	//Dark Brown
										"342414",	//Brown
										"554433",	//Light Brown
										"695c3b",	//Dark Blond
										"ad924e",	//Blond
										"dac07f",	//Light Blond
										"802400",	//Ginger
										"a5380e",	//Ginger alt
										"ffeace",	//Albino
										"650b0b",	//Punk Red
										"14350e",	//Punk Green
										"080918")	//Punk Blue
	male_hair = list("Balding Hair",
										"Bedhead",
										"Bedhead 2",
										"Bedhead 3",
										"Boddicker",
										"Business Hair",
										"Business Hair 2",
										"Business Hair 3",
										"Business Hair 4",
										"Coffee House",
										"Combover",
										"Crewcut",
										"Father",
										"Flat Top",
										"Gelled Back",
										"Joestar",
										"Keanu Hair",
										"Oxton",
										"Volaju")
	male_facial = list("Beard (Abraham Lincoln)",
											"Beard (Chinstrap)",
											"Beard (Full)",
											"Beard (Cropped Fullbeard)",
											"Beard (Hipster)",
											"Beard (Neckbeard)",
											"Beard (Three o Clock Shadow)",
											"Beard (Five o Clock Shadow)",
											"Beard (Seven o Clock Shadow)",
											"Moustache (Hulk Hogan)",
											"Moustache (Watson)",
											"Sideburns (Elvis)",
											"Sideburns")

	shoes = list(/obj/item/clothing/shoes/vampire/jackboots/work)
	uniforms = list(/obj/item/clothing/under/vampire/homeless)
	suits = list(/obj/item/clothing/suit/vampire/coat)
	hats = list(/obj/item/clothing/head/vampire/beanie/black)
	gloves = list(/obj/item/clothing/gloves/vampire/work)
	neck = list(/obj/item/clothing/neck/vampire/scarf/red,
							/obj/item/clothing/neck/vampire/scarf,
							/obj/item/clothing/neck/vampire/scarf/blue,
							/obj/item/clothing/neck/vampire/scarf/green,
							/obj/item/clothing/neck/vampire/scarf/white)

	male_phrases = list("Ох, блять, пиздец...",
											"Нам всем пиздец!",
											"Уэ-э...",
											"Бррр.",
											"Жахнуть бы сто грамчиков...")
	neutral_phrases = list("Ох, блять, пиздец...",
												"Нам всем пиздец!",
												"Уэ-э...",
												"Бррр.",
												"Жахнуть бы сто грамчиков...")
	random_phrases = list("Ох, блять, пиздец...",
												"Нам всем пиздец!",
												"Уэ-э...",
												"Бррр.",
												"Жахнуть бы сто грамчиков...")
	answer_phrases = list("Ох, блять, пиздец...",
												"Нам всем пиздец!",
												"Уэ-э...",
												"Бррр.",
												"Жахнуть бы сто грамчиков...")
	help_phrases = list("ААаа!",
											"У-ААА!!",
											"Что за хуета? Где моя водка?!",
											"Говно!",
											"Жопа!",
											"Хой!")

/datum/socialrole/poorfemale
	s_tones = list("albino",
								"caucasian1",
								"caucasian2",
								"caucasian3")

	min_age = 45
	max_age = 85
	preferedgender = FEMALE
	female_names = null
	surnames = null

	hair_colors = list("040404",	//Black
										"120b05",	//Dark Brown
										"342414",	//Brown
										"554433",	//Light Brown
										"695c3b",	//Dark Blond
										"ad924e",	//Blond
										"dac07f",	//Light Blond
										"802400",	//Ginger
										"a5380e",	//Ginger alt
										"ffeace",	//Albino
										"650b0b",	//Punk Red
										"14350e",	//Punk Green
										"080918")	//Punk Blue
	female_hair = list("Ahoge",
										"Long Bedhead",
										"Beehive",
										"Beehive 2",
										"Bob Hair",
										"Bob Hair 2",
										"Bob Hair 3",
										"Bob Hair 4",
										"Bobcurl",
										"Braided",
										"Braided Front",
										"Braid (Short)",
										"Braid (Low)",
										"Bun Head",
										"Bun Head 2",
										"Bun Head 3",
										"Bun (Large)",
										"Bun (Tight)",
										"Double Bun",
										"Emo",
										"Emo Fringe",
										"Feather",
										"Gentle",
										"Long Hair 1",
										"Long Hair 2",
										"Long Hair 3",
										"Long Over Eye",
										"Long Emo",
										"Long Fringe",
										"Ponytail",
										"Ponytail 2",
										"Ponytail 3",
										"Ponytail 4",
										"Ponytail 5",
										"Ponytail 6",
										"Ponytail 7",
										"Ponytail (High)",
										"Ponytail (Short)",
										"Ponytail (Long)",
										"Ponytail (Country)",
										"Ponytail (Fringe)",
										"Poofy",
										"Short Hair Rosa",
										"Shoulder-length Hair",
										"Volaju")

	shoes = list(/obj/item/clothing/shoes/vampire/brown)
	uniforms = list(/obj/item/clothing/under/vampire/homeless/female)
	suits = list(/obj/item/clothing/suit/vampire/coat/alt)
	hats = list(/obj/item/clothing/head/vampire/beanie/homeless)

	female_phrases = list("Ох, блять, пиздец...",
											"Нам всем пиздец!",
											"Уэ-э...",
											"Бррр.",
											"Жахнуть бы сто грамчиков...")
	neutral_phrases = list("Ох, блять, пиздец...",
											"Нам всем пиздец!",
											"Уэ-э...",
											"Бррр.",
											"Жахнуть бы сто грамчиков...")
	random_phrases = list("Ох, блять, пиздец...",
											"Нам всем пиздец!",
											"Уэ-э...",
											"Бррр.",
											"Жахнуть бы сто грамчиков...")
	answer_phrases = list("Ох, блять, пиздец...",
											"Нам всем пиздец!",
											"Уэ-э...",
											"Бррр.",
											"Жахнуть бы сто грамчиков...")
	help_phrases = list("ААаа!",
											"У-ААА!!",
											"Что за хуета? Где моя водка?!",
											"Говно!",
											"Жопа!",
											"Хой!")

/datum/socialrole/richmale
	s_tones = list("albino")

	min_age = 18
	max_age = 85
	preferedgender = MALE
	male_names = null
	surnames = null

	hair_colors = list("040404",	//Black
										"120b05",	//Dark Brown
										"342414",	//Brown
										"554433",	//Light Brown
										"695c3b",	//Dark Blond
										"ad924e",	//Blond
										"dac07f",	//Light Blond
										"802400",	//Ginger
										"a5380e",	//Ginger alt
										"ffeace",	//Albino
										"650b0b",	//Punk Red
										"14350e",	//Punk Green
										"080918")	//Punk Blue
	male_hair = list("Business Hair",
										"Business Hair 2",
										"Business Hair 3",
										"Business Hair 4",
										"Coffee House",
										"Combover",
										"Crewcut",
										"Father",
										"Flat Top",
										"Gelled Back",
										"Joestar",
										"Keanu Hair",
										"Oxton",
										"Volaju")
	male_facial = list("Beard (Neckbeard)",
											"Beard (Three o Clock Shadow)",
											"Sideburns (Elvis)",
											"Sideburns",
											"Shaved")

	shoes = list(/obj/item/clothing/shoes/vampire,
								/obj/item/clothing/shoes/vampire/white)
	uniforms = list(/obj/item/clothing/under/vampire/rich)
	inhand_items = list(/obj/item/storage/briefcase)
	pockets = list(/obj/item/vamp/keys/npc,
					/obj/item/stack/dollar/fifty,
					/obj/item/stack/dollar/hundred)

	male_phrases = list("Что тебе нужно, дружище?",
											"Я не понимаю, что вам от меня нужно?",
											"Вы что-то хотели?",
											"Я спешу, не задерживайте меня пожалуйста.",
											"Сходи поищи себе компанию в баре...",
											"Не могу говорить сейчас.",
											"Хорошая ночь, правда?",
											"Эхх...",
											"Даже не знаю, что сказать.",
											"У меня всё.")
	neutral_phrases = list("Что тебе нужно, дружище?",
												"Я не понимаю, что вам от меня нужно?",
												"Вы что-то хотели?",
												"Я спешу, не задерживайте меня пожалуйста.",
												"Сходи поищи себе компанию в баре...",
												"Не могу говорить сейчас.",
												"Хорошая ночь, правда?",
												"Эхх...",
												"Даже не знаю, что сказать.",
												"У меня всё.")
	random_phrases = list("Хэй, приятель!",
												"Эхх, сейчас бы пинту пива...",
												"В чём дело, друг?",
												"Хочу поприветствоваться.",
												"Ого, а мы встречались раньше?",
												"Слышали? Что-то неладное творится в городе.",
												"Оо-о, чувак...")
	answer_phrases = list("Стараюсь...",
												"Неописуемо.",
												"Плохо, друг.",
												"Вы кажется перепутали меня с кем-то.",
												"Да, точно.",
												"О'ке-ей...",
												"Хорошо.")
	help_phrases = list("О Боже!",
											"Уйдите, не подходите ко мне!!",
											"Что же это такое творится?!",
											"Прекратите!",
											"Кто-нибудь, помогите!",
											"Мамочка!")

/datum/socialrole/richfemale
	s_tones = list("albino")

	min_age = 18
	max_age = 85
	preferedgender = FEMALE
	female_names = null
	surnames = null

	hair_colors = list("040404",	//Black
										"120b05",	//Dark Brown
										"342414",	//Brown
										"554433",	//Light Brown
										"695c3b",	//Dark Blond
										"ad924e",	//Blond
										"dac07f",	//Light Blond
										"802400",	//Ginger
										"a5380e",	//Ginger alt
										"ffeace",	//Albino
										"650b0b",	//Punk Red
										"14350e",	//Punk Green
										"080918")	//Punk Blue
	female_hair = list("Ahoge",
										"Bob Hair",
										"Bob Hair 2",
										"Bob Hair 3",
										"Bob Hair 4",
										"Bobcurl",
										"Braided",
										"Braided Front",
										"Braid (Short)",
										"Braid (Low)",
										"Bun Head",
										"Bun Head 2",
										"Bun Head 3",
										"Bun (Large)",
										"Bun (Tight)",
										"Gentle",
										"Long Hair 1",
										"Long Hair 2",
										"Long Hair 3",
										"Short Hair Rosa",
										"Shoulder-length Hair",
										"Volaju")

	shoes = list(/obj/item/clothing/shoes/vampire/heels,
								/obj/item/clothing/shoes/vampire/heels/red)
	uniforms = list(/obj/item/clothing/under/vampire/business)
	pockets = list(/obj/item/vamp/keys/npc,
					/obj/item/stack/dollar/fifty,
					/obj/item/stack/dollar/hundred)

	female_phrases = list("Что вы задумали?",
											"Я не понимаю, что вам от меня нужно?",
											"Вы что-то хотели?",
											"Я спешу, не задерживайте меня пожалуйста.",
											"Поищите какую-нибудь другую подружку...",
											"Не могу говорить сейчас.",
											"Хорошая ночь, правда?",
											"Эхх...",
											"Даже не знаю, что сказать.",
											"У меня всё.")
	neutral_phrases = list("Что вы задумали?",
												"Я не понимаю, что вам от меня нужно?",
												"Вы что-то хотели?",
												"Я спешу, не задерживайте меня пожалуйста.",
												"Поищите какую-нибудь другую подружку...",
												"Не могу говорить сейчас.",
												"Хорошая ночь, правда?",
												"Эхх...",
												"Даже не знаю, что сказать.",
												"У меня всё.")
	random_phrases = list("Хэй, пышка!",
												"Эхх, сейчас бы вина...",
												"В чём дело?",
												"Приветики.",
												"Ого, а мы встречались раньше?",
												"Слышали? Что-то неладное творится в городе.",
												"Оо-о, ничего себе...")
	answer_phrases = list("Стараюсь...",
												"Неописуемо.",
												"Плохо, пупсик.",
												"Вы кажется перепутали меня с кем-то.",
												"Да, точно.",
												"О'ке-ей...",
												"Хорошо.")
	help_phrases = list("О Боже!",
											"Уйдите, не подходите ко мне!!",
											"Что же это такое творится?!",
											"Прекратите!",
											"Кто-нибудь, помогите!",
											"На помощь!")

/mob/living/carbon/human/npc/bandit
	frakcja = "City"

/mob/living/carbon/human/npc/bandit/Initialize()
	..()
	if(prob(33))
		my_weapon = new /obj/item/gun/ballistic/automatic/vampire/deagle(src)
	else
		if(prob(50))
			my_weapon = new /obj/item/melee/vampirearms/baseball(src)
		else
			my_weapon = new /obj/item/melee/vampirearms/knife(src)
	AssignSocialRole(/datum/socialrole/bandit)

/mob/living/carbon/human/npc/walkby
	frakcja = "City"

/mob/living/carbon/human/npc/walkby/Initialize()
	..()
	AssignSocialRole(pick(/datum/socialrole/usualmale, /datum/socialrole/usualfemale))

/mob/living/carbon/human/npc/hobo
	frakcja = "City"
	bloodquality = BLOOD_QUALITY_LOW

/mob/living/carbon/human/npc/hobo/Initialize()
	..()
	AssignSocialRole(pick(/datum/socialrole/poormale, /datum/socialrole/poorfemale))

/mob/living/carbon/human/npc/business
	frakcja = "City"
	bloodquality = BLOOD_QUALITY_HIGH

/mob/living/carbon/human/npc/business/Initialize()
	..()
	AssignSocialRole(pick(/datum/socialrole/richmale, /datum/socialrole/richfemale))

/mob/living/simple_animal/pet/rat
	name = "rat"
	desc = "It's a rat."
	icon = 'code/modules/ziggers/icons.dmi'
	icon_state = "rat"
	icon_living = "rat"
	icon_dead = "rat_dead"
	emote_hear = list("squeeks.")
	emote_see = list("shakes its head.", "shivers.")
	speak_chance = 0
	turns_per_move = 5
	see_in_dark = 6
	butcher_results = list(/obj/item/food/meat/slab = 1)
	response_help_continuous = "pets"
	response_help_simple = "pet"
	response_disarm_continuous = "gently pushes aside"
	response_disarm_simple = "gently push aside"
	response_harm_continuous = "kicks"
	response_harm_simple = "kick"
	can_be_held = FALSE
	density = FALSE
	anchored = FALSE
	footstep_type = FOOTSTEP_MOB_CLAW
	bloodquality = BLOOD_QUALITY_LOW
	bloodpool = 1
	maxbloodpool = 1
	del_on_death = 1
	maxHealth = 5
	health = 5

/mob/living/simple_animal/pet/rat/Life()
	. = ..()
	var/delete_me = TRUE
	for(var/mob/living/carbon/human/H in viewers(5, src))
		if(H)
			delete_me = FALSE
	if(delete_me)
		death()
		return

/datum/socialrole/shop
	s_tones = list("albino",
								"caucasian1",
								"caucasian2",
								"caucasian3")

	min_age = 18
	max_age = 45
	preferedgender = MALE
	male_names = null
	surnames = null

	hair_colors = list("040404",	//Black
										"120b05",	//Dark Brown
										"342414",	//Brown
										"554433",	//Light Brown
										"695c3b",	//Dark Blond
										"ad924e",	//Blond
										"dac07f",	//Light Blond
										"802400",	//Ginger
										"a5380e",	//Ginger alt
										"ffeace",	//Albino
										"650b0b",	//Punk Red
										"14350e",	//Punk Green
										"080918")	//Punk Blue
	male_hair = list("Balding Hair",
										"Bedhead",
										"Bedhead 2",
										"Bedhead 3",
										"Boddicker",
										"Business Hair",
										"Business Hair 2",
										"Business Hair 3",
										"Business Hair 4",
										"Coffee House",
										"Combover",
										"Crewcut",
										"Father",
										"Flat Top",
										"Gelled Back",
										"Joestar",
										"Keanu Hair",
										"Oxton",
										"Volaju")
	male_facial = list("Beard (Abraham Lincoln)",
											"Beard (Chinstrap)",
											"Beard (Full)",
											"Beard (Cropped Fullbeard)",
											"Beard (Hipster)",
											"Beard (Neckbeard)",
											"Beard (Three o Clock Shadow)",
											"Beard (Five o Clock Shadow)",
											"Beard (Seven o Clock Shadow)",
											"Moustache (Hulk Hogan)",
											"Moustache (Watson)",
											"Sideburns (Elvis)",
											"Sideburns",
											"Shaved")

	shoes = list(/obj/item/clothing/shoes/vampire/sneakers,
								/obj/item/clothing/shoes/vampire,
								/obj/item/clothing/shoes/vampire/brown)
	uniforms = list(/obj/item/clothing/under/vampire/mechanic)
	pockets = list(/obj/item/vamp/keys/npc,
					/obj/item/stack/dollar/rand)

	male_phrases = list("Вы что-то хотите приобрести?",
											"Я могу чем-нибудь помочь?",
											"Вы что-то хотели?")
	neutral_phrases = list("Вы что-то хотите приобрести?",
											"Я могу чем-нибудь помочь?",
											"Вы что-то хотели?")
	random_phrases = list("Вам стоит взглянуть, сегодня у нас скидки!",
												"Вы что-то хотите приобрести?",
												"Я могу чем-нибудь помочь?",
												"Вы что-то хотели?")
	answer_phrases = list("Я просто здесь работаю...")
	help_phrases = list("О Боже!",
											"Уйдите, не подходите ко мне!!",
											"Что же это такое творится?!",
											"Прекратите!",
											"Кто-нибудь, помогите!",
											"Мамочка!")

/mob/living/carbon/human/npc/shop
	frakcja = "City"
	staying = TRUE

/mob/living/carbon/human/npc/shop/Initialize()
	..()
	AssignSocialRole(/datum/socialrole/shop)

/datum/socialrole/shop/bacotell
	uniforms = list(/obj/item/clothing/under/vampire/bacotell)

/mob/living/carbon/human/npc/bacotell
	frakcja = "City"
	staying = TRUE

/mob/living/carbon/human/npc/bacotell/Initialize()
	..()
	AssignSocialRole(/datum/socialrole/shop/bacotell)

/datum/socialrole/shop/bubway
	uniforms = list(/obj/item/clothing/under/vampire/bubway)

/mob/living/carbon/human/npc/bubway
	frakcja = "City"
	staying = TRUE

/mob/living/carbon/human/npc/bubway/Initialize()
	..()
	AssignSocialRole(/datum/socialrole/shop/bubway)

/datum/socialrole/shop/gummaguts
	uniforms = list(/obj/item/clothing/under/vampire/gummaguts)

/mob/living/carbon/human/npc/gummaguts
	frakcja = "City"
	staying = TRUE

/mob/living/carbon/human/npc/gummaguts/Initialize()
	..()
	AssignSocialRole(/datum/socialrole/shop/gummaguts)

/datum/socialrole/police
	s_tones = list("albino",
								"caucasian1",
								"caucasian2",
								"caucasian3")

	min_age = 18
	max_age = 45
	preferedgender = MALE
	male_names = null
	surnames = null

	hair_colors = list("040404",	//Black
										"120b05",	//Dark Brown
										"342414",	//Brown
										"554433",	//Light Brown
										"695c3b",	//Dark Blond
										"ad924e",	//Blond
										"dac07f",	//Light Blond
										"802400",	//Ginger
										"a5380e",	//Ginger alt
										"ffeace",	//Albino
										"650b0b",	//Punk Red
										"14350e",	//Punk Green
										"080918")	//Punk Blue
	male_hair = list("Balding Hair",
										"Bedhead",
										"Bedhead 2",
										"Bedhead 3",
										"Boddicker",
										"Business Hair",
										"Business Hair 2",
										"Business Hair 3",
										"Business Hair 4",
										"Coffee House",
										"Combover",
										"Crewcut",
										"Father",
										"Flat Top",
										"Gelled Back",
										"Joestar",
										"Keanu Hair",
										"Oxton",
										"Volaju")
	male_facial = list("Beard (Abraham Lincoln)",
											"Beard (Chinstrap)",
											"Beard (Full)",
											"Beard (Cropped Fullbeard)",
											"Beard (Hipster)",
											"Beard (Neckbeard)",
											"Beard (Three o Clock Shadow)",
											"Beard (Five o Clock Shadow)",
											"Beard (Seven o Clock Shadow)",
											"Moustache (Hulk Hogan)",
											"Moustache (Watson)",
											"Sideburns (Elvis)",
											"Sideburns",
											"Shaved")

	shoes = list(/obj/item/clothing/shoes/vampire/jackboots)
	uniforms = list(/obj/item/clothing/under/vampire/police)
	hats = list(/obj/item/clothing/head/vampire/police)
	suits = list(/obj/item/clothing/suit/vampire/vest)
	pockets = list(/obj/item/vamp/keys/police,
					/obj/item/stack/dollar/rand)

	male_phrases = list("Я слежу за каждым твоим шагом.",
											"Выглядишь подозрительно...",
											"У меня есть пара лишних патрон, если хочешь податься в криминал.",
											"Я здесь на службе у закона.")
	neutral_phrases = list("Я слежу за каждым твоим шагом.",
											"Выглядишь подозрительно...",
											"У меня есть пара лишних патрон, если хочешь податься в криминал.",
											"Я здесь на службе у закона.",
											"Не мешайте работе полиции.")
	random_phrases = list("Не видели подозрительного брюнета в чёрном плаще и бледной кожей?",
												"Подозрительно тихо здесь...",
												"Хм?")
	answer_phrases = list("Я всегда готов защитить невиновных.")
	help_phrases = list("Руки за голову!",
											"Стоять не двигаться!!",
											"Брось оружие!",
											"Приказываю немедленно остановиться!!",
											"Это полиция, выходите с поднятыми руками!")

/mob/living/carbon/human/npc/police
	frakcja = "Police"
	fights_anyway = TRUE

/mob/living/carbon/human/npc/police/Initialize()
	..()
	my_weapon = new /obj/item/gun/ballistic/automatic/vampire/deagle(src)
	AssignSocialRole(/datum/socialrole/police)

/datum/socialrole/guard
	s_tones = list("albino",
								"caucasian1",
								"caucasian2",
								"caucasian3")

	min_age = 18
	max_age = 85
	preferedgender = MALE
	male_names = null
	surnames = null

	hair_colors = list("040404",	//Black
										"120b05",	//Dark Brown
										"342414",	//Brown
										"554433",	//Light Brown
										"695c3b",	//Dark Blond
										"ad924e",	//Blond
										"dac07f",	//Light Blond
										"802400",	//Ginger
										"a5380e",	//Ginger alt
										"ffeace",	//Albino
										"650b0b",	//Punk Red
										"14350e",	//Punk Green
										"080918")	//Punk Blue
	male_hair = list("Balding Hair",
										"Bedhead",
										"Bedhead 2",
										"Bedhead 3",
										"Boddicker",
										"Business Hair",
										"Business Hair 2",
										"Business Hair 3",
										"Business Hair 4",
										"Coffee House",
										"Combover",
										"Crewcut",
										"Father",
										"Flat Top",
										"Gelled Back",
										"Joestar",
										"Keanu Hair",
										"Oxton",
										"Volaju")
	male_facial = list("Beard (Abraham Lincoln)",
											"Beard (Chinstrap)",
											"Beard (Full)",
											"Beard (Cropped Fullbeard)",
											"Beard (Hipster)",
											"Beard (Neckbeard)",
											"Beard (Three o Clock Shadow)",
											"Beard (Five o Clock Shadow)",
											"Beard (Seven o Clock Shadow)",
											"Moustache (Hulk Hogan)",
											"Moustache (Watson)",
											"Sideburns (Elvis)",
											"Sideburns",
											"Shaved")

	shoes = list(/obj/item/clothing/shoes/vampire)
	uniforms = list(/obj/item/clothing/under/vampire/guard)
	pockets = list(/obj/item/vamp/keys/npc,
					/obj/item/stack/dollar/rand)

	male_phrases = list("Я слежу за каждым твоим шагом.",
											"Выглядишь подозрительно...",
											"У меня есть пара лишних патрон, если хочешь податься в криминал.",
											"Я здесь на службе у закона.")
	neutral_phrases = list("Я слежу за каждым твоим шагом.",
											"Выглядишь подозрительно...",
											"У меня есть пара лишних патрон, если хочешь податься в криминал.",
											"Я здесь на службе у закона.",
											"Не мешайте работе полиции.")
	random_phrases = list("Не видели подозрительного брюнета в чёрном плаще и бледной кожей?",
												"Подозрительно тихо здесь...",
												"Хм?")
	answer_phrases = list("Я всегда готов защитить невиновных.")
	help_phrases = list("Руки за голову!",
											"Стоять не двигаться!!",
											"Брось оружие!",
											"Приказываю немедленно остановиться!!",
											"Это полиция, выходите с поднятыми руками!")

/mob/living/carbon/human/npc/guard
	frakcja = "City"
	staying = TRUE
	fights_anyway = TRUE

/mob/living/carbon/human/npc/guard/Initialize()
	..()
	my_weapon = new /obj/item/gun/ballistic/automatic/vampire/deagle(src)
	AssignSocialRole(/datum/socialrole/guard)

/mob/living/carbon/human/npc/walkby/club/Life()
	. = ..()
	if(staying && stat < 2)
		if(prob(5))
			var/hasjukebox = FALSE
			for(var/obj/machinery/jukebox/J in range(7, src))
				if(J)
					hasjukebox = TRUE
					if(J.active)
						if(prob(50))
							dancefirst(src)
						else
							dancesecond(src)
			if(!hasjukebox)
				staying = FALSE

/mob/living/carbon/human/npc/walkby/club
	frakcja = "City"
	staying = TRUE

/datum/socialrole/stripfemale
	s_tones = list("albino",
								"caucasian1",
								"caucasian2",
								"caucasian3")

	min_age = 18
	max_age = 30
	preferedgender = FEMALE
	female_names = null
	surnames = null

	hair_colors = list("040404",	//Black
										"120b05",	//Dark Brown
										"342414",	//Brown
										"554433",	//Light Brown
										"695c3b",	//Dark Blond
										"ad924e",	//Blond
										"dac07f",	//Light Blond
										"802400",	//Ginger
										"a5380e",	//Ginger alt
										"ffeace",	//Albino
										"650b0b",	//Punk Red
										"14350e",	//Punk Green
										"080918")	//Punk Blue
	female_hair = list("Ahoge",
										"Long Bedhead",
										"Beehive",
										"Beehive 2",
										"Bob Hair",
										"Bob Hair 2",
										"Bob Hair 3",
										"Bob Hair 4",
										"Bobcurl",
										"Braided",
										"Braided Front",
										"Braid (Short)",
										"Braid (Low)",
										"Bun Head",
										"Bun Head 2",
										"Bun Head 3",
										"Bun (Large)",
										"Bun (Tight)",
										"Double Bun",
										"Emo",
										"Emo Fringe",
										"Feather",
										"Gentle",
										"Long Hair 1",
										"Long Hair 2",
										"Long Hair 3",
										"Long Over Eye",
										"Long Emo",
										"Long Fringe",
										"Ponytail",
										"Ponytail 2",
										"Ponytail 3",
										"Ponytail 4",
										"Ponytail 5",
										"Ponytail 6",
										"Ponytail 7",
										"Ponytail (High)",
										"Ponytail (Short)",
										"Ponytail (Long)",
										"Ponytail (Country)",
										"Ponytail (Fringe)",
										"Poofy",
										"Short Hair Rosa",
										"Shoulder-length Hair",
										"Volaju")

	shoes = list(/obj/item/clothing/shoes/vampire/heels)
	uniforms = list(/obj/item/clothing/under/vampire/whore)
	backpacks = list()

	female_phrases = list("Хочешь поглазеть, пупсик?",
											"Мм, тебе нравятся эти формы?",
											"Хочешь поиграть со мной?",
											"Хи-хи.",
											"Для тебя любой танец...",
											"Присаживайся, отдохни.",
											"Ты такое любишь?",
											"Ахх...")
	neutral_phrases = list("Хочешь поглазеть, пупсик?",
											"Мм, тебе нравятся эти формы?",
											"Хочешь поиграть со мной?",
											"Хи-хи.",
											"Для тебя любой танец...",
											"Присаживайся, отдохни.",
											"Ты такое любишь?",
											"Ахх...")
	random_phrases = list("Хочешь поглазеть, пупсик?",
											"Мм, тебе нравятся эти формы?",
											"Хочешь поиграть со мной?",
											"Хи-хи.",
											"Для тебя любой танец...",
											"Присаживайся, отдохни.",
											"Ты такое любишь?",
											"Ахх...")
	answer_phrases = list("Это будет стоить...",
												"Хи-хи-хи.",
												"Двадцать баксов.",
												"Без проблем, пупсик...")
	help_phrases = list("О Боже!",
											"Уйдите, не подходите ко мне!!",
											"Что же это такое творится?!",
											"Прекратите!",
											"Кто-нибудь, помогите!",
											"На помощь!")

/mob/living/carbon/human/npc/stripper
	frakcja = "City"
	staying = TRUE

/mob/living/carbon/human/npc/stripper/Initialize()
	..()
	AssignSocialRole(/datum/socialrole/stripfemale)
	underwear = "Nude"
	undershirt = "Nude"
	socks = "Nude"
	update_body()

/mob/living/carbon/human/npc/stripper/Life()
	. = ..()
	if(stat < 2)
		if(prob(20))
			for(var/obj/structure/pole/P in range(1, src))
				if(P)
					drop_all_held_items()
					ClickOn(P)

/mob/living/carbon/human/npc/incel
	frakcja = "City"
	staying = TRUE

/mob/living/carbon/human/npc/incel/Initialize()
	..()
	AssignSocialRole(/datum/socialrole/usualmale)

/datum/socialrole/shop/illegal
	masks = list(/obj/item/clothing/mask/vampire/balaclava)
	shoes = list(/obj/item/clothing/shoes/vampire/sneakers)
	uniforms = list(/obj/item/clothing/under/vampire/emo)
	pockets = list(/obj/item/stack/dollar/rand)

	male_phrases = list("Псс... Покупай...",
											"Эй... Бродяга...",
											"Смотри на мой товар...")
	neutral_phrases = list("Псс... Покупай...",
											"Эй... Бродяга...",
											"Смотри на мой товар...")
	random_phrases = list("Псс... Покупай...",
											"Эй... Бродяга...",
											"Смотри на мой товар...")
	answer_phrases = list("Ничего личного...")
	help_phrases = list("Копы!",
											"Пошёл нахуй, это моя точка!!",
											"Легавые?!")

/mob/living/carbon/human/npc/illegal
	frakcja = "City"
	staying = TRUE

/mob/living/carbon/human/npc/illegal/Initialize()
	..()
	AssignSocialRole(/datum/socialrole/shop/illegal)