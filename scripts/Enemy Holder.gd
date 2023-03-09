extends Node2D

onready var timer = $Timer
var enemy = load("res://scenes/Enemy.tscn")


func _on_Timer_timeout():
	add_child(enemy.instance())
	timer.wait_time = rand_range(0.3, 0.7)
