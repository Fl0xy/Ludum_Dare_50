tool
extends Node2D

const width = 100

export(float) var max_battery: float = 100
export(float) var battery: float = 50 setget set_battery

func _ready():
	pass # Replace with function body.


func set_battery(value: float):
	battery = value
	var scalex = width / max_battery * battery
	$bar.scale = Vector2(scalex, 20)
	
	$FTL/disable.visible = !(battery >= max_battery)
