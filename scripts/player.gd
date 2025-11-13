extends CharacterBody2D

@export var speed = 1200
@export var friction = 1
@export var acceleration = 0.3
@export var health = 3

func get_input():
	var input = Vector2()
	if Input.is_action_pressed('right'):
		input.x += 1
	if Input.is_action_pressed('left'):
		input.x -= 1
	if Input.is_action_pressed('down'):
		input.y += 1
	if Input.is_action_pressed('up'):
		input.y -= 1
	return input

func _physics_process(_delta):
	
	var direction = get_input()
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	move_and_slide()
	
func  isDead():
	if health <= 0:
		get_tree().change_scene_to_file("res://scenes/lazuliBoss.tscn")
