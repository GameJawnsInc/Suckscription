extends Sprite2D


const MaxScale = Vector2(1.3, 1.3)
const StartingScale = Vector2(0.8, 0.8)
const StartingOffset = -28.5
const MaxOffset = -55
const TweenTime = 0.66
const TweenCount = 3

func _ready() -> void:
	scale = StartingScale
	for i in TweenCount:
		var t_1 := create_tween()
		t_1.tween_property(self, "scale", MaxScale, TweenTime)
		t_1.tween_property(self, "scale", Vector2.ONE, TweenTime)
		t_1.set_ease(Tween.EASE_IN_OUT)
		t_1.set_trans(Tween.TRANS_QUAD)
		var t_2 := create_tween()
		t_2.tween_property(self, "offset:y", MaxOffset, TweenTime)
		t_2.tween_property(self, "offset:y", StartingOffset, TweenTime)
		t_2.set_ease(Tween.EASE_IN_OUT)
		t_2.set_trans(Tween.TRANS_QUAD)
		await t_1.finished
	var t_3 := create_tween()
	t_3.tween_property(self, "scale", Vector2(0.001, 0.001), TweenTime)
	t_3.set_ease(Tween.EASE_IN_OUT)
	t_3.set_trans(Tween.TRANS_QUAD)
	await t_3.finished
	queue_free()
