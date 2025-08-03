class_name HeadquartersSystem extends Node2D


signal headquarters_accepted

func begin_day() -> void:
	var hq_scene := HeadquartersGlob.get_hq_scene()
	add_child(hq_scene)
	hq_scene.completed.connect(hq_completed)
	hq_scene.game_ended.connect(end_game)

func end_game() -> void:
	Glob.main.progress_system.show_end_game()

func hq_completed(choices: Array[ProductsGlob.Product]) -> void:
	Glob.main.product_system.on_items_selected(choices)
	Glob.main.show_transition()
	await Glob.main.transition_shown
	headquarters_accepted.emit()

func set_to_new_game() -> void:
	pass
