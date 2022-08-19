extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var t = Timer.new()
var left_moon = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	t.set_wait_time(5)
	t.set_one_shot(true)
	
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _process(delta):
	if  left_moon && t.time_left == 0:
		get_tree().reload_current_scene()


func _on_MoonAtmo_body_exited(body):
	get_node("../Rover/UI/Label").text = "Oh no! You jumped too high and escaped the Moon's gravity!"
	
	
	
	t.start()

	
