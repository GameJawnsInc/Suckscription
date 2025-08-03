class_name ProgressSystem extends Node2D


signal times_up

const EndScene = preload("end_scene.tscn")

var current_day: int
var day_time: float

var clock_inst: Clock

func _init() -> void:
	ProgressGlob.progress_system = self

func _ready() -> void:
	Glob.main.map_system.day_started.connect(count_down)

func set_to_new_game() -> void:
	current_day = 1
	day_time = 0

func count_down() -> void:
	clock_inst = ProgressGlob.get_clock_inst()
	add_child(clock_inst)
	clock_inst.times_up.connect(end_day)

func end_day() -> void:
	current_day += 1
	times_up.emit()

func pause_timer() -> void:
	clock_inst.pause_timer()

func resume_timer() -> void:
	clock_inst.resume_timer()

func show_end_game() -> void:
	add_child(EndScene.instantiate())
