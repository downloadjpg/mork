class_name HurtBox
extends Area3D

signal received_damage(damage: int)

@export var health: Health
@export var ignored_source: Node3D
@export_range(0, 2) var invulnerability_time: float = 0.8

func _ready() -> void:
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox) -> void:
	# Ensure the colliding area is actually a hitbox
	if hitbox is not HitBox:
		return
	hitbox = hitbox as HitBox # ugh
	if hitbox.damage_source == ignored_source:
		return
	take_damage(hitbox)

func take_damage(hitbox: HitBox):
	health.health -= hitbox.damage
	received_damage.emit(hitbox.damage)
	# stupid
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
	await get_tree().create_timer(invulnerability_time).timeout
	
	set_deferred("monitoring", true)
	set_deferred("monitorable", true)
	call_deferred("check_for_hits")
	
func check_for_hits():
	for area in get_overlapping_areas():
		_on_area_entered(area)
		
