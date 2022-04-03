extends Spatial


export(float) var blackhole_min_radius: float = 7
export(float) var blackhole_max_radius: float = 25
export(float) var blackhole_radius: float setget set_blackhol_size

signal asteroid_entered
signal destoryed


func _ready():
	self.blackhole_radius = blackhole_min_radius + (blackhole_max_radius-blackhole_min_radius) / 2
	Global.set_backhole(self)
	Global.connect("destroy_blackhole", self, "destory")
	

func set_blackhol_size(value: float):
	blackhole_radius = value
	$blackhole/MeshInstance.mesh.radius = value
	$blackhole/MeshInstance.mesh.height = value*2
	$blackhole/CollisionShape.shape.radius = value
	


func _on_despawner_body_entered(body):
	body.queue_free()


func _on_blackhole_body_entered(body):
	if body.get_class() != "Asteroid":
		return
	emit_signal("asteroid_entered", body)


func destory():
	print("kaboom !!!!!")
	emit_signal("destoryed")
