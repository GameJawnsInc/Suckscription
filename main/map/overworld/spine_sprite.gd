extends SpineSprite


func _ready() -> void:
	SpineGlob.random_anim_start(get_animation_state(), "animation", 0)
