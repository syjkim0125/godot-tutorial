extends Control

enum {IDLE, MOVE, CLIMB, INTERACT}
var path: PackedVector2Array = []

func _ready():
	call_deferred("setup_nav_server")

func setup_nav_server():
	$WorldEnvironment.setup_nav_server()

func _input(event):
	if !Input.is_action_just_pressed("ui_leftMouseClick"):
		return
		
	var new_path = $WorldEnvironment.update_nav_path(path, $Player.position, get_global_mouse_position())
	
	$Player.path = new_path
	$Player.is_going_to_interact = false
	
	if(!$Player.is_climbing):
		$Player.change_state(MOVE)
	else:
		$Player.change_state(CLIMB)
