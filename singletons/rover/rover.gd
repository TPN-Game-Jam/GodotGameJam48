extends RigidBody2D 

var wheels = []
var speed = 100
var break_power = 100
var max_speed = 100

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
				
			#turn += 1


#extends RigidBody2D
#
#var _velocity = Vector2.ZERO
#
#var _acceleration = Vector2.ZERO
#var _engine_power = 400  # Forward acceleration force.
#var _braking = -450
#
#func _physics_process(delta):
#    get_input()
#    _velocity += _acceleration * delta
#    _velocity = move_and_slide(_velocity)
#
#
#func get_input():
#    var turn = 0
#    if Input.is_action_pressed("action_right"):
#        turn += 1
#    if Input.is_action_pressed("action_left"):
#        turn -= 1
#
#    if Input.is_action_pressed("action_forward"):
#        _acceleration = transform.x * _engine_power
#
#    if Input.is_action_pressed("action_backward"):
#        _acceleration = transform.x * _braking


func _on_Timer_timeout():
	get_node("UI/Label").text = ""
