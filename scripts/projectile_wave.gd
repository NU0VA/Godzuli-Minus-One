extends Node2D
#REMEMBER TO CHANGE SPEED BACK TO A HIGHER NUMBER AFTER TESTING
@export var SPEED = 1

#var spawnPos : Vector2

#func _ready():
	#global_position = spawnPos
	
func _physics_process(delta):
	position.x += SPEED * delta
