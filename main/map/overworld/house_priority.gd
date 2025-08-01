extends HBoxContainer


@onready var house_label: RichTextLabel = %HouseLabel

var house_id: int

func _ready() -> void:
	house_label.text = "House " + str(house_id + 1)
