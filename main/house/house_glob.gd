extends Node


signal priorities_updated

enum Trait{WEALTHY, TECH_BRO, SUBURBAN_MOM}
const HouseCount = 9
const HouseNames: Array[String] = ["Smythe", "Fenton", "Walden", "Forbes", "Ponson", "Stiles",
 "Vector", "Binary", "Decker", "Coding", "Gadget", "Gambit",
 "Miller", "Foster", "Parker", "Palmer", "Fowler", "Bailey"]

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
	var name_list := HouseNames.duplicate()
	for count in HouseCount:
		var index := randi_range(0, name_list.size() - 1)
		ret_arr.push_back(name_list[index])
		name_list.pop_at(index)
	return ret_arr

func sort_by_property(a: House, b: House, c: String) -> bool:
	if a.get(c) < b.get(c):
		return true
	return false

func set_priorities_updated() -> void:
	priorities_updated.emit()
