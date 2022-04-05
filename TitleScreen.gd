extends Spatial

export var followup_scene : PackedScene = load("res://StartMenu.tscn")

func _input(event):
	if event is InputEventKey:
		var ins = followup_scene.instance()
		get_tree().root.add_child(ins)
		queue_free()
