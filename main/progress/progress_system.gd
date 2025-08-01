class_name ProgressSystem extends Node2D


var current_day: int = 1


func _init() -> void:
	ProgressGlob.progress_system = self
