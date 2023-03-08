extends Control


onready var highscore = $Highscore
var highscore_file = "res://highscore.txt"


func _ready():
	var f = File.new()
	f.open(highscore_file, File.READ)
	highscore.text = "Highscore: " + f.get_line()


func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")
	

func _unhandled_input(event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
