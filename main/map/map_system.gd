class_name MapSystem extends Node2D


signal day_started
signal day_ended


var current_overworld: Overworld

func load_overworld() -> void:
	current_overworld = MapGlob.get_overworld_inst()
	add_child(current_overworld)
	Glob.main.player_system.player_inst_created.connect(current_overworld.add_player)
	Glob.main.player_system.player_destination_reached.connect(current_overworld.player_reached_point)
	current_overworld.conversation_started.connect(Glob.main.progress_system.pause_timer)
	current_overworld.conversation_ended.connect(Glob.main.progress_system.resume_timer)
	await current_overworld.start_day_requested
	day_started.emit()
	await current_overworld.map_completed
	day_ended.emit()

func player_destination_reached() -> void:
	pass
