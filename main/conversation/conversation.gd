class_name Conversation extends Control


signal completed

@onready var label: RichTextLabel = %Label
@onready var resident: SpineSprite = %Resident
@onready var button_1: NinePatchButton = %Button1
@onready var button_2: NinePatchButton = %Button2
@onready var button_3: NinePatchButton = %Button3

@onready var inventory_1: NinePatchButton = %Inventory1
@onready var inventory_2: NinePatchButton = %Inventory2
@onready var inventory_3: NinePatchButton = %Inventory3
@onready var inventory_4: NinePatchButton = %Inventory4

@onready var inventory_panel: NinePatchPanel = %InventoryPanel
@onready var approach_panel: NinePatchPanel = %ApproachPanel

@onready var inventory_buttons: Array[NinePatchButton] = [%Inventory1, %Inventory2, %Inventory3, %Inventory4]
@onready var approach_buttons: Array[NinePatchButton] = [%Button1, %Button2, %Button3]

@onready var response_panel: NinePatchPanel = %ResponsePanel
@onready var response_label: RichTextLabel = %ResponseLabel


var house_id: int
var selected_product: ProductsGlob.Product
var selected_approach: HouseGlob.Approach

func _ready() -> void:
	inventory_panel.visible = true
	approach_panel.visible = false
	response_panel.visible = false
	var res_name := HouseGlob.get_trait_name(house_id).to_lower().replace(" ", "_")
	resident.get_skeleton().set_skin_by_name(res_name)
	resident.get_animation_state().set_animation("idle", true, 0)
	resident.get_animation_state().set_animation(res_name, true, 1)
	
	inventory_1.text = ProductsGlob.get_product_name(ProductsGlob.get_inventory_slot(0))
	inventory_2.text = ProductsGlob.get_product_name(ProductsGlob.get_inventory_slot(1))
	inventory_3.text = ProductsGlob.get_product_name(ProductsGlob.get_inventory_slot(2))
	inventory_4.text = ProductsGlob.get_product_name(ProductsGlob.get_inventory_slot(3))
	
	for button in approach_buttons:
		button.pressed.connect(disable_approach_buttons)
	for button in inventory_buttons:
		button.pressed.connect(disable_inventory_buttons)
	
	#if !ProductsGlob.is_product_in_stock(ProductsGlob.get_inventory_slot(0)):
		#UiGlob.disable_button(button_1)
	#if !ProductsGlob.is_product_in_stock(ProductsGlob.get_inventory_slot(1)):
		#UiGlob.disable_button(button_2)
	#if !ProductsGlob.is_product_in_stock(ProductsGlob.get_inventory_slot(2)):
		#UiGlob.disable_button(button_3)
	#if !ProductsGlob.is_product_in_stock(ProductsGlob.get_inventory_slot(3)):
		#UiGlob.disable_button(button_4)


func finish_convo() -> void:
	completed.emit()
	queue_free()


func _on_button_1_pressed_animation_finished() -> void:
	selected_approach = HouseGlob.Approach.ETHOS
	calculate_and_respond()

func _on_button_2_pressed_animation_finished() -> void:
	selected_approach = HouseGlob.Approach.LOGOS
	calculate_and_respond()

func _on_button_3_pressed_animation_finished() -> void:
	selected_approach = HouseGlob.Approach.PATHOS
	calculate_and_respond()

func calculate_and_respond() -> void:
	var love_hate_boost := ProductsGlob.get_love_hate_boost(selected_product, house_id)
	var approach_boost := HouseGlob.get_approach_boost(house_id, selected_approach)
	var response_type: String = "neutral"
	if love_hate_boost + approach_boost < 0:
		response_type = "negative"
		HouseGlob.find_house_by_id(house_id).relationship -= 1
		ProgressGlob.suspicion -= 1
	if love_hate_boost + approach_boost > 0:
		response_type = "positive"
		HouseGlob.find_house_by_id(house_id).relationship += 1
	response_label.text = HouseGlob.get_response(house_id, response_type)
	var extra_text := "\n\n[font_size=30]Relationship "
	match response_type:
		"neutral" :
			extra_text += "unchanged. Product not sold."
		"negative" :
			extra_text += "-1. Product not sold."
		"positive" :
			extra_text += "+1. Product sold!"
	extra_text += "[/font_size]"
	response_label.text += extra_text
	approach_panel.visible = false
	response_panel.visible = true

func disable_approach_buttons() -> void:
	for button in inventory_buttons:
		UiGlob.disable_button(button)

func _on_inventory_1_pressed_animation_finished() -> void:
	inventory_selected(0)
func _on_inventory_2_pressed_animation_finished() -> void:
	inventory_selected(1)
func _on_inventory_3_pressed_animation_finished() -> void:
	inventory_selected(2)
func _on_inventory_4_pressed_animation_finished() -> void:
	inventory_selected(3)

func inventory_selected(index: int) -> void:
	selected_product = index as ProductsGlob.Product
	label.text = ConvoGlob.IntroLines[house_id].pick_random() + "\n Pitch a product!"
	label.text += "\n\n[font_size=30]Pitching: " + ProductsGlob.get_product_name(selected_product)
	label.text += "[/font_size]"
	inventory_panel.visible = false
	approach_panel.visible = true
	button_1.text = ProductsGlob.get_tagline(selected_product, HouseGlob.Approach.ETHOS)
	button_2.text = ProductsGlob.get_tagline(selected_product, HouseGlob.Approach.LOGOS)
	button_3.text = ProductsGlob.get_tagline(selected_product, HouseGlob.Approach.PATHOS)

func disable_inventory_buttons() -> void:
	for button in inventory_buttons:
		UiGlob.disable_button(button)


func _on_leave_button_pressed_animation_finished() -> void:
	completed.emit()
	queue_free()
