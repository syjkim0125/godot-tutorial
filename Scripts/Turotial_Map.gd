extends WorldEnvironment

var map: RID

func setup_nav_server():
	map = NavigationServer2D.map_create()
	NavigationServer2D.map_set_active(map, true)
	NavigationServer2D.map_set_cell_size(map, 1)
	
	var region = NavigationServer2D.region_create()
	NavigationServer2D.region_set_transform(region, Transform2D())
	NavigationServer2D.region_set_map(region, map)
	
	var nav_poly = NavigationMesh.new()
	nav_poly = $NavigationRegion2D.navigation_polygon
	NavigationServer2D.region_set_navigation_polygon(region, nav_poly)

func update_nav_path(path, start_position, end_position):
	path = NavigationServer2D.map_get_path(map, start_position, end_position, true)

	$Line2D.clear_points()

	for i in path:
		$Line2D.add_point(i)

	path.remove_at(0)
	return path


func _on_climb_area_body_entered(body):
	if body.get_name() != "Player":
		return
	$"../Player".is_climbing = true
	pass


func _on_climb_area_body_exited(body):
	if body.get_name() != "Player":
		return
	$"../Player".is_climbing = false
	pass


func _on_interaction_objects_input_event(viewport, event, shape_idx):
	if !Input.is_action_just_pressed("ui_leftMouseClick"):
		return
		
	$"../Player".is_going_to_interact = true
	$"../Player".interactable_object = $InteractionObjects.get_child(shape_idx)
	$"../Player".path = $"../WorldEnvironment".update_nav_path($"../../Main".path, $"../Player".get_global_position(), $InteractionObjects.get_child(shape_idx).destination)
