extends WorldEnvironment

@onready var navReg: NavigationRegion2D = $NavigationRegion2D

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
