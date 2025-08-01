extends Node

var main: Main

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	main = get_tree().root.get_node("Main")

func queue_free_children(node: Node) -> void:
	for child in node.get_children():
		child.queue_free()
