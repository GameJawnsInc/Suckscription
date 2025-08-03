class_name HousePriority extends HBoxContainer


signal up_pressed
signal down_pressed

@onready var number_label: RichTextLabel = %NumberLabel
@onready var house_label: RichTextLabel = %HouseLabel
@onready var panel_1: NinePatchPanel = %Panel1
@onready var panel_2: NinePatchPanel = %Panel2
@onready var up_button: NinePatchButton = %UpButton
@onready var down_button: NinePatchButton = %DownButton

var house: House

func _ready() -> void:
	house_label.text = house.display_name + " (Rela: " + str(house.relationship) + ")"
	number_label.text = str(house.priority + 1) + "."


func _on_up_button_pressed() -> void:
	up_pressed.emit()


func _on_down_button_pressed() -> void:
	down_pressed.emit()

func scale_buttons() -> void:
	tween_node(panel_1)
	tween_node(panel_2)
	tween_node(up_button)
	tween_node(down_button)

func tween_node(node: Node) -> void:
	var t_1 := create_tween()
	t_1.set_trans(Tween.TRANS_QUART)
	t_1.set_ease(Tween.EASE_IN_OUT)
	t_1.tween_property(node, "modulate", Color(1, 0, 1), 1)
	t_1.tween_property(node, "modulate", Color(1, 1, 1), 1)
