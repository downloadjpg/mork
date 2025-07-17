extends Node3D
class_name Weapon

@export var projectile_scene : PackedScene
@export var max_ammo := 100
@export var initial_ammo := 10
@export var projectile_speed := 5.0

var current_ammo = initial_ammo

func fire_weapon(forward_direction):
	if current_ammo <= 0:
		return

		# spawn a projectile and set its velocity
	var projectile_instance = projectile_scene.instantiate()
	projectile_instance.global_transform = global_transform
	projectile_instance.velocity = forward_direction * projectile_speed
	get_tree().current_scene.add_child(projectile_instance)
	#projectile_instance.set_as_toplevel(true)  # Ensure it doesn't inherit the player's transform
