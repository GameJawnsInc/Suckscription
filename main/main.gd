class_name Main extends Node2D


signal transition_shown

@export var headquarters_system: HeadquartersSystem
@export var progress_system: ProgressSystem
@export var map_system: MapSystem
@export var house_system: HouseSystem
@export var player_system: PlayerSystem


@onready var transition: ColorRect = %Transition

func _ready() -> void:
	transition.visible = false
	show_title_screen()


func show_title_screen() -> void:
	var title := MenuGlob.TitleScreenScene.instantiate()
	add_child(title)
	title.finished.connect(new_game)


func new_game() -> void:
	progress_system.set_to_new_game()
	headquarters_system.set_to_new_game()
	house_system.set_to_new_game()
	do_game_loop()

func do_game_loop() -> void:
	headquarters_system.begin_day()
	await headquarters_system.headquarters_accepted
	map_system.load_overworld()
	await map_system.day_ended
	do_game_loop()

func show_transition() -> void:
	transition.visible = true
	transition.modulate = Color(0, 0, 0, 0)
	var t_1 := create_tween()
	t_1.set_trans(Tween.TRANS_QUAD)
	t_1.set_ease(Tween.EASE_IN_OUT)
	t_1.tween_property(transition, "modulate", Color(0, 0, 0, 1), 0.3)
	await t_1.finished
	transition_shown.emit()
	var t_2 := create_tween()
	t_2.set_trans(Tween.TRANS_QUAD)
	t_2.set_ease(Tween.EASE_IN_OUT)
	t_2.tween_property(transition, "modulate", Color(0, 0, 0, 0), 0.3)
	await t_2.finished
	transition.visible = false
