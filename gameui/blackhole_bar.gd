tool
extends Node2D

const width = 200

export(float) var max_civ_energy: float = 100
export(float) var civ_energy: float = 50 setget set_civ_energy

export(float) var max_blackhole_size: float = 28
export(float) var blackhole_size: float = 19 setget set_blackhole_size



func _ready():
	set_civ_energy(civ_energy)
	set_blackhole_size(blackhole_size)


func set_civ_energy(value: float):
	civ_energy = value
	var posx = width / max_civ_energy * civ_energy
	$civ_energy.position = Vector2(posx, -2)
	
func set_blackhole_size(value: float):
	blackhole_size = value
	var posx = width - (width / max_blackhole_size * blackhole_size)
	$bar.scale = Vector2(posx, 25)
