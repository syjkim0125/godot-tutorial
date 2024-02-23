extends Node

@onready var destination: Vector2 = $Marker2D.get_global_position()
@onready var info_card_position: Vector2 = $CardMarker2D.get_global_position()
@export var interaction_animation: String
@export var text = "A pile of wooden boxes and barrels. A fallen barrel reveals a compilation of fur."
@export var right: bool
var interaction_type = "info"
var infoCard

func interact():
	infoCard.toggle(true)
