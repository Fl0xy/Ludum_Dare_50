extends Spatial


func _ready():
	call_deferred("spawn_helper")

func spawn_helper():
	$asteroid_placer.spawn()
	
func _physics_process(delta):
	var camera_pos: Vector3 = $ship.translation
	camera_pos.y += 25
	$Camera.translation = camera_pos
