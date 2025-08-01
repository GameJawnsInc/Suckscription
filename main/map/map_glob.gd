extends Node


const OverworldScene = preload("overworld/overworld.tscn")
const OverworldHouseScene = preload("overworld/house.tscn")

func get_overworld_inst() -> Overworld:
	return OverworldScene.instantiate()


func get_house_inst(house_id: int) -> OverworldHouse:
	var inst := OverworldHouseScene.instantiate()
	inst.house_id = house_id
	return inst
