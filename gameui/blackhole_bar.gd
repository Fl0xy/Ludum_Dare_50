extends Node2D

const width = 200
var pluseC: float = 0

func _process(delta):
	set_blackhole_size(1 - Global.blackhole_factor)
	self.pluseC = fmod((self.pluseC + delta),  2)
	var ma = (abs(1-pluseC) * -1)+1
	$warning_tosmall.modulate.a = ma
	$warning_tobig.modulate.a = ma
	
func set_blackhole_size(value: float):
	if value < 0.2:
		$warning_tosmall.visible = true
	else:
		$warning_tosmall.visible = false
		
	if value > 0.8:
		$warning_tobig.visible = true
	else:
		$warning_tobig.visible = false
	
	var posx = width * value
	$bar.scale = Vector2(posx, 25)
	$warning_tobig.position.x = posx - $warning_tobig.texture.get_width()
