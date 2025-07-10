extends Node3D

@export var projectile: PackedScene
@export var projectile_speed : float = 25.0

func shoot(direction: Vector3):
	# spawn a projectile and set its velocity
	var projectile_instance = projectile.instantiate()
	projectile_instance.global_transform = global_transform
	projectile_instance.velocity = direction * projectile_speed
	get_tree().current_scene.add_child(projectile_instance)
	#projectile_instance.set_as_toplevel(true)  # Ensure it doesn't inherit the player's transform
