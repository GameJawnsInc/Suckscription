class_name Main extends Node2D


enum GameState{TITLE, HQ, OVERWORLD, ROUTE, VISIT, REPORT}

@export var map_system: MapSystem
@export var progress_system: ProgressSystem

var game_state: GameState = GameState.TITLE

func _ready() -> void:
	show_title_screen()


func show_title_screen() -> void:
	var title := MenuGlob.TitleScreenScene.instantiate()
	add_child(title)
	title.finished.connect(load_game)


func load_game() -> void:
	game_state = GameState.HQ
	
	map_system.load_overworld(progress_system.current_day)
