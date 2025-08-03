class_name OnOffUiIndicator extends Control

const ActiveScale = Vector2(1.0, 1.0)
const InactiveScale = Vector2(0.7, 0.7)
const TweenTime = 0.32

const ActiveColor = Color.SPRING_GREEN
const InactiveColor = Color.DARK_RED

@export var is_active: bool = false :
	set(val):
		if val == is_active:
			return
		is_active = val
		set_modulation()

func _ready() -> void:
	set_modulation(true)

func set_modulation(first_run: bool = false) -> void:
	modulate = ActiveColor if is_active else InactiveColor
	var end_scale := ActiveScale if is_active else InactiveScale
	if first_run:
		scale = end_scale
	else:
		var t_1 := create_tween()
		t_1.tween_property(self, "scale", end_scale, TweenTime)
