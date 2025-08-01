class_name MapSystem extends Node2D


func load_overworld() -> void:
	var inst := MapGlob.get_overworld_inst()
	add_child(inst)
