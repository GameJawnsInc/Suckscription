extends Control


@onready var label: RichTextLabel = %Label


func _ready() -> void:
	label.text = "Day 5 reached! Game over!\n"
	for house in HouseGlob.get_all_houses():
		label.text += "\n" + house.display_name + " Relationship: " + str(house.relationship)
	label.text += "\n\nThanks for playing!\nCreated by gamejawnsinc and The Starkman Brothers"
