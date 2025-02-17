extends Area2D


onready var bullet_timer = $BulletTimer


var vel = Vector2.ZERO
var speed = 600


func _ready():
	var mouse = get_global_mouse_position()
	vel = (mouse - position).normalized()
	look_at(mouse)


func _physics_process(delta):
	position += vel * speed * delta
	
	if bullet_timer.is_stopped():
		queue_free()


func _on_Bullet_area_entered(area):
	if area.is_in_group("Enemy"):
		area.kill(10)
		self.queue_free()
