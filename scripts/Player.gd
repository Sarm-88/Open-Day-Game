extends KinematicBody2D

var v: Vector2
var speed = 500


func _ready():
	v = Vector2.ZERO
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()


func _physics_process(delta):
	v.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	v.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	move_and_slide(v.normalized() * speed)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		print("Collided with: ", collision.collider.name)
