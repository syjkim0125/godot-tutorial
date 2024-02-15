extends Control

@onready var player: CharacterBody2D = $Player
@onready var worldEnvironment: WorldEnvironment = $WorldEnvironment

enum {IDLE, MOVE, CLIMB, INTERACT}
var path: PackedVector2Array = []

func _ready():
	call_deferred("setup_nav_server")

func setup_nav_server():
	worldEnvironment.setup_nav_server()

func _input(event):
	if !Input.is_action_just_pressed("ui_leftMouseClick"):
		return
		
	var new_path = worldEnvironment.update_nav_path(path, player.get_global_position(), get_global_mouse_position())
	
	player.path = new_path
	player.is_going_to_interact = false
	
	if(!player.is_climbing):
		player.change_state(MOVE)
	else:
		player.change_state(CLIMB)
