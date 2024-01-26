extends CharacterBody2D


@onready var navReg: NavigationRegion2D = $"../NavigationRegion2D"
@onready var nav: NavigationAgent2D = $NavigationAgent2D

var speed: int = 250
var path: PackedVector2Array = []
var map: RID

enum {IDLE, MOVE, CLIMB, INTERACT}
var state = IDLE

func _ready():
	call_deferred("setup_nav_server")
	
func _unhandled_input(event):
	if not event.is_action_pressed('ui_leftMouseClick'):
		return
	update_nav_path($"../Player".position, get_global_mouse_position())

func setup_nav_server():
	map = NavigationServer2D.map_create()
	NavigationServer2D.map_set_active(map, true)
	NavigationServer2D.map_set_cell_size(map, 1)
	
	var region = NavigationServer2D.region_create()
	NavigationServer2D.region_set_transform(region, Transform2D())
	NavigationServer2D.region_set_map(region, map)
	
	var nav_poly = NavigationMesh.new()
	nav_poly = $"../NavigationRegion2D".navigation_polygon
	NavigationServer2D.region_set_navigation_polygon(region, nav_poly)
	
func update_nav_path(start_position, end_position):
	path = NavigationServer2D.map_get_path(map, start_position, end_position, true)
	
	$"../Line2D".clear_points()
	
	for i in path:
		$"../Line2D".add_point(i)
		
	path.remove_at(0)
	$"../Player".change_state(MOVE)
	set_process(true)

func _process(delta):
	var walk_distance = speed * delta
#	move_along_path(walk_distance)
	match state:
		IDLE:
			pass
		MOVE:
			move_along_path(walk_distance)
	pass
	
func move_along_path(distance):
	var last_point = $"../Player".position
	
	if(last_point.x < path[0].x):
		$PlayerSprite.flip_h = false
	if(last_point.x > path[0].x):
		$PlayerSprite.flip_h = true
	
	while path.size():
		var distance_between_points = last_point.distance_to(path[0])
		if distance <= distance_between_points:
			$"../Player".position = last_point.lerp(path[0], distance / distance_between_points)
			return
			
		distance -= distance_between_points
		last_point = path[0]
		path.remove_at(0)
		
	$"../Player".position = last_point
	if(path.size() == 0):
		$"../Player".change_state(IDLE)
	set_process(false)
	
func change_state(newState):
	state = newState
	
	print(state)

	match state:
		IDLE:
			$PlayerSprite.play("idle")
		MOVE:
			$PlayerSprite.play("move")
