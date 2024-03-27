extends PanelContainer

@onready var itemTexture: TextureRect = $Item

func _get_drag_data(at_position):
	set_drag_preview(get_preview())
	return itemTexture
	
func _can_drop_data(_pos, data):
	return data is TextureRect
	
func _drop_data(_pos, data):
	var temp = itemTexture.texture
	itemTexture.texture = data.texture
	data.texture = temp

func get_preview():
	var previewTexture = TextureRect.new()
	
	previewTexture.texture = itemTexture.texture
	previewTexture.expand_mode = 1
	previewTexture.size = itemTexture.size
	previewTexture.position = itemTexture.position - itemTexture.size / 2
	
	var preview = Control.new()
	preview.add_child(previewTexture)
	
	return preview
