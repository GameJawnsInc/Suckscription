extends Node


enum Product{SUCK_O_MATIC_PRO, GLOWWAND_HOME_AURA_FILTER, VITAVIAL_POWER_SHOTS,
DORMADOME_SLEEP_HELMET, HUNGRYHEART_SMART_BLENDER, BITECOIN_SPACE_HEATER_MINER}

const Taglines: Dictionary[Product, Dictionary] = {
	Product.SUCK_O_MATIC_PRO : {
		HouseGlob.Approach.ETHOS : "This is the unit our founder uses to clean his personal crypt. FDA certified for blood, dust, and loose soul particles.",
		HouseGlob.Approach.LOGOS : "We did the math. 62 percent less clogging, 18 percent more suction, and zero filters you’ll actually remember to replace.",
		HouseGlob.Approach.PATHOS : "Imagine walking barefoot into a clean, aura-safe space. No clutter, no noise, just a low hum... like your life used to have.",
	},
	Product.GLOWWAND_HOME_AURA_FILTER : {
		HouseGlob.Approach.ETHOS : "Our lead scientist studied under the Dalai Lama’s fourth chiropractor. This tech isn’t new; it’s rediscovered.",
		HouseGlob.Approach.LOGOS : "Independently tested to neutralize 98.7 percent of ambient psychic interference. Even works through drywall.",
		HouseGlob.Approach.PATHOS : "It doesn’t just clean air. It makes you feel seen by your own breath. Isn’t that what we all want?",
	},
	Product.VITAVIAL_POWER_SHOTS : {
		HouseGlob.Approach.ETHOS : "Backed by five Olympic alternates and one guy who swears he punched a ghost. You’ll feel it.",
		HouseGlob.Approach.LOGOS : "Each vial contains the daily recommended dose of grindset. Plus caffeine. And... possibly cinnamon?",
		HouseGlob.Approach.PATHOS : "This isn’t a supplement. It’s a wake-up call in liquid form. To your goals. To your soul.",
	},
	Product.DORMADOME_SLEEP_HELMET : {
		HouseGlob.Approach.ETHOS : "Developed in partnership with a sleep monastery. Their slogan? ‘Dream hard or die broke.",
		HouseGlob.Approach.LOGOS : "Lowered cortisol, deeper REM, and it plays affirmations while you drool. Nighttime productivity just dropped.",
		HouseGlob.Approach.PATHOS : "Imagine finally waking up rested... like your dreams want you to succeed.",
	},
	Product.HUNGRYHEART_SMART_BLENDER : {
		HouseGlob.Approach.ETHOS : "Used in three vampire hospitals and one performance gym where the walls bleed sponsorships.",
		HouseGlob.Approach.LOGOS : "Self-cleans. Tracks macros. Sends blend analytics straight to your personal data crypt.",
		HouseGlob.Approach.PATHOS : "It doesn’t just make smoothies. It makes decisions for the you who still believes in trying.",
	},
	Product.BITECOIN_SPACE_HEATER_MINER : {
		HouseGlob.Approach.ETHOS : "This is bleeding-edge tech. It mines two chains, crypto and clout. VCs love it.",
		HouseGlob.Approach.LOGOS : "Generates passive income and passive heat. One unit paid for itself in 46 years.",
		HouseGlob.Approach.PATHOS : "There’s a warmth money can’t buy. This isn’t that. But it feels close.",
	},
}

const Reactions: Dictionary[Product, Dictionary] = {
	Product.SUCK_O_MATIC_PRO : {
		"love" : [HouseGlob.Trait.SUBURBAN_DAD, HouseGlob.Trait.HOA_NARC],
		"hate" : [HouseGlob.Trait.CRYSTAL_MOMMY, HouseGlob.Trait.OLD_WORLD],
	},
	Product.GLOWWAND_HOME_AURA_FILTER : {
		"love" : [HouseGlob.Trait.CRYSTAL_MOMMY, HouseGlob.Trait.CONSPIRACY_PILLED],
		"hate" : [HouseGlob.Trait.SUBURBAN_DAD, HouseGlob.Trait.HOA_NARC],
	},
	Product.VITAVIAL_POWER_SHOTS : {
		"love" : [HouseGlob.Trait.GYM_FREAK, HouseGlob.Trait.CLOUT_CHASER],
		"hate" : [HouseGlob.Trait.OLD_WORLD, HouseGlob.Trait.DOOMER_TEEN],
	},
	Product.DORMADOME_SLEEP_HELMET : {
		"love" : [HouseGlob.Trait.DOOMER_TEEN, HouseGlob.Trait.OLD_WORLD],
		"hate" : [HouseGlob.Trait.GYM_FREAK, HouseGlob.Trait.CRYSTAL_MOMMY],
	},
	Product.HUNGRYHEART_SMART_BLENDER : {
		"love" : [HouseGlob.Trait.SUBURBAN_DAD, HouseGlob.Trait.GYM_FREAK],
		"hate" : [HouseGlob.Trait.CONSPIRACY_PILLED, HouseGlob.Trait.OLD_WORLD],
	},
	Product.BITECOIN_SPACE_HEATER_MINER : {
		"love" : [HouseGlob.Trait.CLOUT_CHASER, HouseGlob.Trait.CONSPIRACY_PILLED],
		"hate" : [HouseGlob.Trait.HOA_NARC, HouseGlob.Trait.DOOMER_TEEN],
	},
}

func get_product_name(product_id: Product) -> String:
	return Product.keys()[product_id].capitalize()


func get_inventory_slot(index: int) -> Product:
	return Glob.main.product_system.get_inventory_slot(index)


func is_product_in_stock(product_id: Product) -> bool:
	return Glob.main.product_system.is_product_in_stock(product_id)

func get_tagline(product_id: Product, approach_id: HouseGlob.Approach) -> String:
	return Taglines[product_id][approach_id]

func get_love_hate_boost(product_id: Product, trait_id: HouseGlob.Trait) -> int:
	var result: int = 0
	if Reactions[product_id]["love"].has(trait_id):
		result += 1
	if Reactions[product_id]["hate"].has(trait_id):
		result -= 1
	return result
