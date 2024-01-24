extends Control

enum {IDLE, MOVE, CLIMB, INTERACT}

#@onready var nav2D : NavigationRegion2D = $NavigationRegion2D
#@onready var line2D : Line2D = $Line2D
#@onready var player : AnimatedSprite2D = $Player

func _input(event):
	if !Input.is_action_just_pressed("ui_leftMouseClick"):
		return
		
	var new_path = $NavigationRegion2D.get_simple_map($Player.get_global_position(), get_global_mouse_position())
	
	$Line2D.points = new_path
	$Player.path = new_path
	$Player.change_state(MOVE)
