extends State
class_name EnemyIdle

@export var enemy: Node2D
var player: CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("player")

func Physics_Update(_delta: float):
	#resets lazuli position and puts her on a cooldown
	enemy.global_position = Vector2(240,754)
	await get_tree().create_timer(1.0).timeout
	#temp code below. set up conditions to switch to different states
	var distance = player.global_position - enemy.global_position
	if distance.length() > 500:
		Transitioned.emit(self,"chase")
		#If the player is on the side do wave attack. If they're in the middle do the beam attack. at any point lazuli can do her bite attack
		#
