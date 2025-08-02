class_name HeadquartersSystem extends Node2D


signal headquarters_accepted

var daily_vial_count: int
var daily_vacuum_count: int

@onready var vampire_spine: Vampire = %VampireSpine
@onready var comply: NinePatchButton = %Comply
@onready var resist: NinePatchButton = %Resist
@onready var button_holder: HBoxContainer = %ButtonHolder

func _ready() -> void:
	vampire_spine.visible = false

func begin_day() -> void:
	print(ProgressGlob.get_current_day())
	vampire_spine.visible = true
	button_holder.visible = true


func set_to_new_game() -> void:
	daily_vial_count = 3
	daily_vacuum_count = 3


func _on_comply_pressed_animation_finished() -> void:
	fly_away()


func _on_resist_pressed_animation_finished() -> void:
	fly_away()


func fly_away() -> void:
	button_holder.visible = false
	vampire_spine.get_animation_state().set_animation("fly_away", false, 1)

func _on_vampire_spine_animation_completed(_ss, _ast, t_e: SpineTrackEntry) -> void:
	if t_e.get_track_index() == 1 and t_e.get_animation().get_name() == "fly_away":
		vampire_spine.get_animation_state().set_empty_animation(1, 0)
		vampire_spine.visible = false
		Glob.main.show_transition()
		await Glob.main.transition_shown
		headquarters_accepted.emit()
