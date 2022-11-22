extends Node2D


onready var grass_holder = $GrassHolder
onready var label = $Debug
onready var player = $Player


var grass = preload("res://scenes/Grass.tscn")
var bullet = preload("res://scenes/Bullet.tscn")


var grass_amount = 10
var tile_size = 16 * 5


func _ready():
	randomize()
	for i in grass_amount:
		var pos = Vector2((randi() % 1920 / tile_size) * tile_size, (randi() % 1080 / tile_size) * tile_size)
		var grass_instance = grass.instance()
		grass_instance.position = pos
		grass_holder.add_child(grass_instance)


func _process(delta):
	var mouse = get_local_mouse_position()
	var mouse_offset = mouse - player.position
	label.rect_position = Vector2(int(mouse.x), int(mouse.y)) + Vector2(50, 50)
	
	if mouse.distance_to(player.position) < 300:
		label.text = "bingus"
	else:
		label.text = String(mouse_offset.x) + ", " + String(mouse_offset.y)


func _on_Player_shoot(end_of_barrell):
	var bullet_instance = bullet.instance()
	bullet_instance.global_position = end_of_barrell.global_position
	add_child(bullet_instance)
