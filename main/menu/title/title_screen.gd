class_name TitleScreen extends Control


signal finished

@export var buttons: Array[NinePatchButton]

@onready var new_game_button: NinePatchButton = %NewGameButton
@onready var quit_button: NinePatchButton = %QuitButton


func _on_new_game_button_pressed() -> void:
	disable_buttons()
	await new_game_button.pressed_animation_finished
	finished.emit()
	queue_free()


func _on_quit_button_pressed() -> void:
	disable_buttons()
	await quit_button.pressed_animation_finished
	if OS.get_name() in ["Windows", "macOS", "Linux"]:
		get_tree().quit()


func disable_buttons() -> void:
	for button in buttons:
		UiGlob.disable_button(button)
