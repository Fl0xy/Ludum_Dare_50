extends Node

const blackhole_shrink = 0.1

var blackhole_node
var blackhole_size

var total_time
var start_time

func _ready():
	pass

func set_backhole(blackhole):
	blackhole_node = blackhole

func start_game():
	total_time = 0
	start_time = OS.get_time()

func pause_game():
	total_time += OS.get_time() - start_time
	
func unpause_game():
	start_time = OS.get_time()

func end_game():
	pause_game()
	

