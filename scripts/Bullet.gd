extends Area2D


var vel = Vector2.ZERO
var speed = 600


func _ready():
	var mouse = get_global_mouse_position()
	vel = vel.direction_to(mouse)


func _physics_process(delta):
	position += vel * speed * delta
