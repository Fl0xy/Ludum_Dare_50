extends Node2D


var pluseC: float = 0

func _ready():
	visible = false


func _process(delta):
	if visible:
		self.pluseC = fmod((self.pluseC + delta),  2)
		var ma = (abs(1-pluseC) * -1)+1
		self.modulate.a = ma
	
	if Global.player:
		if Global.battery >= Global.battery_max:
			if Global.player.global_transform.origin.distance_to(Vector3(0,0,0)) < 50:
				visible = true
			else:
				visible = false
			
