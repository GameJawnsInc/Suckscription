class_name ProgressSystem extends Node2D


var current_day: int
var day_time: float


func _init() -> void:
	ProgressGlob.progress_system = self


func set_to_new_game() -> void:
	current_day = 1
	day_time = 0
