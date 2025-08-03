@tool
class_name NinePatchButton extends Button

signal pressed_animation_finished

const HoverScale = Vector2(1.1, 1.1)
const PressedScale = Vector2(1.2, 1.2)
const TweenTime = 0.2

@export var disable_on_pressed: bool = true

@export var panel: NinePatchPanel

@export var color_choice: NinePatchPanel.ColorChoice :
	set(val):
		color_choice = val
		panel.color_choice = color_choice

var is_doing_pressed_animation: bool = false

func _on_mouse_entered() -> void:
	if is_doing_pressed_animation:
		return
	var t_1 := create_tween()
	t_1.set_ease(Tween.EASE_IN_OUT)
	t_1.set_trans(Tween.TRANS_CUBIC)
	t_1.tween_property(self, "scale", HoverScale, TweenTime)


func _on_mouse_exited() -> void:
	if is_doing_pressed_animation:
		return
	var t_1 := create_tween()
	t_1.set_ease(Tween.EASE_IN_OUT)
	t_1.set_trans(Tween.TRANS_CUBIC)
	t_1.tween_property(self, "scale", Vector2.ONE, TweenTime)


func _on_pressed() -> void:
	if disable_on_pressed:
		UiGlob.disable_button(self)
	z_index += 1
	is_doing_pressed_animation = true
	var t_1 := create_tween()
	t_1.set_ease(Tween.EASE_IN_OUT)
	t_1.set_trans(Tween.TRANS_CUBIC)
	t_1.tween_property(self, "scale", PressedScale, TweenTime)
	t_1.tween_property(self, "scale", Vector2.ONE, TweenTime)
	await t_1.finished
	z_index -= 1
	pressed_animation_finished.emit()
	is_doing_pressed_animation = false
