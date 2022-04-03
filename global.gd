extends Node

const blackhole_max_mass: float = 1000.0
const blackhole_min_mass: float = 50.0

var blackhole_mass: float = 200 setget set_blackhole_mass
var blackhole_node: Node

const battery_max: float = 100000.0
var battery: float = 100

var civ_power: float = 300

var running: bool = false
var total_time
var start_time

var debug_mass_lose: float = 0

signal destroy_blackhole

func _ready():
	pass

func _process(delta):
	if not running:
		return
	
	var energy = (blackhole_max_mass - blackhole_mass) * 0.001 * delta
	
	self.blackhole_mass -= energy
	debug_mass_lose -= energy
	
	if blackhole_mass < blackhole_min_mass:
		emit_signal("destroy_blackhole")
		
	battery -= civ_power * delta
	battery += energy
	
	

func set_backhole(blackhole):
	blackhole_node = blackhole
	set_blackhole_mass(blackhole_mass)
	blackhole.connect("asteroid_entered", self, "add_mass_to_blackhole")
	blackhole.connect("destoryed", self, "end_game")

func start_game():
	total_time = 0
	start_time = OS.get_unix_time()
	running = true

func pause_game():
	total_time += OS.get_unix_time() - start_time
	running = false
	
func unpause_game():
	start_time = OS.get_unix_time()
	running = true

func end_game():
	pause_game()
	
func add_mass_to_blackhole(asteroid: Asteroid):
	var mass = asteroid.mass * asteroid.energy_mass_multiplyer
	self.blackhole_mass += mass
	print("lost since last: " + str(debug_mass_lose) + "; Added just now: " + str(mass) + " => " + str(mass + debug_mass_lose))
	debug_mass_lose = 0
	
func set_blackhole_mass(value: float):
	blackhole_mass = value
	if blackhole_node != null:
		blackhole_node.blackhole_radius = blackhole_node.blackhole_max_radius / blackhole_max_mass * blackhole_mass
