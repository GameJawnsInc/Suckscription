extends NavigationAgent2D


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("direction_move"):
		target_position = Glob.main.get_global_mouse_position()
		get_next_path_position()
	
	if !is_navigation_finished():
		var unnormal: Vector2 = get_next_path_position() - get_parent().global_position
		get_parent().move_direction = unnormal.normalized()
