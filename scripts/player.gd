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
const whiten_duration = 0.15
@export var whiten_material : ShaderMaterial

var cannon_scene = preload("res://scenes/cannonshot.tscn")
var hearts_list : Array[TextureRect]

var shoot_cd := false

#@onready var animator = get_node("AnimationPlayer")
#@onready var hitbox = get_node("Hitbox")

func _ready() -> void:
#Displays hearts on screen for health
	var hearts_parent = $health_bar/HBoxContainer
	for child in hearts_parent.get_children():
		hearts_list.append(child)
	hearts_parent.global_position = Vector2(1620,55)
	print(hearts_list)

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
		update_heart_display()
		print(health)
		print("hit")
		animator.play("playerHitAnim")
		#whiten_material.set_deferred("whiten", true)
		#await get_tree().create_timer(whiten_duration).timeout
		#whiten_material.set_deferred("whiten", false)

#player takes damage from debris
	if area.is_in_group("debris"):
		health -= 1
		update_heart_display()
		animator.play("playerHitAnim")

#updates how many hearts are on display
func update_heart_display():
	for i in range(hearts_list.size()):
		hearts_list[i].visible = i < health

#func shoot(): called when pressing a button to shoot
func shoot():
	cannon_shot.emit(cannon_scene, cannon.global_position)
