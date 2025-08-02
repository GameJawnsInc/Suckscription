extends Node


const PlayerScene = preload("player.tscn")

func get_player_inst() -> PlayerBody:
	return PlayerScene.instantiate()
