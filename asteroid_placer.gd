extends Node

export(NodePath) var root_path: NodePath
export(float) var max_distance: float
export(float) var min_distance: float
export(int) var count: int
export(Array, PackedScene) var assets
export(Array, float) var ratios

func spawn():
	if !get_node(root_path) is Spatial:
		printerr("Root not has to be Spatial")
		return
	if assets.size() == 0:
		printerr("No Assets set")
		return
	if assets.size() != ratios.size():
		printerr("Assets and Ratios need to be the same size")
		return
	if count < 0:
		printerr("count needs to be positive")
		return
	randomize()
	var root_node: Spatial = get_node(root_path)
	var max_ratio: float = 0
	for i in ratios:
		max_ratio += i
		
	for i in count:
		var random_type = rand_range(0, max_ratio)
		var asteroid: Spatial = null
		for x in assets.size():
			if random_type < ratios[x]:
				asteroid = assets[x].instance()
				break
			else:
				random_type -= ratios[x]
		if asteroid == null:
			printerr("this should not happen")
			return
		
		root_node.add_child(asteroid)
		var x: float = rand_range(min_distance, max_distance)
		if randi() % 2 == 0:
			x = -x
		var z: float = rand_range(min_distance, max_distance)
		if randi() % 2 == 0:
			z = -z
		asteroid.translate(Vector3(x,0,z))
	
	
	
	
	
	
