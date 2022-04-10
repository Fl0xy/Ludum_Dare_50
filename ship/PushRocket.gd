extends RigidBody

var boost: bool = false setget set_boost

func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	var basis = global_transform.basis
	if boost:
		apply_impulse(basis.xform($thruster_boost.translation), basis.xform($thruster_boost.thruster_vector))
	else:
		apply_impulse(basis.xform($thruster_back.translation), basis.xform($thruster_back.thruster_vector))


func _on_Area_body_entered(body):
	if body.get_class() == "Asteroid":
		$PinJoint.set_node_a(self.get_path())
		$PinJoint.set_node_b(body.get_path())
		$PinJoint2.set_node_a(self.get_path())
		$PinJoint2.set_node_b(body.get_path())
		self.boost = true

func set_boost(value: bool):
	boost = value
	if boost:
		$thruster_boost.visible = true
		$thruster_back.visible = false
	else:
		$thruster_boost.visible = false
		$thruster_back.visible = true
