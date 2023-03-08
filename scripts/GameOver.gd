extends Control


onready var score = $Score
onready var highscore = $Highscore

onready var highscore_file = "res://highscore.txt"


func _ready():
	score.text = "Score: " + str(Globals.score)
	
	var f = File.new()
	f.open(highscore_file, File.READ)
	var highscore_value = f.get_line()
	highscore.text = "Highscore: " + str(highscore_value)
	f.close()
	
	if Globals.score > int(highscore_value):
		f.open(highscore_file, File.WRITE)
		f.store_string(str(Globals.score))
		f.close()
		f.open(highscore_file, File.READ)
		highscore.text = "Highscore: " + f.get_line()
		f.close()
		
	
	
func _on_Button_pressed():
	get_tree().change_scene("res://scenes/Start.tscn")
	

func _unhandled_input(event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
