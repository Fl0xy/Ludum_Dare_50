extends RigidBody

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
		#apply_impulse($TF.position, Vector2(0, 10))
		pass
	if Input.is_action_pressed("ui_rotate_right"):
		apply_impulse(basis.xform($thruster_right2.translation), basis.xform($thruster_right2.thruster_vector))
		apply_impulse(basis.xform($thruster_left1.translation), basis.xform($thruster_left1.thruster_vector))
	if Input.is_action_pressed("ui_rotate_left"):
		apply_impulse(basis.xform($thruster_right1.translation), basis.xform($thruster_right1.thruster_vector))
		apply_impulse(basis.xform($thruster_left2.translation), basis.xform($thruster_left2.thruster_vector))
