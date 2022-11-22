extends KinematicBody2D


onready var sprite = $Sprite
onready var collision = $CollisionShape2D
onready var anim_player = $AnimationPlayer
onready var camera = $Camera2D

onready var gun = $Gun
onready var gun_sprite = $Gun/Sprite
onready var end_of_barrell = $Gun/Sprite/EndOfBarrell

onready var label = $Label


var bullet = preload("res://scenes/Bullet.tscn")


var speed = 500
var vel = Vector2.ZERO
var mouse = Vector2.ZERO


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
	print(camera_offset)
	if mouse.distance_to(self.position) < 300:
		camera_offset = Vector2(0, 0)
	
	camera.position = Vector2(camera_offset.x * 30, camera_offset.y * 30)


func _unhandled_input(event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("shoot"):
		print(get_global_mouse_position())
