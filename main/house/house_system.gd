class_name HouseSystem extends Node2D


var houses: Array[House]

func _init() -> void:
	HouseGlob.house_system = self


func set_to_new_game() -> void:
	var house_names := HouseGlob.populate_names_from_count()
	for house_index in HouseGlob.HouseCount:
		houses.push_back(House.new(house_index, house_names[house_index]))


func find_house_by_id(house_id: int) -> House:
	var house: House
	for house_curr in houses:
		if house_curr.house_id == house_id:
			house = house_curr
	assert(house)
	return house
