class_name PlayerBody extends CharacterBody2D


@export var navigator: PlayerNavigator

var move_direction: Vector2

var acceleration: float = 1200.0
var braking_power: float = 800.0
var max_speed: float = 140.0

var is_movement_disabled: bool = false

func _physics_process(delta: float) -> void:
	if is_movement_disabled:
		velocity = Vector2.ZERO
		return
	if move_direction.is_zero_approx():
		velocity = velocity.move_toward(Vector2.ZERO, delta * braking_power)
	else:
		velocity += move_direction * delta * acceleration
	velocity = velocity.limit_length(max_speed)
	move_and_slide()
	move_direction = Vector2.ZERO


func set_destination(destination_position: Vector2) -> void:
	navigator.current_follow_target = destination_position
