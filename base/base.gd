extends Spatial


export(float) var blackhole_min_radius: float = 7
export(float) var blackhole_max_radius: float = 25
export(float) var blackhole_radius: float setget set_blackhol_size


func _ready():
	self.blackhole_radius = blackhole_min_radius + (blackhole_max_radius-blackhole_min_radius) / 2


func _process(delta):
	pass
	

func set_blackhol_size(value: float):
	$blackhole/MeshInstance.mesh.radius = value
	$blackhole/MeshInstance.mesh.height = value*2
	$blackhole/CollisionShape.shape.radius = value
	
