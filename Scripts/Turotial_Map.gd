extends WorldEnvironment

@onready var main: Control = $"../../Main"
@onready var player: CharacterBody2D = $"../Player"
@onready var navigationRegion2D: NavigationRegion2D = $NavigationRegion2D
@onready var line2D: Line2D = $Line2D
@onready var interactionObjects: Area2D = $InteractionObjects
@onready var ui: CanvasLayer = $"../Ui"
@onready var worldEnvironment: WorldEnvironment = $"../WorldEnvironment"

var map: RID

func setup_nav_server():
	map = NavigationServer2D.map_create()
	NavigationServer2D.map_set_active(map, true)
	NavigationServer2D.map_set_cell_size(map, 1)
	
	var region = NavigationServer2D.region_create()
	NavigationServer2D.region_set_transform(region, Transform2D())
	NavigationServer2D.region_set_map(region, map)
	
	var nav_poly = NavigationMesh.new()
	nav_poly = navigationRegion2D.navigation_polygon
	NavigationServer2D.region_set_navigation_polygon(region, nav_poly)

func update_nav_path(path, start_position, end_position):
	path = NavigationServer2D.map_get_path(map, start_position, end_position, true)

	line2D.clear_points()

	for i in path:
		line2D.add_point(i)

	path.remove_at(0)
	return path

func _on_climb_area_body_entered(body):
	if body.get_name() != "Player":
		return
	player.is_climbing = true
	pass

func _on_climb_area_body_exited(body):
	if body.get_name() != "Player":
		return
	player.is_climbing = false
	pass

func _on_interaction_objects_input_event(viewport, event, shape_idx):
	if !Input.is_action_just_pressed("ui_leftMouseClick") || player.state == player.INTERACT:
		return
		
	player.is_going_to_interact = true
	player.interactable_object = interactionObjects.get_child(shape_idx)
	player.interaction_animation = interactionObjects.get_child(shape_idx).interaction_animation
	
	var interaction_type = interactionObjects.get_child(shape_idx).interaction_type
	
	match interaction_type:
		"info":
			interactionObjects.get_child(shape_idx).infoCard = ui
			ui.infoCardText.text = interactionObjects.get_child(shape_idx).text
			ui.infoCard.global_position = interactionObjects.get_child(shape_idx).info_card_position
			
	player.path = worldEnvironment.update_nav_path(main.path, player.get_global_position(), interactionObjects.get_child(shape_idx).destination)

func _on_animation_player_animation_finished(anim_name):
	player.change_state(player.IDLE)
