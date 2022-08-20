extends Area2D


var monolith_found = false

func _on_Lander_body_entered(body):
	if monolith_found:
		get_node("../Rover/UI/Label").text = "Thank you for playing"
	
