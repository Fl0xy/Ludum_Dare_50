class_name Asteroid
extends RigidBody

export(float) var min_size: float = 10
export(float) var max_size: float = 30
export(float) var max_rotate: float = 1
export(float) var energy_mass_multiplyer: float = 1

func _ready():
	var sizef: float = rand_range(min_size, max_size)
	$Icosphere.scale = sizef * Vector3(1,1,1)
	$CollisionShape.scale = sizef * Vector3(1,1,1)
	self.mass = self.mass * sizef
	self.angular_velocity = Vector3(0, rand_range(0, max_rotate), 0)
	
func get_class(): return "Asteroid"
