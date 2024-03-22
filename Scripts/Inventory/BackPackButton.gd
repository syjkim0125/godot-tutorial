extends Button

var openTexture = preload("res://Art/UI/Inventory/BackPackOpen.png")
var closedTexture = preload("res://Art/UI/Inventory/BackPackClosed.png")

func _on_toggled(button_pressed):
	if(button_pressed):
		set_button_icon(openTexture)
	else:
		set_button_icon(closedTexture)
