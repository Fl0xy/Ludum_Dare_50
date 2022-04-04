extends Node

var endPackedScene : PackedScene = load("res://GameOverMenu.tscn")
var gamePackedscene : PackedScene = load("res://gameUI.tscn")
var gamescene
var camera

const blackhole_max_mass: float = 1000.0
const blackhole_min_mass: float = 50.0
const blackhole_start_mass: float = 500.0
const blackhole_min_power: float = 1.5
const blackhole_max_power: float = 4.0

var blackhole_energy: float
var blackhole_mass: float setget set_blackhole_mass
var blackhole_node: Node
var blackhole_factor: float setget set_blackhole_factor

const battery_max: float = 2000.0
var battery: float = 200

var civ_power: float = 2

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
	
	blackhole_energy = clamp((blackhole_max_mass - blackhole_mass) * 0.005, blackhole_min_power, blackhole_max_power)
	var energy = blackhole_energy * delta
	
	self.blackhole_mass -= energy
	debug_mass_lose -= energy
	
	if blackhole_mass < blackhole_min_mass:
		emit_signal("destroy_blackhole")
		running = false
		
	battery -= civ_power * delta
	battery += energy
	
	if battery >= battery_max:
		if Input.is_action_just_pressed("ui_jump"):
			print("jump!!!!")
			gamescene.queue_free()
			start_level()
	
	

func set_backhole(blackhole):
	blackhole_node = blackhole
	set_blackhole_mass(blackhole_start_mass)
	blackhole.connect("asteroid_entered", self, "add_mass_to_blackhole")
	blackhole.connect("destoryed", self, "end_game")

func start_game():
	start_level()
	total_time = 0
	start_time = OS.get_unix_time()
	running = true
	
func start_level():
	gamescene = gamePackedscene.instance()
	get_tree().root.add_child(gamescene)

func pause_game():
	total_time += OS.get_unix_time() - start_time
	running = false
	
func unpause_game():
	start_time = OS.get_unix_time()
	running = true

func end_game():
	pause_game()
	gamescene.queue_free()
	get_tree().root.add_child(endPackedScene.instance())
	
func close_level():
	blackhole_node = null
	gamescene.queue_free()
	
	
func add_mass_to_blackhole(asteroid: Asteroid):
	var mass = asteroid.mass * asteroid.energy_mass_multiplyer
	self.blackhole_mass = clamp(blackhole_mass + mass, 0, blackhole_max_mass-1)  
	print("lost since last: " + str(debug_mass_lose) + "; Added just now: " + str(mass) + " [" + str(asteroid.mass) +  "x" + str(asteroid.energy_mass_multiplyer)  + "] => " + str(mass + debug_mass_lose))
	debug_mass_lose = 0
	
func set_blackhole_mass(value: float):
	blackhole_mass = value
	self.blackhole_factor = clamp((blackhole_mass - blackhole_min_mass) / (blackhole_max_mass- blackhole_min_mass),0,1)
		
func set_blackhole_factor(value: float):
	if blackhole_factor > 0.2 && value < 0.2:
		display_notification("The Blackhole is getting to small\nFeed it or we are dommed")
	blackhole_factor = value
		
		
func _input(event):
	if event.is_action("quit"):
		get_tree().quit()
		
func display_notification(text: String):
	print("Displaying: " + text)
	gamescene.display_notification(text)
