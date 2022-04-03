extends Node

const blackhole_shrink = 0.1
const blackhole_max_mass = 1000
const blackhole_min_mass = 100

var blackhole_mass: float setget set_blackhole_mass
var blackhole_node: Node

var running: bool = false
var total_time
var start_time

func _ready():
	pass

func _process(delta):
	if not running:
		return
	self.blackhole_mass -= blackhole_shrink * delta

func set_backhole(blackhole):
	blackhole_node = blackhole
	blackhole_mass = blackhole_max_mass / blackhole.blackhole_max_radius * blackhole.blackhole_radius
	blackhole.connect("asteroid_entered", self, "add_mass_to_blackhole")

func start_game():
	total_time = 0
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
	if blackhole_node != null:
		blackhole_node.blackhole_radius = blackhole_node.blackhole_max_radius / blackhole_max_mass * blackhole_mass
