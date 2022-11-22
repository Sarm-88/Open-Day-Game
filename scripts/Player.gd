extends KinematicBody2D


signal shoot


onready var sprite = $Sprite
onready var collision = $CollisionShape2D
onready var anim_player = $AnimationPlayer
onready var camera = $Camera2D

onready var gun = $Gun
onready var gun_sprite = $Gun/Sprite
onready var end_of_barrell = $Gun/EndOfBarrell

onready var shoot_timer = $ShootTimer


var bullet = preload("res://scenes/Bullet.tscn")


var speed = 500
var vel = Vector2.ZERO
var mouse = Vector2.ZERO


var shake_amount = 0


func _physics_process(delta):
	# Movement
	vel.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	vel.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	move_and_slide(vel.normalized() * speed)
	
	# Gun Aim
	mouse = get_global_mouse_position()
	gun.look_at(mouse)


func _process(delta):
	# Gun Flip
	if mouse.x < position.x:
		gun_sprite.flip_v = true
	else:
		gun_sprite.flip_v = false
	
	# Player Animation
	if vel:
		anim_player.play("walk")
	else:
		anim_player.play("RESET")
	
	# Camera Move
	var camera_offset = (mouse - self.position).normalized()
	if mouse.distance_to(self.position) < 300: # Move camera to center if close to player
		camera_offset = Vector2(0, 0)
	
	camera.position = Vector2(camera_offset.x * 30, camera_offset.y * 30)
	
	# Camera Shake
	if shake_amount > 0:
		camera.set_offset(Vector2(
			rand_range(-1.0, 1.0) * shake_amount,
			rand_range(-1.0, 1.0) * shake_amount))
		shake_amount -= 1


func _unhandled_input(event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("shoot"):
		shake_amount = 5
		
		if shoot_timer.is_stopped():
			emit_signal("shoot", end_of_barrell)
			shoot_timer.start()
		
		
