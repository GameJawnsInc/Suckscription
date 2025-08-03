class_name Headquarters extends Control


signal completed
signal next_pressed
signal game_ended

const Responses: Dictionary[int, Array] = {
	1 : [
		"Long ago, I ruled through fear. Now, I rule through residuals.",
		"The EssenceSuite is our salvation. Six sacred SKUs. Each overpriced. Each under warranty.",
		"Go forth, my asset. Peddle my gospel door-to-door. Convert these knaves into downlines.",
		"And remember: they cannot revolt if they’re enrolled.",
		],
	2 : [
		"Good evening, asset. Profit projection is down two digits. I need a miracle or a memo.",
		],
	3 : [
		"After two more days, we'll loop back to promotion negotiations. Until then, get back out there and sell more product.",
		],
	4 : [
		"One more day before I decide your fate. Make today count.",
		],
}

const Day5: Dictionary[String, Array] = {
	"high_rela" : [
		"Drac stands behind you in satisfied silence. The numbers are clean. The customers are locked in.",
		"Suspicion is low and profits ascend like a bat at dusk.",
		"He extends a cold hand, rings glinting with the gleam of automated billing.",
		"You shake without hesitation.",
		"The fangs never come out. They never needed to.",
		"Numbers speak louder than throats.",
		"Your promotion is swift, undocumented, and irreversable. You now oversee Sales Region D.",
		"The pay is the same. The glory is eternal. Congratulations."
	],
	"low_rela" : [
		"You were... an adequate employee. Nothing special.",
		"The higher echelons of EssenceSuite have no particular need for someone with your limited set of skills.",
		"Drac coils at the thought of you receiving a bigger cut.",
		"For now, you'll need to keep on the grindset."
	],
	"negative_rela" : [
		"The windows rattle with chants. The doors shake under the weight of a neighborhood's awakening.",
		"'They are not here for me' he says. The crowd bursts in.",
		"A mix of angry locals and suited enforcers from an agency you've never heard of enter.",
		"They demand documents. They demand accountability.",
		"They demand refunds.",
		"Drac melts into the wallpaper with the grace of a man who invented the idea of an exit strategy.",
		"You are left holding a company laptop and a signed NDA.",
		"By sunrise, the EssenceSuite website redirects to a dead link, your name misspelled in the press release."
	],
}

@onready var vampire_spine: Vampire = %VampireSpine
@onready var button_holder: HBoxContainer = %ButtonHolder
@onready var vamp_text: RichTextLabel = %VampText

@onready var button_1: NinePatchButton = %Button1
@onready var button_2: NinePatchButton = %Button2
@onready var button_3: NinePatchButton = %Button3
@onready var next_button: NinePatchButton = %NextButton
@onready var next_holder: HBoxContainer = %NextHolder

@onready var text_panel: NinePatchPanel = %TextPanel
@onready var inventory_panel: NinePatchPanel = %InventoryPanel

@onready var inventory_buttons: Array[NinePatchButton] = [
	%Inventory1, %Inventory2, %Inventory3, %Inventory4, %Inventory5, %Inventory6
	]

var responses := Responses.duplicate()
var day_5 := Day5.duplicate()
var current_day := ProgressGlob.get_current_day()

var response_index: int = 0
var variable_index: int = 0

var inventory_count: int = 0

var choices: Array[ProductsGlob.Product] = []

func _ready() -> void:
	text_panel.visible = true
	inventory_panel.visible = false
	
	for index in inventory_buttons.size():
		inventory_buttons[index].text = ProductsGlob.get_product_name(index)
	
	button_holder.visible = false
	next_holder.visible = true
	cycle_responses()
	
	#if current_day < 3:
		#button_holder.visible = false
		#next_holder.visible = true
		#cycle_responses()
	#elif current_day < 5:
		#button_holder.visible = true
		#next_holder.visible = false
		#cycle_choices()

func cycle_responses() -> void:
	UiGlob.enable_button(next_button)
	
	if current_day == 5:
		var total_relationship := HouseGlob.calculate_total_relationship()
		var entry_str := "low_rela"
		if total_relationship > 4:
			entry_str = "high_rela"
		if total_relationship < 0:
			entry_str = "negative_rela"
		vamp_text.text =  day_5[entry_str][response_index]
		response_index += 1
		await next_pressed
		if day_5[entry_str].size() == response_index:
			end_game()
		else:
			cycle_responses()
	else:
		vamp_text.text =  responses[current_day][response_index]
		response_index += 1
		await next_pressed
		if responses[current_day].size() == response_index:
			show_inventory()
		else:
			cycle_responses()

func end_game() -> void:
	game_ended.emit()
	queue_free()


func fly_away() -> void:
	button_holder.visible = false
	vampire_spine.get_animation_state().set_animation("fly_away", false, 1)

func _on_vampire_spine_animation_completed(_ss, _ast, t_e: SpineTrackEntry) -> void:
	if t_e.get_track_index() == 1 and t_e.get_animation().get_name() == "fly_away":
		completed.emit(choices)
		queue_free()


func _on_button_1_pressed_animation_finished() -> void:
	pass # Replace with function body.

func _on_button_2_pressed_animation_finished() -> void:
	pass # Replace with function body.

func _on_button_3_pressed_animation_finished() -> void:
	pass # Replace with function body.

func _on_next_button_pressed_animation_finished() -> void:
	next_pressed.emit()


func show_inventory() -> void:
	text_panel.visible = false
	inventory_panel.visible = true
	#fly_away()

func _on_inventory_1_pressed_animation_finished() -> void:
	add_and_check_count(0)

func _on_inventory_2_pressed_animation_finished() -> void:
	add_and_check_count(1)

func _on_inventory_3_pressed_animation_finished() -> void:
	add_and_check_count(2)

func _on_inventory_4_pressed_animation_finished() -> void:
	add_and_check_count(3)

func _on_inventory_5_pressed_animation_finished() -> void:
	add_and_check_count(4)

func _on_inventory_6_pressed_animation_finished() -> void:
	add_and_check_count(5)


func add_and_check_count(index: int) -> void:
	choices.push_back(index)
	if choices.size() == 4:
		fly_away()
		for button in inventory_buttons:
			UiGlob.disable_button(button)
