extends Node2D

const width = 200

export(float) var max_civ_energy: float = 1000
export(float) var civ_energy: float = 500 setget set_civ_energy

export(float) var blackhole_size: float = 0.5 setget set_blackhole_size

func _ready():
	set_civ_energy(civ_energy)
	set_blackhole_size(blackhole_size)
	
func _process(delta):
	self.blackhole_size = 1 - Global.blackhole_factor
	self.civ_energy = Global.civ_power


func set_civ_energy(value: float):
	civ_energy = value
	var posx = width / max_civ_energy * civ_energy
	$civ_energy.position = Vector2(posx, -2)
	
func set_blackhole_size(value: float):
	blackhole_size = value
	var posx = width * blackhole_size
	$bar.scale = Vector2(posx, 25)
