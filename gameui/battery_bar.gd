extends Node2D

const width = 100
export(float) var battery: float = 1 setget set_battery

func _ready():
	pass
	
func _process(delta):
	self.battery = clamp(Global.battery / Global.battery_max, 0 , 1)

func set_battery(value: float):
	battery = value
	var scalex = width * battery
	$bar.scale = Vector2(scalex, 20)
	
	$FTL/disable.visible = !(battery >= 1)
