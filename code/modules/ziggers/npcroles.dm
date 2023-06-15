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
	inhand_items = list(/obj/item/vamp/keys/npc)

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
	inhand_items = list(/obj/item/vamp/keys/npc)

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
	inhand_items = list(/obj/item/vamp/keys/npc, /obj/item/storage/briefcase)

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
	inhand_items = list(/obj/item/vamp/keys/npc)

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

/mob/living/carbon/human/npc/bandit/Initialize()
	..()
	AssignSocialRole(/datum/socialrole/bandit)

/mob/living/carbon/human/npc/walkby

/mob/living/carbon/human/npc/walkby/Initialize()
	..()
	AssignSocialRole(pick(/datum/socialrole/usualmale, /datum/socialrole/usualfemale))

/mob/living/carbon/human/npc/hobo
	bloodquality = BLOOD_QUALITY_LOW

/mob/living/carbon/human/npc/hobo/Initialize()
	..()
	AssignSocialRole(pick(/datum/socialrole/poormale, /datum/socialrole/poorfemale))

/mob/living/carbon/human/npc/business
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
	footstep_type = FOOTSTEP_MOB_CLAW
	bloodquality = BLOOD_QUALITY_LOW

/mob/living/simple_animal/pet/rat/Life()
	for(var/mob/living/carbon/human/H in range(7))
		if(!H)
			qdel(src)
			return
	..()

/mob/living/simple_animal/pet/rat/death()
	. = ..()
	qdel(src)
	return
