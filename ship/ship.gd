extends RigidBody

var connected: bool = false
var connected_asteroid: Node

func _ready():
	Global.connect("destroy_blackhole", self, "on_destory")

func _physics_process(delta):
	var basis = global_transform.basis
	
	$thruster_back.visible = false
	$thruster_front.visible = false
	$thruster_left1.visible = false
	$thruster_left2.visible = false
	$thruster_right1.visible = false
	$thruster_right2.visible = false
	$thruster_boost.visible = false
	
	if Input.is_action_pressed("ui_up"):
		apply_impulse(basis.xform($thruster_back.translation), basis.xform($thruster_back.thruster_vector))
		$thruster_back.visible = true
		if Input.is_action_pressed("ui_boost"):
			apply_impulse(basis.xform($thruster_boost.translation), basis.xform($thruster_boost.thruster_vector))	
			$thruster_boost.visible = true
	if Input.is_action_pressed("ui_right"):
		apply_impulse(basis.xform($thruster_right1.translation), basis.xform($thruster_right1.thruster_vector))
		apply_impulse(basis.xform($thruster_right2.translation), basis.xform($thruster_right2.thruster_vector))
		$thruster_right1.visible = true
		$thruster_right2.visible = true
	if Input.is_action_pressed("ui_left"):
		apply_impulse(basis.xform($thruster_left1.translation), basis.xform($thruster_left1.thruster_vector))
		apply_impulse(basis.xform($thruster_left2.translation), basis.xform($thruster_left2.thruster_vector))
		$thruster_left1.visible = true
		$thruster_left2.visible = true
	if Input.is_action_pressed("ui_down"):
		apply_impulse(basis.xform($thruster_front.translation), basis.xform($thruster_front.thruster_vector))
		$thruster_front.visible = true
	if Input.is_action_pressed("ui_rotate_right"):
		apply_impulse(basis.xform($thruster_right1.translation), basis.xform($thruster_right1.thruster_vector))
		apply_impulse(basis.xform($thruster_left2.translation), basis.xform($thruster_left2.thruster_vector))
		$thruster_right1.visible = true
		$thruster_left2.visible = true
	if Input.is_action_pressed("ui_rotate_left"):
		apply_impulse(basis.xform($thruster_right2.translation), basis.xform($thruster_right2.thruster_vector))
		apply_impulse(basis.xform($thruster_left1.translation), basis.xform($thruster_left1.thruster_vector))
		$thruster_right2.visible = true
		$thruster_left1.visible = true
	if Input.is_action_just_pressed("ui_accept"):
		if !connected and connected_asteroid != null:
			$PinJoint.set_node_a(self.get_path())
			$PinJoint2.set_node_a(self.get_path())
			$PinJoint.set_node_b(connected_asteroid.get_path())
			$PinJoint2.set_node_b(connected_asteroid.get_path())
			connected = true;
			$connect.play()
		elif connected:
			$PinJoint.set_node_a(NodePath(""))
			$PinJoint2.set_node_a(NodePath(""))
			$PinJoint.set_node_b(NodePath(""))
			$PinJoint2.set_node_b(NodePath(""))
			connected = false;
			$disconnect.play()



func _on_grabber_body_entered(body: Node):
	print(body)
	connected_asteroid = body

func _on_grabber_body_exited(body: Node):
	if (connected_asteroid == body):
		connected_asteroid = null

func on_destory():
	$Listener.clear_current()
