extends Node


const HeadquartersScene = preload("headquarters.tscn")

func get_hq_scene() -> Headquarters:
	return HeadquartersScene.instantiate()
