extends NavigationRegion2D


# Called when the node enters the scene tree for the first time.
@onready var region_id: RID = NavigationServer2D.region_create()
@onready var default_2d_map_rid: RID = get_world_2d().get_navigation_map()
@onready var new_navigation_mesh = NavigationPolygon.new()

func _ready() -> void: 
	var new_vertices = PackedVector2Array([Vector2(0, 0), Vector2(0, 50), Vector2(50, 50), Vector2(50, 0)])
	new_navigation_mesh.vertices = new_vertices
	var new_polygon_indices = PackedInt32Array([0, 1, 2, 3])
	new_navigation_mesh.add_polygon(new_polygon_indices)
	
	NavigationServer2D.region_set_map(region_id, default_2d_map_rid) 
	NavigationServer2D.region_set_navigation_polygon(region_id, new_navigation_mesh)

func get_simple_map(origin, destination):
	NavigationServer2D.map_get_path(get_world_2d().navigation_map, origin, destination, true)
	
	
	




