extends Area2D

onready var sprite = $Sprite
signal dead

var player
var speed

var screen_edges : Array = []

func _ready():
	randomize()
	self.add_to_group("Enemy")
	
	sprite.region_rect.position = Vector2(
		384 + (int(rand_range(0, 8)) * 16),
		16 + (int(rand_range(0, 8)) * 16))
	
	speed = int(rand_range(7, 10))
	
	screen_edges.append(Vector2.ZERO)
	screen_edges.append(Vector2(get_viewport().size.x,0))
	screen_edges.append(Vector2(0,get_viewport().size.y))
	screen_edges.append(get_viewport().size)
	
	position = screen_edges[rand_range(0,screen_edges.size())]

	player = Globals.player
	
	
# warning-ignore:unused_argument
func _physics_process(delta):
	position -= (self.position - player.position).normalized() * speed


func kill(score_value):
	Globals.score += score_value
	emit_signal("dead")
	self.queue_free()


func _on_Enemy_body_entered(body):
	if body.is_in_group("Player"):
		if Globals.score > 0:
			Globals.score -= 10
			self.kill(0)
		else:
			self.kill(0)
			
		body.kill()
