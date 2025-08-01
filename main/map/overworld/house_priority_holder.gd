class_name HousePriorityHolder extends VBoxContainer


const HousePriorityScene = preload("house_priority.tscn")

var should_bump_house_1: int = -1
var should_bump_house_2: int = -1

func house_up_pressed(house_id: int) -> void:
	if house_id == 0:
		return
	var current_house := get_child(house_id) as HousePriority
	var prev_house := get_child(house_id - 1) as HousePriority
	current_house.house.priority -= 1
	should_bump_house_1 = house_id
	prev_house.house.priority += 1
	should_bump_house_2 = house_id - 1
	HouseGlob.set_priorities_updated()
	refresh()

func house_down_pressed(house_id: int) -> void:
	if house_id == HouseGlob.HouseCount - 1:
		return
	var current_house := get_child(house_id) as HousePriority
	var next_house := get_child(house_id + 1) as HousePriority
	current_house.house.priority += 1
	should_bump_house_1 = house_id
	next_house.house.priority -= 1
	should_bump_house_2 = house_id + 1
	HouseGlob.set_priorities_updated()
	refresh()

func refresh() -> void:
	for child in get_children():
		child.queue_free()
	var count: int = 0
	for house in HouseGlob.get_sorted_houses_by_property("priority"):
		var inst := HousePriorityScene.instantiate()
		inst.house = house
		inst.up_pressed.connect(house_up_pressed.bind(count))
		inst.down_pressed.connect(house_down_pressed.bind(count))
		add_child(inst)
		count += 1
	if should_bump_house_1 != -1:
		scale_button(get_child(should_bump_house_1))
		should_bump_house_1 = -1
	if should_bump_house_2 != -1:
		scale_button(get_child(should_bump_house_2))
		should_bump_house_2 = -1

func scale_button(house_priority: HousePriority) -> void:
	house_priority.scale_buttons()
