extends Node2D


onready var label = $Debug
onready var player = $Player
onready var score = $UI/Label

onready var camera = $Camera2D


var bullet = preload("res://scenes/Bullet.tscn")


var grass_amount = 10
var tile_size = 16 * 5


func _ready():
	player.camera = camera
	randomize()
	

func _process(delta):
	var mouse = get_local_mouse_position()
	var mouse_offset = mouse - player.position
	label.rect_position = Vector2(int(mouse.x), int(mouse.y)) + Vector2(50, 50)
	
	if mouse.distance_to(player.position) < 300:
		label.text = "radius"
	else:
		label.text = String(mouse_offset.x) + ", " + String(mouse_offset.y)


func _on_Player_shoot(end_of_barrell):
	var bullet_instance = bullet.instance()
	bullet_instance.global_position = end_of_barrell.global_position
	add_child(bullet_instance)
