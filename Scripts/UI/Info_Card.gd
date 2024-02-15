extends Node

func toggle(show):
	print("card interacted!")
	if(show):
		$"../InfoCard".visible = true
	else:
		$"../InfoCard".visible = false
