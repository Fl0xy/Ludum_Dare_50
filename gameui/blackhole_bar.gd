extends Node2D

const width = 200

export(float) var max_civ_energy: float = 1000
export(float) var civ_energy: float = 500 setget set_civ_energy

export(float) var max_blackhole_size: float = 28
export(float) var blackhole_size: float = 19 setget set_blackhole_size

func _ready():
	set_civ_energy(civ_energy)
	set_blackhole_size(blackhole_size)
	
func _process(delta):
	if (Global.blackhole_node != null):
		self.blackhole_size = Global.blackhole_node.blackhole_radius
		self.civ_energy = Global.civ_power


func set_civ_energy(value: float):
	civ_energy = value
	var posx = width / max_civ_energy * civ_energy
	$civ_energy.position = Vector2(posx, -2)
	
func set_blackhole_size(value: float):
	blackhole_size = value
	var posx = width - (width / max_blackhole_size * blackhole_size)
	$bar.scale = Vector2(posx, 25)
