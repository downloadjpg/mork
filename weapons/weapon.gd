extends Node3D
class_name Weapon

@export var projectile_scene : PackedScene
@export var max_ammo := 100
@export var initial_ammo := 50
@export var projectile_speed := 5.0
@export var infinite_ammo := false

@onready var spawn_position = $ProjectileSpawnPosition
@onready var animation_player = $AnimationPlayer

var current_ammo = initial_ammo
var damage_source : Node3D

func fire_weapon(forward_direction):
	if current_ammo <= 0 and not infinite_ammo:
		return
	if not projectile_scene:
		return
	if animation_player.is_playing():
		return
	current_ammo -= 1
	if animation_player.has_animation("fire"):
		animation_player.play("fire")
		

		# spawn a projectile and set its velocity
	var projectile_instance : Projectile = projectile_scene.instantiate()
	projectile_instance.global_transform = spawn_position.global_transform
	projectile_instance.velocity = forward_direction * projectile_speed
	projectile_instance.damage_source = damage_source
	get_tree().current_scene.add_child(projectile_instance)
	#projectile_instance.set_as_toplevel(true)  # Ensure it doesn't inherit the player's transform
