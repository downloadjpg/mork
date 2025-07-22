class_name HurtBox
extends Area3D

signal received_damage(damage: int)

@export var health: Health

func _ready() -> void:
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: HitBox) -> void:
	# Ensure the colliding area is actually a hitbox
	if hitbox:
		take_damage(hitbox)
		

func take_damage(hitbox: HitBox):
	health.health -= hitbox.damage
	received_damage.emit(hitbox.damage)

		
