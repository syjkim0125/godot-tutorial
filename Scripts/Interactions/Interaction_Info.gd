extends Node

@onready var destination = $Marker2D.get_global_position()
@onready var info_card_position: Marker2D = $CardMarker2D
@export var interaction_animation: String
@export var text = "A pile of wooden boxes and barrels. A fallen barrel reveals a compilation of fur."
@export var right: bool
var interaction_type = "info"
var infoCard

func interact():
	infoCard.toggle(true)
