extends Area2D

func _on_MoonAtmo_body_exited(body):
	get_node("../Rover/UI/Label").text = "Oh no! You jumped too high and escaped the Moon's gravity!"

