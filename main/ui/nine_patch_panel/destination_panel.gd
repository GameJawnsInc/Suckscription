class_name DestinationPanel extends NinePatchPanel


const TweenTime = 0.8
const DisplayTime = 2.5
const UpAmount = 250

var start_pos: float
var end_pos: float

@export var name_string: String
@export var destination_string: String

@onready var dest_label: RichTextLabel = %DestLabel

func _ready() -> void:
	end_pos = position.y
	start_pos = end_pos - UpAmount
	position.y = start_pos
	dest_label.text = "Destination:\n\n" + name_string + "\n" + destination_string
	var t_1 := create_tween()
	t_1.set_trans(Tween.TRANS_QUAD)
	t_1.set_ease(Tween.EASE_IN_OUT)
	t_1.tween_property(self, "position:y", end_pos, TweenTime)
	await t_1.finished
	await Glob.new_timer_timeout(self, DisplayTime)
	
	var t_2 := create_tween()
	t_2.set_trans(Tween.TRANS_QUAD)
	t_2.set_ease(Tween.EASE_IN_OUT)
	t_2.tween_property(self, "position:y", start_pos, TweenTime)
	
	await t_2.finished
	visible = false
