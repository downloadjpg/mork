class_name Weapon
extends Node3D

@export var infinite_ammo := false
@export var max_ammo := 100
@export var initial_ammo := 50
@export var projectile_speed := 5.0
@onready var spawn_position = $ProjectileSpawnPosition

@onready var animation_player = $AnimationPlayer

var current_ammo = initial_ammo
var damage_source : Node3D

func fire_weapon(forward_direction : Vector3) -> void:
	printerr('fire_weapon not defined!')
	pass
	
