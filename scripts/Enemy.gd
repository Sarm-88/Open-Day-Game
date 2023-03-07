extends Area2D

onready var sprite = $Sprite

var player
var speed

var screen_edges : Array = []

func _ready():
	randomize()
	self.add_to_group("Enemy")
	
	sprite.region_rect.position = Vector2(
		384 + (int(rand_range(0, 8)) * 16),
		16 + (int(rand_range(0, 8)) * 16))
	
	speed = int(rand_range(3, 7))
	
	screen_edges.append(Vector2.ZERO)
	screen_edges.append(Vector2(get_viewport().size.x,0))
	screen_edges.append(Vector2(0,get_viewport().size.y))
	screen_edges.append(get_viewport().size)
	
	position = screen_edges[rand_range(0,screen_edges.size())]

	player = Globals.player
	
	
func _physics_process(delta):
	position -= (self.position - player.position).normalized() * speed


func kill():
	self.queue_free()
