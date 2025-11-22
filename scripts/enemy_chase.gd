extends State
class_name EnemyChase

@export var enemy: Node2D
@export var speed = 2

var playerPos
var startPos

func Enter():
	playerPos = get_tree().get_first_node_in_group("player").global_position
	startPos = enemy.global_position
#var playerPos


func _process(_delta: float) -> void:
	
	#dives towards player and attacks
	#if Input.is_action_pressed("shoot"):
	#	playerPos = get_node(playerNodePath).get_position()
		
	enemy.global_position = enemy.global_position.move_toward(playerPos,speed)
	if enemy.global_position == playerPos:
			#enemy.global_position = startPos
			Transitioned.emit(self, "idle")
