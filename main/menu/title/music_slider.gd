extends VSlider


func _ready() -> void:
	value = AudioGlob.bgm_player.volume_db


func _on_value_changed(value_: float) -> void:
	AudioGlob.bgm_player.volume_db = value_
