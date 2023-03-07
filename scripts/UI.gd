extends CanvasLayer

var score = 0

onready var label = $Label

func _ready():
	label.text = "Score: " + str(score)
