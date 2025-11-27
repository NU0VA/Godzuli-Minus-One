extends State
class_name EnemyChase

@export var enemy: Node2D
@export var speed = 5
var player: CharacterBody2D
var playerPos
func Enter():
	player = get_tree().get_first_node_in_group("player")
	playerPos = player.global_position
	
func Physics_Update(_delta: float) -> void:
	#swims towards player's last position and resets position after reaching destination
	var direction = playerPos - enemy.global_position
	enemy.global_position = enemy.global_position.move_toward(playerPos,speed)
	
	if direction.length() <= 50:
		Transitioned.emit(self,"idle")
