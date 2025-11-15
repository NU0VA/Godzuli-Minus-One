extends Node2D

@export var debris_scenes: Array[PackedScene] = []

@onready var player_spawn_pos = $PlayerSpawnPos
@onready var cannon_container = $CannonBallContainer
@onready var timer = $DebrisSpawnTimer
@onready var debris_container = $DebrisContainer

var player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#Sets Players spawn position in game
	player = get_tree().get_first_node_in_group("player")
	player.cannon_shot.connect(_on_player_cannon_shot)
	player.global_position = player_spawn_pos.global_position

#makes cannon shot appear
func _on_player_cannon_shot(cannon_scene, location):
	var cannon = cannon_scene.instantiate()
	cannon.global_position = location
	cannon_container.add_child(cannon)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
#controls frequency of debris spawn
	if timer.wait_time > 0.05:
		timer.wait_time -= delta*0.005
	elif timer.wait_time < 0.05:
		timer.wait_time = 0.05

#makes debris spawn
func _on_debris_spawn_timer_timeout() -> void:
	var d = debris_scenes.pick_random().instantiate()
	d.global_position = Vector2(1920,randf_range(270,1080))
	debris_container.add_child(d)
