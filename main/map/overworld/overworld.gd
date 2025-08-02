class_name Overworld extends Node2D


signal day_started
signal go_pressed
signal map_completed


const PointInfoScene = preload("overworld_path_point_info.tscn")
const MoveArrowScene = preload("move_arrow.tscn")
const DestinationPanelScene = preload("destination_panel.tscn")
@onready var spawn_points: Array[Node2D] = [%SpawnPoint, %SpawnPoint2, %SpawnPoint3, %SpawnPoint4]
@onready var spawn_point := spawn_points.pick_random().position as Vector2

@onready var house_locations: Node2D = %HouseLocations
@onready var hover_node: Node2D = %HoverNode
@onready var hover_label: RichTextLabel = %HoverLabel
@onready var hover_label_2: RichTextLabel = %HoverLabel2
@onready var priority_button: NinePatchButton = %PriorityButton
@onready var start_day_button: NinePatchButton = %StartDayButton
@onready var popup: Control = %Popup
@onready var house_priority_holder: HousePriorityHolder = %HousePriorityHolder
@onready var path_line: Line2D = %PathLine

@onready var go_button: NinePatchButton = %GoButton


var house_insts: Array[OverworldHouse] = []

var current_point: int = 0

func _ready() -> void:
	popup.visible = false
	hover_node.visible = false
	go_button.visible = false
	for house_location_index  in house_locations.get_children().size():
		var location := house_locations.get_child(house_location_index)
		var house_inst := MapGlob.get_house_inst(house_location_index)
		location.add_child(house_inst)
		house_insts.push_back(house_inst)
	connect_houses_to_popup()
	priority_button.pivot_offset = Vector2(196.5, 45.0)
	draw_path()

func connect_houses_to_popup() -> void:
	for house_inst in house_insts:
		house_inst.house_hovered.connect(house_hovered.bind(house_inst))
		house_inst.house_released.connect(house_released.bind(house_inst))

func disconnect_houses_from_popup() -> void:
	for house_inst in house_insts:
		house_inst.house_hovered.disconnect(house_hovered.bind(house_inst))
		house_inst.house_released.disconnect(house_released.bind(house_inst))

func house_hovered(house_inst: OverworldHouse) -> void:
	hover_node.visible = true
	#hover_node.position = house_inst.global_position
	hover_label.text = str(house_inst.house.display_name)
	hover_label_2.text = HouseGlob.get_trait_name(house_inst.house.trait_id)


func house_released(_house_inst: OverworldHouse) -> void:
	hover_node.visible = false


func _on_priority_button_pressed_animation_finished() -> void:
	popup.visible = true
	house_priority_holder.refresh()


func _on_close_popup_pressed_animation_finished() -> void:
	popup.visible = false
	draw_path()


func draw_path() -> void:
	path_line.clear_points()
	path_line.add_point(spawn_point)
	Glob.queue_free_children(path_line)
	for house in HouseGlob.get_sorted_houses_by_property("priority"):
		var pos := house_insts[house.house_id].global_position
		path_line.add_point(pos)
		var label := PointInfoScene.instantiate()
		label.position = pos
		label.path_label = str(house.priority + 1)
		path_line.add_child(label)


func _on_start_day_button_pressed_animation_finished() -> void:
	Glob.main.show_transition()
	await Glob.main.transition_shown
	day_started.emit()

func add_player(player_inst: PlayerBody) -> void:
	disconnect_houses_from_popup()
	hover_node.visible = false
	path_line.visible = false
	priority_button.visible = false
	start_day_button.visible = false
	current_point = 0
	player_inst.position = spawn_point
	house_locations.add_child(player_inst)
	player_reached_point(player_inst)
	await Glob.main.progress_system.times_up
	player_inst.is_movement_disabled = true
	Glob.main.show_transition()
	await Glob.main.transition_shown
	player_inst.queue_free()
	map_completed.emit()
	queue_free()

func player_reached_point(player_inst: PlayerBody) -> void:
	if player_inst.is_movement_disabled:
		return
	#go_button.visible = true
	#await go_pressed
	var destination := path_line.points[get_next_point()]
	var house := HouseGlob.get_sorted_houses_by_property("priority")[current_point - 1]
	var inst := DestinationPanelScene.instantiate()
	inst.name_string = house.display_name
	inst.destination_string = HouseGlob.get_trait_name(house.trait_id)
	add_child(inst)
	player_inst.set_destination(destination)
	var move_arrow := MoveArrowScene.instantiate()
	move_arrow.position = destination
	add_child(move_arrow)

func get_next_point() -> int:
	current_point = current_point + 1
	if current_point == HouseGlob.HouseCount + 1:
		current_point = 1
	return current_point


func _on_go_button_pressed_animation_finished() -> void:
	go_pressed.emit()
	go_button.visible = false
