class_name OverworldHouse extends Node2D


signal house_hovered
signal house_released

@export var house: House

@onready var label: RichTextLabel = %Label
@onready var roof_color: Sprite2D = %RoofColor
@onready var wall_color: Sprite2D = %WallColor
@onready var house_sprite: Sprite2D = %HouseSprite
@onready var wall_sprites: Array[Sprite2D] = [roof_color, wall_color, house_sprite]

var available_colors := ["EAE6E5", "8F8073", "F1AB86", "694D75", "B4A6AB", "1E152A", "9D695A", "383F51"]

func _ready() -> void:
	label.text = str(house.display_name)
	#if house.house_id % 2 == 1:
		#for sprite in wall_sprites:
			#sprite.scale.x *= -1
	var roof_color_index := house.house_id
	if roof_color_index == 8:
		roof_color_index = 3
	var walls_color_index := house.house_id + 1
	if walls_color_index == 8:
		walls_color_index = 2
	if walls_color_index == 9:
		walls_color_index = 4
	%RoofColor.modulate = available_colors[roof_color_index]
	%WallColor.modulate = available_colors[walls_color_index]


func _on_button_mouse_entered() -> void:
	house_hovered.emit()


func _on_button_mouse_exited() -> void:
	house_released.emit()
