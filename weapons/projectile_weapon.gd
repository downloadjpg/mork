class_name ProjectileWeapon extends Weapon


@export_group("Projectile Properties")
@export var projectile_scene: PackedScene
@export var projectile_speed: float = 20.0
@export var projectile_gravity: float = 0.0

@export var muzzle_point : Marker3D

func _fire_implementation():
	if projectile_scene:
		var projectile : Projectile = projectile_scene.instantiate()
		get_tree().root.add_child(projectile)
		
		# Set position and rotation
		if muzzle_point:
			projectile.global_transform = muzzle_point.global_transform
		else:
			projectile.global_transform = global_transform
		
		# Set properties
		projectile.initialize(damage_source, damage, projectile_speed, projectile_gravity)
		
		projectile.velocity = -projectile.basis.z * projectile_speed
