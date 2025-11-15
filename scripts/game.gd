extends Node2D

@onready var player_spawn_pos = $PlayerSpawnPos
@onready var cannon_container = $CannonBallContainer
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
func _process(_delta: float) -> void:
	pass
