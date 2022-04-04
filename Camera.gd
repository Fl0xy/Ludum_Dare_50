extends Camera

export var decay = 0.8  # How quickly the shaking stops [0, 1].
export var max_offset = Vector3(10, 7.5, 4)  # Maximum hor/ver shake in pixels.
export var max_roll = 0.1  # Maximum rotation in radians (use sparingly).

var trauma = 0.0  # Current shake strength.
var trauma_power = 2  # Trauma exponent. Use [2, 3].
onready var rng = RandomNumberGenerator.new()
onready var org_trans = self.translation
onready var org_rot = self.rotation

func _ready():
	rng.randomize()
	Global.camera = self
	Global.connect("destroy_blackhole", self, "on_destory")
	
func _process(delta):
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
		
func shake():
	var amount = pow(trauma, trauma_power)
	rotation.y = max_roll * amount * rng.randf_range(-1, 1)
	translation.x = max_offset.x * amount * rng.randf_range(-1, 1)
	translation.z = max_offset.z * amount * rng.randf_range(-1, 1)

func add_shake(amount):
	trauma = min(trauma + amount, 1.0)

func on_destory():
	var p = self.get_parent()
	var pp = self.get_parent().get_parent()
	
	self.translation = p.translation
	
	self.get_parent().remove_child(self)
	pp.add_child(self)
	$Tween.interpolate_property(self, "translation", self.translation, Vector3(0, self.translation.y, 0), 2 ,Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	
