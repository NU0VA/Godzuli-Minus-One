extends CharacterBody2D

signal cannon_shot(cannon_scene, location)

@export var speed : float = 1200
@export var friction : float = 1
@export var acceleration : float = 0.3
@export var health : int = 3
@export var animator: AnimationPlayer
@export var hitbox: Area2D
@export var rate_of_fire = 1.5

@onready var cannon = $Cannon

var cannon_scene = preload("res://scenes/cannonshot.tscn")

var shoot_cd := false

#@onready var animator = get_node("AnimationPlayer")
#@onready var hitbox = get_node("Hitbox")

#player inputs wasd/arrows
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

#normalizes player movement so diagonals aren't too fast
func _physics_process(_delta):
	var direction = get_input()
	if direction.length() > 0:
		velocity = velocity.lerp(direction.normalized() * speed, acceleration)
	else:
		velocity = velocity.lerp(Vector2.ZERO, friction)
	move_and_slide()

#This is supposed to shoot the cannon shot
	if Input.is_action_pressed("shoot"):
		if !shoot_cd:
			shoot_cd = true
			shoot()
			await get_tree().create_timer(rate_of_fire).timeout
			shoot_cd = false

#makes sure we stay inside game area
	global_position = global_position.clamp(Vector2.ZERO, get_viewport_rect().size)

#If player enters a hurtbox - 1 hp and play animation
func _on_area_2d_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if area.name == "Hurtbox":
		health -= 1
		print(health)
		print("hit")
		animator.play("playerHitAnim")
		#Dude I have 0 fucking clue why it won't disable the hitbox for this thing I just want to give the player i-frames bro :sob:
		#hitbox.set_deferred("monitoring", true)
		#await get_tree().create_timer(2.0).timeout
		#hitbox.set_deferred("monitoring", false)
		print("end hit")

#player takes damage from debris
	if area.is_in_group("debris"):
		health -= 1
		print(health)
		print("hit")
		print("end hit")


#func shoot(): called when pressing a button to shoot
func shoot():
	cannon_shot.emit(cannon_scene, cannon.global_position)
