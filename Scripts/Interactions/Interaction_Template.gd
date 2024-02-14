extends Node

@onready var destination = $Marker2D.get_global_position()
@export var interaction_animation: String
var interaction_type = "box"

func interact():
	$Sprite2D/AnimationPlayer.play("Interact")
