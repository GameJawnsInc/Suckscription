extends Node

var main: Main

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	main = get_tree().root.get_node("Main")

func queue_free_children(node: Node) -> void:
	for child in node.get_children():
		child.queue_free()

func new_timer_timeout(parent_node: Node, time: float,\
								timer_node: Timer = null) -> Signal:
	var timer := Timer.new() if !timer_node else timer_node
	timer.one_shot = true
	timer.timeout.connect(timer.queue_free)
	parent_node.add_child(timer)
	timer.start(time)
	return timer.timeout
