extends Control


func _ready():
	call_deferred("setup_nav_server")

func setup_nav_server():
	$WorldEnvironment.setup_nav_server()
