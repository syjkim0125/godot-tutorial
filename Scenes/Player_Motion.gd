extends CharacterBody2D

var speed: int = 250
var path: PackedVector2Array = []

enum {IDLE, MOVE, CLIMB, INTERACT}
var state = IDLE
var is_climbing: bool

func _ready():
	is_climbing = false

func _process(delta):
	var walk_distance = speed * delta
	
	match state:
		IDLE:
			pass
		MOVE:
			move_along_path(walk_distance)
		CLIMB:
			climb_along_path(walk_distance)
	pass
	
func move_along_path(distance):
	var last_point = $"../Player".position
	
	if(is_climbing):
		$"../Player".change_state(CLIMB)
	
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
	
func climb_along_path(distance):
	var last_point = $"../Player".position
	
	if(last_point.y > path[0].y):
		$PlayerSprite.play("climb")
	if(last_point.y < path[0].y):
		$PlayerSprite.play("climb", true)
		
	if(!is_climbing):
		$"../Player".change_state(MOVE)
	
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

	match state:
		IDLE:
			if(!is_climbing):
				$PlayerSprite.play("idle")
			if(is_climbing):
				$PlayerSprite.play("climb_idle")
		MOVE:
			$PlayerSprite.play("move")
			
	set_process(true)
			
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
