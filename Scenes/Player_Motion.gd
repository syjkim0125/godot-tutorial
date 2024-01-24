extends CharacterBody2D


var destination = Vector2()
var distance = Vector2()
var snapPosition = Vector2()

var path : PackedVector2Array

@export var speed = 250

enum {IDLE, MOVE, CLIMB, INTERACT}

var state = IDLE

var margin = 1

func _ready():
	destination = position
	
func _process(delta):
	var move_distance = speed * delta
	
	match state:
		IDLE:
			pass
		MOVE:
			move_along_path(move_distance)
	pass
	
func move_along_path(distance):
	var starting_point : = position
	
	if(starting_point.x < path[0].x):
		$Player.flip_h = false
	if(starting_point.x > path[0].x):
		$Player.flip_h = true
	
	for i in range(path.size()):
		var distance_to_next : = starting_point.distance_to(path[0])
		
		if(distance <= distance_to_next):
			position = starting_point.lerp(path[0], distance / distance_to_next)
			break
		
		path.clear()
		
		if(path.size() == 0):
			$Player.change_state(IDLE)
	
	pass
	
func change_state(newState):
	state = newState
	
	match state:
		IDLE:
			$Player.IDLE
		MOVE:
			$Player.MOVE
			
#func _process(delta):
#	if(position != destination):
#		distance = Vector2(destination - position)
#		velocity.x = distance.normalized().x * speed
#		velocity.y = distance.normalized().x * 0
#		move_and_slide()
#
#		if(distance.length() < margin):
#			set_position(snapPosition)
#
#	if(destination.x > position.x):
#		$Player_Sprite.flip_h = false
#	if(destination.x < position.x):
#		$Player_Sprite.flip_h = true
#
#	pass

#func _input(event):
#	if Input.is_action_pressed("ui_leftMouseClick"):
#		destination = get_global_mouse_position()
#		snapPosition.x = destination.x
#		snapPosition.y = position.y
