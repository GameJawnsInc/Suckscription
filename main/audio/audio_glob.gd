extends Node


var bgm_player := AudioStreamPlayer.new()

func _ready() -> void:
	bgm_player.stream = preload("res://assets/music/monster_jazz_remix.wav")
	add_child(bgm_player)
	bgm_player.play()

func switch() -> void:
	bgm_player.stream = preload("res://assets/music/vamp_blinks.wav")
	bgm_player.play()
