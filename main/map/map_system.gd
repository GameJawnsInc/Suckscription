class_name MapSystem extends Node2D


signal day_started
signal day_ended

func load_overworld() -> void:
	var inst := MapGlob.get_overworld_inst()
	add_child(inst)
	Glob.main.player_system.player_inst_created.connect(inst.add_player)
	Glob.main.player_system.player_destination_reached.connect(inst.player_reached_point)
	await inst.day_started
	day_started.emit()
	await inst.map_completed
	day_ended.emit()

func player_destination_reached() -> void:
	pass
