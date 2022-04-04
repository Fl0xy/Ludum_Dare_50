extends Control


func _ready():
	#$Label.modulate.a = 0
	pass
	
func display_notification(msg: String):
	$Label.text = msg
	$AnimationPlayer.play("in")
	$Timer.start()

func _on_Timer_timeout():
	$AnimationPlayer.play("in", -1, -1, true)
