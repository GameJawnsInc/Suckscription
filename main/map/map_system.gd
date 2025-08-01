class_name MapSystem extends Node2D


func load_overworld(current_day: int) -> void:
	var inst := MapGlob.get_overworld_inst()
	add_child(inst)
