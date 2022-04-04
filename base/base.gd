extends Spatial


export(float) var blackhole_min_radius: float = 7
export(float) var blackhole_max_radius: float = 25
export(float) var blackhole_radius: float setget set_blackhol_size
export(bool) var destorying: bool = false

signal asteroid_entered
signal destoryed

func _process(delta):
	if destorying:
		$blackhole/black_hole.translation.x = rand_range(-1, 1)
		$blackhole/black_hole.translation.z = rand_range(-1, 1)
	else:
		$blackhole/black_hole.rotate(Vector3(0,1,0), 0.5*delta)
		$station.rotate(Vector3(0,1,0), -0.01*delta)
	
		self.blackhole_radius = blackhole_min_radius + Global.blackhole_factor * (blackhole_max_radius - blackhole_min_radius)
	


func _ready():
	self.blackhole_radius = blackhole_min_radius + (blackhole_max_radius-blackhole_min_radius) / 2
	Global.set_backhole(self)
	Global.connect("destroy_blackhole", self, "destory")
	$exp_ball.mesh.radius = 0.1 #bugfix
	$exp_ball.mesh.height = 0.1 #bugfix
	

func set_blackhol_size(value: float):
	blackhole_radius = value
	$blackhole/black_hole.scale = value * Vector3(1,1,1)
	$blackhole/CollisionShape.shape.radius = value
	


func _on_despawner_body_entered(body):
	body.queue_free()


func _on_blackhole_body_entered(body):
	if body.get_class() != "Asteroid":
		return
	emit_signal("asteroid_entered", body)


func destory():
	print("kaboom !!!!!")
	destorying = true
	$exploooooosion.play()
	$AnimationPlayer.play("explosion")

func _on_exploooooosion_finished():
	emit_signal("destoryed")
