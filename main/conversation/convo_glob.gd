extends Node

const IntroLines: Dictionary[HouseGlob.Trait, Array] = {
	HouseGlob.Trait.CONSPIRACY_PILLED : [
		"You’re not with the census, are you?",
		"I got my own filtration system. Made it from spoons.",
		"Let me guess. Another psyop.",
	],
	HouseGlob.Trait.SUBURBAN_DAD : [
		"If this is about that damn thermostat, my wife already talked to you.",
		"You got a brochure? I love a good brochure.",
		"I just cleaned the gutters. What are you selling?",
	],
	HouseGlob.Trait.CLOUT_CHASER : [
		"Sorry, I was mid-reel. Make this quick or make it viral.",
		"Is that a branded polo? Ew. Or... wait, is that ironic?",
		"If this is one of those exclusive invite things, I’m in.",
	],
	HouseGlob.Trait.OLD_WORLD : [
		"My family has lived here since the first fog.",
		"You don’t look like a priest.",
		"The wards are not for sale.",
	],
	HouseGlob.Trait.GYM_FREAK : [
		"You got five seconds. My pre-workout’s kicking in.",
		"Is this about protein? Say less.",
		"Unless this builds muscle or burns fat, I’m not interested.",
	],
	HouseGlob.Trait.CRYSTAL_MOMMY : [
		"Ohhh, your aura’s spicy. I love that.",
		"Hang on, I need to bless the doormat.",
		"My chakras told me someone was coming.",
	],
	HouseGlob.Trait.HOA_NARC : [
		"Do you have a permit for that clipboard?",
		"You’re parked a little close to the curb.",
		"Soliciting is prohibited. Unless it’s tasteful.",
	],
	HouseGlob.Trait.DOOMER_TEEN : [
		"You a narc or a vampire? Doesn’t matter.",
		"My parents aren’t home. Neither am I, philosophically.",
		"Cool cape. You doing a bit?",
	],
 }

const ConvoScene = preload("conversation.tscn")

func start_conversation(house_id: int) -> Conversation:
	var inst := ConvoScene.instantiate()
	inst.house_id = house_id
	return inst
