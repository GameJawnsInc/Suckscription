extends Node



@export var progress_system: ProgressSystem


func get_current_day() -> int:
	return progress_system.current_day
