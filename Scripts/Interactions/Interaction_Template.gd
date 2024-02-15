extends Node

@onready var destination = $Marker2D.get_global_position()
@onready var animationPlayer: AnimationPlayer = $Sprite2D/AnimationPlayer
@export var interaction_animation: String
var interaction_type = "box"

func interact():
	$Sprite2D/AnimationPlayer.play("Interact")
