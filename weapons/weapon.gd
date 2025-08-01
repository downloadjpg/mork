class_name Weapon
extends Node3D

signal weapon_fired
signal ammo_changed(current, maximum)

@export var damage_source : Node3D

@export_group("Weapon Properties")
@export var weapon_name : String = "Generic Weapon"
@export var damage: int = 2
@export var fire_rate : float = 0.5 # Seconds between shots
@export var auto_fire: bool = false # Hold wto fire vs tap

@export_group("Ammunition")
@export var uses_ammo: bool = false
@export var ammo_per_shot: int = 1
@export var max_ammo := 100
@export var current_ammo: int = 100:
	set(value):
		current_ammo = clampi(value, 0, max_ammo)
		ammo_changed.emit(current_ammo, max_ammo)

@export_group("Effects")
@export var fire_sound: AudioStream
@export var empty_sound: AudioStream


@onready var audio_player = $AudioStreamPlayer3D
@onready var animation_player = $AnimationPlayer

# Internal State
var can_fire: bool = true
var firing_cooldown: float = 0.0

func _ready():
	# init
	pass

func _process(delta):
	# Handle cooldown
	if firing_cooldown > 0:
		firing_cooldown -= delta
		if firing_cooldown <= 0:
			can_fire = true

func try_fire() -> bool:
	# Check if we can fire according to cooldown and ammunition
	if !can_fire or firing_cooldown > 0:
		return false
	
	if uses_ammo and current_ammo < ammo_per_shot:
		# Click - empty
		if audio_player and empty_sound:
			audio_player.stream = empty_sound
			audio_player.play()
		return false
	
	_fire()
	return true

func _fire():
	# Start cooldown
	can_fire = false
	firing_cooldown = fire_rate
	
	# Use ammo
	if uses_ammo:
		current_ammo -= ammo_per_shot
	
	# Play effects
	_play_fire_effects()
	
	# Handle actual weapon behavior, overriden by child class
	_fire_implementation()
	
	# Emit signal
	weapon_fired.emit()

func _fire_implementation():
	printerr("fire implementation not written!")
	pass

func _play_fire_effects():
	# Play sound
	if audio_player and fire_sound:
		audio_player.stream = fire_sound
		audio_player.play()
