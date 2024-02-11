extends Node

@onready var destination = $Marker2D.get_global_position()

func interact():
	$Sprite2D/AnimationPlayer.play("Interact")
