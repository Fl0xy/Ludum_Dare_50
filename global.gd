extends Node

const blackhole_shrink = 1
const blackhole_max_mass: float = 1000.0
const blackhole_min_mass: float = 100.0

var blackhole_mass: float = 150 setget set_blackhole_mass
var blackhole_power: float
var blackhole_node: Node

const battery_max: float = 10000.0
var battery: float = 100

var civ_power: float = 300

var running: bool = false
var total_time
var start_time

signal destroy_blackhole

func _ready():
	pass

func _process(delta):
	if not running:
		return
	self.blackhole_mass -= blackhole_shrink * delta
	if blackhole_mass < blackhole_min_mass:
		emit_signal("destroy_blackhole")
		
	battery -= civ_power * delta
	battery += blackhole_power * delta
	
	

func set_backhole(blackhole):
	blackhole_node = blackhole
	set_blackhole_mass(blackhole_mass)
	blackhole.connect("asteroid_entered", self, "add_mass_to_blackhole")
	blackhole.connect("destoryed", self, "end_game")

func start_game():
	total_time = 0
	battery = battery_max / 2
	start_time = OS.get_time()
	running = true

func pause_game():
	total_time += OS.get_time() - start_time
	running = false
	
func unpause_game():
	start_time = OS.get_time()
	running = true

func end_game():
	pause_game()
	
func add_mass_to_blackhole(asteroid: Asteroid):
	self.blackhole_mass += asteroid.mass
	
func set_blackhole_mass(value: float):
	blackhole_mass = value
	blackhole_power = blackhole_max_mass - blackhole_mass
	if blackhole_node != null:
		blackhole_node.blackhole_radius = blackhole_node.blackhole_max_radius / blackhole_max_mass * blackhole_mass
