extends Area2D

@export var speed = -600


func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta):
	global_position.x += speed * delta
	
#makes cannonshot vanish offscreen
func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()
	print("gone")
