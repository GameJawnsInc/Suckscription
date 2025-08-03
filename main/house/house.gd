class_name House extends Resource


var house_id: int
var display_name: String

var priority: int
var trait_id: HouseGlob.Trait

var relationship: int  = 0

func _init(house_id_: int, display_name_: String) -> void:
	house_id = house_id_
	priority = house_id_
	display_name = display_name_
	trait_id = house_id as HouseGlob.Trait
	
