class_name PlayerNavigator extends NavigationAgent2D


signal follow_target_reached

var current_follow_target: Vector2

func _physics_process(delta: float) -> void:
	if current_follow_target != Vector2.ZERO:
		target_position = current_follow_target
		get_next_path_position()
		if !is_navigation_finished():
			var unnormal: Vector2 = get_next_path_position() - get_parent().global_position
			get_parent().move_direction = unnormal.normalized()
		else:
			current_follow_target = Vector2.ZERO
			get_parent().velocity /= 100.0
			await Glob.new_timer_timeout(self, 0.5)
			if !get_parent().is_movement_disabled:
				follow_target_reached.emit()
