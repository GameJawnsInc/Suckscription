class_name OverworldHouse extends Node2D


signal house_hovered
signal house_released

@export var house: House

@onready var label: RichTextLabel = %Label
@onready var house_sprite: Sprite2D = %HouseSprite


func _ready() -> void:
	label.text = str(house.display_name)
	if house.house_id % 2 == 1:
		house_sprite.scale.x *= -1


func _on_button_mouse_entered() -> void:
	house_hovered.emit()


func _on_button_mouse_exited() -> void:
	house_released.emit()
