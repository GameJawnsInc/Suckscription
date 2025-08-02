extends Node


func is_track_empty(track: SpineTrackEntry):
	return track.get_animation().get_name() == "<empty>"

func set_track_to_max(state: SpineAnimationState, track: int) -> void:
	var max_time = state.get_current(track).get_animation().get_duration()
	state.get_current(track).set_track_time(max_time)

func spine_animation_name(track_entry: SpineTrackEntry) -> String:
	return track_entry.get_animation().get_name()

func advance_physics(spine_sprite: SpineSprite) -> void:
	var skele := spine_sprite.get_skeleton()
	var iterations := 16
	for i in iterations:
		skele.update(0.05)

func random_anim_start(spine_state: SpineAnimationState,\
					 		anim_name: String, track_num: int, \
							should_loop: bool = true) -> SpineTrackEntry:
	var anim := spine_state.set_animation(anim_name, should_loop, track_num)
	var track_time := randf_range(0, anim.get_animation_end())
	anim.set_track_time(track_time)
	return spine_state.get_current(track_num)

##percent range: 0.0 -> 1.0
func percent_anim_start(spine_state: SpineAnimationState,\
					 	anim_name: String, track_num: int, percent: float,\
						should_loop: bool = true) -> SpineTrackEntry:
	var anim := spine_state.set_animation(anim_name, should_loop, track_num)
	anim.set_track_time(anim.get_animation_end() * percent)
	return spine_state.get_current(track_num)

func anim_name_to_time(data: SpineSkeletonDataResource, anim_name: String) -> float:
	return data.find_animation(anim_name).get_duration()

func connect_button_signals(node: Node, button: Button,\
			state: SpineAnimationState, track_id: int, mix_duration: float,\
			pressed_method_to_connect: Callable,\
			hover_name: String = "hovered", pressed_name: String = "pressed",\
			) -> void:
	var _on_mouse_entered := func():
		if !node.get("is_pressable"):
			return
		state.set_animation(hover_name, false, track_id)
	button.mouse_entered.connect(_on_mouse_entered)
	
	var _on_mouse_exited := func():
		state.set_empty_animation(track_id, mix_duration)
	button.mouse_exited.connect(_on_mouse_exited)
	
	var _on_button_pressed: Callable = func():
		if !node.get("is_pressable"):
			return
		if pressed_method_to_connect:
			pressed_method_to_connect.call()
		state.set_animation(pressed_name, false, track_id + 1)
		state.add_empty_animation(track_id + 1, 0, 0)
		state.set_empty_animation(track_id, mix_duration)
	button.pressed.connect(_on_button_pressed)
