class_name Projectile
extends CharacterBody3D

@export var lifetime : float = 3.0

var lifetime_timer : Timer = null

func _ready() -> void:
	lifetime_timer = Timer.new()
	lifetime_timer.one_shot = true
	lifetime_timer.timeout.connect(_on_lifetime_timeout)
	add_child(lifetime_timer)
	lifetime_timer.start(lifetime)
	


func _on_lifetime_timeout():
	queue_free()
