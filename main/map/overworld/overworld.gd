class_name Overworld extends Node2D


@onready var house_locations: Node2D = %HouseLocations
@onready var hover_node: Node2D = %HoverNode
@onready var hover_label: RichTextLabel = %HoverLabel

func _ready() -> void:
	hover_node.visible = false
	for house_location_index  in house_locations.get_children().size():
		var location := house_locations.get_child(house_location_index)
		var house_inst := MapGlob.get_house_inst(house_location_index + 1)
		location.add_child(house_inst)
		house_inst.house_hovered.connect(house_hovered.bind(house_inst))
		house_inst.house_released.connect(house_released.bind(house_inst))


func house_hovered(house_inst: OverworldHouse) -> void:
	hover_node.visible = true
	hover_node.position = house_inst.global_position
	hover_label.text = str(house_inst.house_id)


func house_released(house_inst: OverworldHouse) -> void:
	hover_node.visible = false
