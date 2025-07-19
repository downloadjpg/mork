extends Area3D
class_name WeaponPickup

@export var weapon_scene: PackedScene = preload("res://weapons/crossbow.tscn")

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is Player:
		body = body as Player
		body.pickup_weapon(weapon_scene) 
		queue_free()
