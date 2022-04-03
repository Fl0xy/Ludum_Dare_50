extends Node2D


func _ready():
	$Time.text = str(Global.total_time) + "sec"


func _on_Exit_pressed():
	get_tree().quit()


func _on_BackToMainMenu_pressed():
	var startscene : PackedScene = load("res://StartMenu.tscn")
	var start = startscene.instance()
	get_tree().root.add_child(start)
	queue_free()


func _on_Retry_pressed():
	var gamescene : PackedScene = load("res://gameUI.tscn")
	var game = gamescene.instance()
	get_tree().root.add_child(game)
	queue_free()
