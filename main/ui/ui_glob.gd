extends Node


func font_size_wrap(text: String, font_size: int) -> String:
	var opener := "[font_size='" + str(font_size) + "']"
	return opener + text + "[/font_size]"

func color_wrap(text: String, color_code: String) -> String:
	var opener := "[color='" + color_code + "']"
	opener += "[outline_color='" + color_code + "']"
	return opener + text + "[/outline_color]" + "[/color]"


func enable_button(button: Button, should_set_visibility: bool = false) -> void:
	button.disabled = false
	button.mouse_filter = button.MouseFilter.MOUSE_FILTER_STOP
	button.focus_mode = Control.FOCUS_ALL
	if should_set_visibility:
		button.visible = true

func disable_button(button: Button, should_set_visibility: bool = false) -> void:
	button.disabled = true
	button.mouse_filter = button.MouseFilter.MOUSE_FILTER_IGNORE
	button.focus_mode = Control.FOCUS_NONE
	if should_set_visibility:
		button.visible = false
