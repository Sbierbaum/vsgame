extends Area2D

@export var speed = 750

signal monster_killed

var hits = 0
var max_piercing = 1

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("mobs"):
		var mob = body
		#print('emit signal monster_killed')
		emit_signal("monster_killed",mob.xp_on_death)
		hits+=1
		body.queue_free()
	if(hits >= max_piercing):
		queue_free()
