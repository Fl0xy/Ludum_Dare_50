extends RigidBody

var connected: bool = false
var connected_asteroid: Node

func _physics_process(delta):
	var basis = global_transform.basis
	if Input.is_action_pressed("ui_up"):
		apply_impulse(basis.xform($thruster_back.translation), basis.xform($thruster_back.thruster_vector))
	if Input.is_action_pressed("ui_right"):
		apply_impulse(basis.xform($thruster_left1.translation), basis.xform($thruster_left1.thruster_vector))
		apply_impulse(basis.xform($thruster_left2.translation), basis.xform($thruster_left2.thruster_vector))
	if Input.is_action_pressed("ui_left"):
		apply_impulse(basis.xform($thruster_right1.translation), basis.xform($thruster_right1.thruster_vector))
		apply_impulse(basis.xform($thruster_right2.translation), basis.xform($thruster_right2.thruster_vector))
	if Input.is_action_pressed("ui_down"):
		apply_impulse(basis.xform($thruster_front.translation), basis.xform($thruster_front.thruster_vector))
	if Input.is_action_pressed("ui_rotate_right"):
		apply_impulse(basis.xform($thruster_right2.translation), basis.xform($thruster_right2.thruster_vector))
		apply_impulse(basis.xform($thruster_left1.translation), basis.xform($thruster_left1.thruster_vector))
	if Input.is_action_pressed("ui_rotate_left"):
		apply_impulse(basis.xform($thruster_right1.translation), basis.xform($thruster_right1.thruster_vector))
		apply_impulse(basis.xform($thruster_left2.translation), basis.xform($thruster_left2.thruster_vector))
	if Input.is_action_just_pressed("ui_accept"):
		if !connected and connected_asteroid != null:
			$grabber/PinJoint.set_node_a(self.get_path())
			$grabber2/PinJoint.set_node_a(self.get_path())
			$grabber/PinJoint.set_node_b(connected_asteroid.get_path())
			$grabber2/PinJoint.set_node_b(connected_asteroid.get_path())
			connected = true;
		elif connected:
			$grabber/PinJoint.set_node_a(NodePath(""))
			$grabber2/PinJoint.set_node_a(NodePath(""))
			$grabber/PinJoint.set_node_b(NodePath(""))
			$grabber2/PinJoint.set_node_b(NodePath(""))
			connected = false;


func _on_grabber_body_entered(body: Node):
	print(body)
	connected_asteroid = body

func _on_grabber_body_exited(body: Node):
	if (connected_asteroid == body):
		connected_asteroid = null
