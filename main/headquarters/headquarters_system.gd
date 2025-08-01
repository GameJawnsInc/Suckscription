class_name HeadquartersSystem extends Node2D


var daily_vial_count: int
var daily_vacuum_count: int

func begin_day() -> void:
	print(ProgressGlob.get_current_day())


func set_to_new_game() -> void:
	daily_vial_count = 3
	daily_vacuum_count = 3
