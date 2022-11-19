extends Node2D


onready var grass_holder = $GrassHolder
var grass = preload("res://scenes/Grass.tscn")

var grass_amount = 10
var tile_size = 16 * 5


func _ready():
	randomize()
	for i in grass_amount:
		var pos = Vector2((randi() % 1920 / tile_size) * tile_size, (randi() % 1080 / tile_size) * tile_size)
		var grass_instance = grass.instance()
		grass_instance.position = pos
		grass_holder.add_child(grass_instance)
