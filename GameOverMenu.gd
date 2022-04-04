extends Node2D

export var time_label : NodePath

func _ready():
	get_node(time_label).text = str(Global.total_time) + "sec"


func _on_Exit_pressed():
	get_tree().quit()


func _on_BackToMainMenu_pressed():
	var startscene : PackedScene = load("res://StartMenu.tscn")
	var start = startscene.instance()
	get_tree().root.add_child(start)
	queue_free()


func _on_Retry_pressed():
	Global.start_game()
	queue_free()
