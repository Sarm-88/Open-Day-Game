extends KinematicBody2D


onready var sprite = $Sprite
onready var collision = $CollisionShape2D
onready var anim_player = $AnimationPlayer
onready var camera = $Camera2D

onready var gun = $Gun
onready var gun_sprite = $Gun/Sprite
onready var end_of_barrell = $Gun/Sprite/EndOfBarrell


var bullet = preload("res://scenes/Bullet.tscn")


var speed = 500
var vel = Vector2.ZERO


func _physics_process(delta):
	# Movement
	vel.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	vel.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	move_and_slide(vel.normalized() * speed)
	
	# Player Animation
	if vel:
		anim_player.play("walk")
	else:
		anim_player.play("RESET")
	
	# Gun Aim
	var mouse = get_global_mouse_position()
	gun.look_at(mouse)
	
	if mouse.x < position.x:
		gun_sprite.flip_v = true
	else:
		gun_sprite.flip_v = false
		

func _unhandled_input(event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("shoot"):
		print(get_global_mouse_position())
