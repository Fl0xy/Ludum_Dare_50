extends Node2D

func _on_Play_pressed():
	Global.start_game()
	queue_free()


func _on_Exit_pressed():
	get_tree().quit()


func _on_ScreenBigger_pressed():
	if OS.window_size.x >= OS.get_screen_size().x:
		return
	OS.window_size += Vector2(640, 360)


func _on_ScreenSmaller_pressed():
	if OS.window_size.x == 640:
		return
	OS.window_size -= Vector2(640, 360)
	


func _on_ToggleFullscreen_toggled(button_pressed):
	OS.window_size = Vector2(640, 360)
	OS.window_fullscreen = button_pressed
