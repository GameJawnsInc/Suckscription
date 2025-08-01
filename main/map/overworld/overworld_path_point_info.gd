extends Node2D


@export var path_label: String

func _ready() -> void:
	$RichTextLabel.text = path_label
