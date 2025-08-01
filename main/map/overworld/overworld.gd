class_name Overworld extends Node2D


const HousePriorityScene = preload("house_priority.tscn")

@onready var house_locations: Node2D = %HouseLocations
@onready var hover_node: Node2D = %HoverNode
@onready var hover_label: RichTextLabel = %HoverLabel
@onready var priority_button: NinePatchButton = %PriorityButton
@onready var popup: Control = %Popup


func _ready() -> void:
	popup.visible = false
	hover_node.visible = false
	for house_location_index  in house_locations.get_children().size():
		var location := house_locations.get_child(house_location_index)
		var house_inst := MapGlob.get_house_inst(house_location_index + 1)
		location.add_child(house_inst)
		house_inst.house_hovered.connect(house_hovered.bind(house_inst))
		house_inst.house_released.connect(house_released.bind(house_inst))
	priority_button.pivot_offset = Vector2(196.5, 45.0)


func house_hovered(house_inst: OverworldHouse) -> void:
	hover_node.visible = true
	hover_node.position = house_inst.global_position
	hover_label.text = str(house_inst.house_id)


func house_released(house_inst: OverworldHouse) -> void:
	hover_node.visible = false


func _on_priority_button_pressed_animation_finished() -> void:
	popup.visible = true
	for child in %HousePriorityHolder.get_children():
		child.queue_free()
	for house_id in house_locations.get_children().size():
		var inst := HousePriorityScene.instantiate()
		inst.house_id = house_id
		%HousePriorityHolder.add_child(inst)


func _on_close_popup_pressed_animation_finished() -> void:
	popup.visible = false
