class_name Asteroid
extends RigidBody

export(float) var min_size: float = 2
export(float) var max_size: float = 3
export(float) var max_rotate: float = 1

func _ready():
	var sizef: float = rand_range(min_size, max_size)
	var sizev: Vector3 = Vector3(sizef, sizef, sizef)
	$Icosphere.scale = sizev
	$CollisionShape.scale = sizev
	self.angular_velocity = Vector3(0, rand_range(0, max_rotate), 0)
	
func get_class(): return "Asteroid"
