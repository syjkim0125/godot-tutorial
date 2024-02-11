extends Sprite2D

@export var low_index: int
@export var high_index: int
@export var y_threshold: float

func _process(delta):
	if($"../../Player".get_global_position().y > y_threshold):
		self.set_z_index(low_index)
	else:
		self.set_z_index(high_index)
	pass
