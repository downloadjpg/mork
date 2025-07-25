extends Weapon


@export var projectile_scene : PackedScene

func fire_weapon(forward_direction) -> void:
	# Check and update ammunition
	if not infinite_ammo:
		if current_ammo <= 0:
			return
		current_ammo -= 1
		#Events.UI.ammo_changed.emit(current_ammo)
		
	# If the weapon is currently firing or reloading, don't fire
	if animation_player.is_playing():
		return
	if animation_player.has_animation("fire"):
		animation_player.play("fire")
	spawn_projectile(forward_direction, projectile_scene)


func spawn_projectile(forward_direction : Vector3, projectile_scene: PackedScene):
	# spawn a projectile and set its velocity
	var projectile_instance : Projectile = projectile_scene.instantiate()
	projectile_instance.global_transform = spawn_position.global_transform
	projectile_instance.velocity = forward_direction * projectile_speed
	projectile_instance.damage_source = damage_source
	get_tree().current_scene.add_child(projectile_instance)
