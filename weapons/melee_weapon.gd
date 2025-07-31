class_name MeleeWeapon extends Weapon

@export_group("Melee Properties")
#@export var attack_distance: float = 2.0 # Reach of the weapon
@export var knockback_force: float = 5.0 # How much to push enemies back
@export var attack_duration: float = 0.3 # How long the swing takes (???)

@export_group("Visuals")
@export var swing_animation: String = "swing"
@export var weapon_visible: bool = true # Change to false for enemies
@export var weapon_model: Node3D # Reference to visible model/sprite.

@onready var hitbox : HitBox = $HitBox
#@onready var animation_player = $AnimationPlayer # in parent class?


var is_attacking = false

func _ready():
	super._ready()
	# connect to hitbox body entered?
	hitbox.damage = damage
	hitbox.damage_source = damage_source
	hitbox.knockback_force = knockback_force
	hitbox.set_deferred("monitoring", false)
	hitbox.set_deferred("monitorable", false)
	
	if weapon_model:
		weapon_model.visible = weapon_visible

func _fire_implementation():
	is_attacking = true
	
	# Play animation
	if animation_player and animation_player.has_animation(swing_animation):
		animation_player.play(swing_animation)
	
	# Activate hitbox
	if hitbox:
		hitbox.monitoring = true
		hitbox.monitorable = true
	
	# Handle attack duration
	await get_tree().create_timer(attack_duration).timeout
	
	# End attack
	is_attacking = false
	if hitbox:
		hitbox.monitoring = false
		hitbox.monitorable = false
	
	
