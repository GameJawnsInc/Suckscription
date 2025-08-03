class_name Clock extends Node2D


signal times_up

@onready var rich_text_label: RichTextLabel = %RichTextLabel


var time: float = 0
var is_waiting: bool = false

func _process(delta: float) -> void:
	if is_waiting:
		return
	time += delta
	if time >= ProgressGlob.DayLength:
		times_up.emit()
		queue_free()
	else:
		rich_text_label.text = convert_to_12hour(float_to_24hour(time))
	

func float_to_24hour(input_float: float) -> Dictionary:
	input_float = clampf(input_float, 0.0, ProgressGlob.DayLength)
	var fraction_of_day := input_float / ProgressGlob.DayLength
	var total_minutes_in_day := 24 * 60
	var total_minutes := int(fraction_of_day * total_minutes_in_day)
	var hour := total_minutes / 60
	var minute := total_minutes % 60
	return {"hour": hour, "minute": minute}

func convert_to_12hour(time_dict: Dictionary) -> String:
	var hour := time_dict["hour"] as float
	var minute := time_dict["minute"] as float
	var ampm := ""
	if hour >= 12:
		ampm = "PM"
	else:
		ampm = "AM"
	if hour > 12:
		hour -= 12
	elif hour == 0:  # Handle 00:XX as 12:XX AM
		hour = 12
	return "%d:%02d %s" % [hour, minute, ampm]

func pause_timer() -> void:
	is_waiting = true


func resume_timer() -> void:
	is_waiting = false
