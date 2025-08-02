extends Control

signal animation_complete

func _ready() -> void:
	await Glob.new_timer_timeout(self, 3.0)
	animation_complete.emit()
