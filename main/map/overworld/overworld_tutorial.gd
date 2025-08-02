extends Control


const LabelTexts: Array[String] = [
	"Choose your route with the PRIORITY button.

Start your route with the START DAY button.",
	"Your character will visit as many houses as possible in the 24 hour period.",
	"Choose the best houses based on your sales pitch, your inventory, and their distance from each other.",
	"Mouse over houses for information. Good luck!"
]

@onready var label: RichTextLabel = %Label

var label_index: int = 0

func _ready() -> void:
	label.text = LabelTexts[label_index]

func _on_got_it_button_pressed_animation_finished() -> void:
	label_index += 1
	if label_index == 4:
		queue_free()
		return
	label.text = LabelTexts[label_index]
