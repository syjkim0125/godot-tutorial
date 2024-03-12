extends Node2D

@onready var scrollContainer: ScrollContainer = $InventoryContainer/ScrollContainer

func _on_left_arrow_button_pressed():
	var value = scrollContainer.get_h_scroll()
	scrollContainer.set_h_scroll(value - 200)


func _on_right_arrow_button_pressed():
	var value = scrollContainer.get_h_scroll()
	scrollContainer.set_h_scroll(value + 200)
