extends Node2D

var gamescene : PackedScene = load("res://gameUI.tscn")

func _on_Play_pressed():
	var game = gamescene.instance()
	get_tree().root.add_child(game)
	Global.start_game()
	queue_free()


func _on_Exit_pressed():
	get_tree().quit()


func _on_Fullscreen_pressed():
	OS.window_fullscreen = not OS.window_fullscreen


func _on_ScreenBigger_pressed():
	if OS.window_size.x >= OS.get_screen_size().x:
		return
	OS.window_size += Vector2(640, 360)


func _on_ScreenSmaller_pressed():
	if OS.window_size.x == 640:
		return
	OS.window_size -= Vector2(640, 360)


func _on_VolumeUp_pressed():
	pass # Replace with function body.


func _on_VolumeDown_pressed():
	pass # Replace with function body.


func _on_VolumeMuteToggle_pressed():
	var master_bus_idx = AudioServer.get_bus_index("Master")
	var master_mute = AudioServer.is_bus_mute(master_bus_idx)
	AudioServer.set_bus_mute(master_bus_idx, not master_mute)
