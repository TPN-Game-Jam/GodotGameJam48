extends RigidBody2D 

var wheels = []
var speed = 100
var break_power = 100
var max_speed = 100
var last_position : Vector2 = Vector2()
var save_position : Vector2 = Vector2()
var position_reset = false

func _ready():
	get_node("UI/Label").text = "A and D to move. Don't 'jump' else you'll escape the Moon!"
	wheels = get_tree().get_nodes_in_group("wheel")

func _physics_process(delta):    
	if Input.is_action_pressed("action_right"):
		for wheel in wheels:
			if wheel.angular_velocity < max_speed:
				wheel.apply_torque_impulse(speed * delta * 100)
				
	if Input.is_action_pressed("action_left"):
		for wheel in wheels:
			if wheel.angular_velocity > -max_speed:
				wheel.apply_torque_impulse(-break_power * delta * 100)


func _integrate_forces(state):
	if position_reset:
		#print("position reset:", save_position.x, save_position.y)
		position_reset = false
		state.linear_velocity.normalized() * 0
		for wheel in wheels:
			wheel.linear_velocity = state.linear_velocity.normalized() * 0
			
	
func _on_Timer_timeout():
	get_node("UI/Label").text = ""
	
	save_position = last_position
	if save_position == Vector2(0, 0):
		#print("save position is vector2")
		save_position = get_node(".").position
	
	last_position = get_node(".").position
	#print("last_position: ", last_position.x, last_position.y)
	
