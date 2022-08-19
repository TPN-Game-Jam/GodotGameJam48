extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var monolith_found = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Lander_body_entered(body):
	if monolith_found:
		get_node("../Rover/UI/Label").text = "Thank you for playing"
	
