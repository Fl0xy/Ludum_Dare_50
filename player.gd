extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if Input.is_action_pressed("ui_up"):
		apply_impulse($TB1.position, Vector2(0, -10, 0))
		apply_impulse($TB2.position, Vector2(0, -10, 0))
	if Input.is_action_pressed("ui_right"):
		apply_impulse($TL.position, Vector2(10, 0, 0))
	if Input.is_action_pressed("ui_left"):
		apply_impulse($TR.position, Vector2(-10, 0, 0))
	if Input.is_action_pressed("ui_down"):
		apply_impulse($TF.position, Vector2(0, 10, 0))
