class_name PlayerSystem extends Node2D


signal player_inst_created(inst)
signal player_destination_reached(inst)

var player_inst: PlayerBody

func _ready() -> void:
	Glob.main.map_system.day_started.connect(on_day_started)
	

func on_day_started() -> void:
	player_inst = PlayerGlob.get_player_inst()
	player_inst.navigator.follow_target_reached.connect(follow_target_reached)
	player_inst_created.emit(player_inst)
	
func follow_target_reached() -> void:
	player_destination_reached.emit(player_inst)
