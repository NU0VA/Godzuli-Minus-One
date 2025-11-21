extends CharacterBody2D

@export var speed = 150

const EXPLOSION = preload("res://scenes/explosion.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x -= speed * delta

#makes mine vanish offscreen
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	#func to make debris go away
	
	#plays animation and gets rid of mine
func die():
	var explosion = EXPLOSION.instantiate()
	explosion.global_position = global_position
	add_sibling(explosion)
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		die()	
