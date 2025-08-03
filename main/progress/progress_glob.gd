extends Node


const DayLength = 22.5

const ClockScene = preload("clock.tscn")

@export var progress_system: ProgressSystem

var suspicion: int = 0

func get_current_day() -> int:
	return progress_system.current_day


func get_clock_inst() -> Clock:
	return ClockScene.instantiate()
