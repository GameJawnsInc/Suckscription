extends Line2D


func _ready() -> void:
	var starting_mod := Color(1, 1, 1, 0.4)
	var ending_mod := Color(1, 1, 1, 0.7)
	self_modulate = starting_mod
	var t_1 := create_tween()
	t_1.tween_property(self, "self_modulate", ending_mod, 3)
	t_1.tween_property(self, "self_modulate", starting_mod, 3)
	t_1.set_loops()
