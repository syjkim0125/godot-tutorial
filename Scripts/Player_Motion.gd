extends CharacterBody2D

@onready var player: CharacterBody2D = $"../Player"
@onready var playerSprite: AnimatedSprite2D = $PlayerSprite

var speed: int = 250
var path: PackedVector2Array = []

enum {IDLE, MOVE, CLIMB, INTERACT}
var state = IDLE
var is_climbing: bool
var is_going_to_interact: bool
var interactable_object: Node
var interaction_animation: String
var interaction_direction: bool

func _ready():
	is_climbing = false

func _process(delta):
	var walk_distance = speed * delta
	
	match state:
		IDLE:
			is_going_to_interact = false
		MOVE:
			move_along_path(walk_distance)
		CLIMB:
			climb_along_path(walk_distance)
	pass
	
func move_along_path(distance):
	var last_point = player.get_global_position()
	
	if(is_climbing):
		change_state(CLIMB)
	
	if(last_point.x < path[0].x):
		playerSprite.flip_h = false
	if(last_point.x > path[0].x):
		playerSprite.flip_h = true
	
	while path.size():
		var distance_between_points = last_point.distance_to(path[0])
		if distance <= distance_between_points:
			player.set_global_position(last_point.lerp(path[0], distance / distance_between_points))
			return
			
		distance -= distance_between_points
		last_point = path[0]
		path.remove_at(0)
		
	player.set_global_position(last_point)
	if(path.size() == 0):
		if(is_going_to_interact):
			change_state(INTERACT)
		else:
			change_state(IDLE)
	
	set_process(false)
	
func climb_along_path(distance):
	var last_point = player.get_global_position()
	
	if(last_point.y > path[0].y):
		playerSprite.play("climb")
	if(last_point.y < path[0].y):
		playerSprite.play("climb", true)
		
	if(!is_climbing):
		change_state(MOVE)
	
	while path.size():
		var distance_between_points = last_point.distance_to(path[0])
		if distance <= distance_between_points:
			player.set_global_position(last_point.lerp(path[0], distance / distance_between_points))
			return
			
		distance -= distance_between_points
		last_point = path[0]
		path.remove_at(0)
		
	player.set_global_position(last_point)
	if(path.size() == 0):
		change_state(IDLE)
	set_process(false)
	
func change_state(newState):
	state = newState

	match state:
		IDLE:
			if(!is_climbing):
				playerSprite.play("idle")
			if(is_climbing):
				playerSprite.play("climb_idle")
		MOVE:
			playerSprite.play("move")
		INTERACT:
			interactable_object.interact()
			playerSprite.play(interaction_animation)
			face_direction(interaction_direction)
	
	set_process(true)
	
func clear_action():
	interactable_object = null
	is_going_to_interact = false

func _on_ui_close_dialog():
	change_state(IDLE)
	
func face_direction(right):
	if(right):
		playerSprite.flip_h = false
	else:
		playerSprite.flip_h = true
