extends Node


signal priorities_updated

enum Trait{CONSPIRACY_PILLED, SUBURBAN_DAD, CLOUT_CHASER,
OLD_WORLD, GYM_FREAK, CRYSTAL_MOMMY,
HOA_NARC, DOOMER_TEEN}

enum Approach{ETHOS, LOGOS, PATHOS}

const ApproachMap: Dictionary[Trait, Array] = {
	Trait.CONSPIRACY_PILLED : [Approach.PATHOS, Approach.ETHOS, Approach.LOGOS],
	Trait.SUBURBAN_DAD : [Approach.LOGOS, Approach.ETHOS, Approach.PATHOS],
	Trait.CLOUT_CHASER : [Approach.ETHOS, Approach.PATHOS, Approach.LOGOS],
	Trait.OLD_WORLD : [Approach.ETHOS, Approach.LOGOS, Approach.PATHOS],
	Trait.GYM_FREAK : [Approach.LOGOS, Approach.PATHOS, Approach.ETHOS],
	Trait.CRYSTAL_MOMMY : [Approach.PATHOS, Approach.LOGOS, Approach.ETHOS],
	Trait.HOA_NARC : [Approach.LOGOS, Approach.ETHOS, Approach.PATHOS],
	Trait.DOOMER_TEEN : [Approach.PATHOS, Approach.LOGOS, Approach.ETHOS],
}

const ResponseMap: Dictionary[Trait, Dictionary] = {
	Trait.CONSPIRACY_PILLED : {
		"positive" : "Fine, I’ll wire the funds. But if this thing tracks me, we riot.",
		"neutral" : "Huh… I’ll run it past my bunker forum and ping you.",
		"negative" : "Nice try, Fed. I’m logging your shoe size.",
	},
	Trait.SUBURBAN_DAD : {
		"positive" : "Now that’s value. Let me grab the checkbook.",
		"neutral" : "Interesting gadget. I’ll compare prices after the game.",
		"negative" : "Smells like gimmick. Close my door, heat’s escaping.",
	},
	Trait.CLOUT_CHASER : {
		"positive" : "Love it. Sending an unboxing live in three… two…",
		"neutral" : "Maybe if you throw in a promo code with my name.",
		"negative" : "Ugh, this is brand poison. Take it off my porch.",
	},
	Trait.OLD_WORLD : {
		"positive" : "The family seal approves. Payment in coin, no receipts.",
		"neutral" : "Leave a sample by the gate. I will consult the ancestors.",
		"negative" : "These halls remember better lies. Begone.",
	},
	Trait.GYM_FREAK : {
		"positive" : "Sold. If it doesn’t pump me up, you’re spotting my squats.",
		"neutral" : "Stats look decent. DM me the macros and we’ll talk.",
		"negative" : "That’s cardio talk, loser. Slam the door on your way out.",
	},
	Trait.CRYSTAL_MOMMY : {
		"positive" : "Yes, yes, the vibes tingle. Charge it under the moon for me.",
		"neutral" : "My spirit guide is… undecided. Circle back after Mercury retrograde.",
		"negative" : "Your aura is crunchy. Leave before it flakes on my doorstep.",
	},
	Trait.HOA_NARC : {
		"positive" : "Approved. Submit the paperwork and curb-color sample by Friday.",
		"neutral" : "Regulations require a noise study first. Come prepared.",
		"negative" : "Violation. I’m reporting this interaction to the board.",
	},
	Trait.DOOMER_TEEN : {
		"positive" : "Whatever, take my allowance. At least I’ll feel something.",
		"neutral" : "Might be funny ironically. Let me think.",
		"negative" : "Cringe pitch, capitalist. Blocking you in real life.",
	},
}

const HouseCount = 8

var house_system: HouseSystem

func get_trait_name(trait_id: Trait) -> String:
	return Trait.keys()[trait_id].capitalize()

func find_house_by_id(house_id: int) -> House:
	return house_system.find_house_by_id(house_id)

func get_all_houses() -> Array[House]:
	return house_system.houses

func get_sorted_houses_by_property(property: String) -> Array[House]:
	var ret_arr := house_system.houses.duplicate()
	ret_arr.sort_custom(sort_by_property.bind(property))
	return ret_arr

func populate_names_from_count() -> Array[String]:
	var ret_arr: Array[String]
	var name_list := Trait.keys().duplicate()
	for count in HouseCount:
		ret_arr.push_back(name_list[count].capitalize())
	return ret_arr

func sort_by_property(a: House, b: House, c: String) -> bool:
	if a.get(c) < b.get(c):
		return true
	return false

func set_priorities_updated() -> void:
	priorities_updated.emit()

func get_approach_boost(trait_id: Trait, approach_id: Approach) -> int:
	var rating := ApproachMap[trait_id].find(approach_id)
	if rating == 0:
		return 1
	elif rating == 1:
		return 0
	else:
		return -1

func get_response(trait_id: Trait, response_type: String) -> String:
	return ResponseMap[trait_id][response_type]

func calculate_total_relationship() -> int:
	var rela: int = 0
	for house in get_all_houses():
		rela += house.relationship
	return rela
