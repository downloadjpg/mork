class_name Projectile
extends CharacterBody3D

@export var lifetime : float = 3.0

var lifetime_timer : Timer = null
var damage_source : Node3D



func _ready() -> void:
	lifetime_timer = Timer.new()
	lifetime_timer.one_shot = true
	lifetime_timer.timeout.connect(_on_lifetime_timeout)
	add_child(lifetime_timer)
	lifetime_timer.start(lifetime)
	$HitBox.damage_source = damage_source
	align_hitboxes()

func align_hitboxes():
	for child in get_children():
		if child is HitBox:
			child.damage_source = damage_source
	#print('this is my damage source;', damage_source)


func _on_lifetime_timeout():
	queue_free()
