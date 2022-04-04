extends Spatial

export(Vector3) var thruster_vector
export(NodePath) var audio setget set_audio
var audio_node
var old_vis: bool = false

func _ready():
	if audio:
		set_audio(audio)
	
func _process(delta):
	if audio_node && self.visible != old_vis:
		audio_node.playing = self.visible
		old_vis = self.visible
		
func set_audio(value: NodePath):
	if value != "":
		audio = value
		audio_node = get_node(audio)
		

