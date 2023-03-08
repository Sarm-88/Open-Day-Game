extends CanvasLayer


onready var score = $Score
onready var timer_label = $TimerLabel
onready var timer = $TimerLabel/Timer

func _ready():
	Globals.score = 0
	score.text = "Score: " + str(Globals.score)


func _process(delta):
	score.text = "Score: " + str(Globals.score)
	timer_label.text = "Time Remaining: " + str(int(timer.time_left))


func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/GameOver.tscn")
