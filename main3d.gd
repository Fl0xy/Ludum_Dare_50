extends Spatial


func _ready():
	Global.connect("destroy_blackhole", self, "on_destory")
	call_deferred("spawn_helper")

func spawn_helper():
	$asteroid_placer.spawn()
	
func _physics_process(delta):
	if $ship != null:
		var camera_pos: Vector3 = $ship.translation
		camera_pos.y = $cc.translation.y
		$cc.translation = camera_pos

func on_destory():
	$AudioStreamPlayer.stop()
