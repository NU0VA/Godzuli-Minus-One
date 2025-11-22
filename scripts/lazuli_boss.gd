extends Node2D
#@export var playerNodePath : NodePath
#@export var SPEED = 2
#@onready var startPos = position
#@onready var playerPos = get_node(playerNodePath).get_position()

#func _process(delta: float) -> void:
	#
	##dives towards player and attacks
	#if Input.is_action_pressed("shoot"):
		#playerPos = get_node(playerNodePath).get_position()
		#
	#position = position.move_toward(playerPos,SPEED)
	#if position == position.move_toward(playerPos,SPEED):
			#position = startPos
