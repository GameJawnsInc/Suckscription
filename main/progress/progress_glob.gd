extends Node


const DayLength = 20.0

const ClockScene = preload("clock.tscn")

@export var progress_system: ProgressSystem


func get_current_day() -> int:
	return progress_system.current_day


func get_clock_inst() -> Clock:
	return ClockScene.instantiate()
