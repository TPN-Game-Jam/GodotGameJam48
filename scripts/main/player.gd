extends KinematicBody2D

var _wheel_base = 70 # Distance from front to rear wheel
var _steering_angle = 60  # Amount that front wheel turns, in degrees

var _velocity = Vector2.ZERO
var _steer_angle

var _engine_power = 400  # Forward acceleration force.

var _acceleration = Vector2.ZERO

var _friction = -0.9
var _drag = -0.0015

var _braking = -450
var _max_speed_reverse = 250

var _slip_speed = 400  # Speed where traction is reduced
var _traction_fast = 0.1  # High-speed traction
var _traction_slow = 0.7  # Low-speed traction


func _physics_process(delta):
    _acceleration = Vector2.ZERO
    get_input()
    apply_friction()
    calculate_steering(delta)
    _velocity += _acceleration * delta
    _velocity = move_and_slide(_velocity)


func get_input():
    var turn = 0
    if Input.is_action_pressed("action_right"):
        turn += 1
    if Input.is_action_pressed("action_left"):
        turn -= 1
        
    _steer_angle = turn * deg2rad(_steering_angle)
    
    if Input.is_action_pressed("action_forward"):
        _acceleration = transform.x * _engine_power
        
    if Input.is_action_pressed("action_backward"):
        _acceleration = transform.x * _braking


func calculate_steering(delta):
    var rear_wheel = position - transform.x * _wheel_base / 2.0
    var front_wheel = position + transform.x * _wheel_base / 2.0
    
    rear_wheel += _velocity * delta
    front_wheel += _velocity.rotated(_steer_angle) * delta
    
    var new_heading = (front_wheel - rear_wheel).normalized()
    var traction = _traction_slow
    if _velocity.length() > _slip_speed:
        traction = _traction_fast
    
    var d = new_heading.dot(_velocity.normalized())
    if d > 0:
        _velocity = _velocity.linear_interpolate(new_heading * _velocity.length(), traction)
    if d < 0:
        _velocity = -new_heading * min(_velocity.length(), _max_speed_reverse)
    
    rotation = new_heading.angle()


func apply_friction():
    if _velocity.length() < 5:
        _velocity = Vector2.ZERO
    var friction_force = _velocity * _friction
    var drag_force = _velocity * _velocity.length() * _drag
    if _velocity.length() < 100:
        friction_force *= 3
        
    _acceleration += drag_force + friction_force    
