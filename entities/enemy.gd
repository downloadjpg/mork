@tool
class_name Enemy extends CharacterBody3D

@export_group("Stats")
@export var max_health: float = 100.0
@export var move_speed: float = 5.0
@export var attack_damage: float = 25.0
@export var attack_range: float = 2.0
@export var weapon: Weapon

@export_group("Sound")
@export var wake_sound: AudioStream
@export var hurt_sound: AudioStream
@export var death_sound: AudioStream

@export_group("Visual")
@export var texture: Texture
@export var pixel_size: float = 1.0 / 16
@export var update_sprite: bool = false:
	set(value):
		update_sprite = false
		_update_sprite()

@onready var health_component: Health = $Health
@onready var player_detection: PlayerDetection = $PlayerDetection
@onready var hurt_box: HurtBox = $HurtBox
@onready var sprite = $Sprite3D
@onready var animation_player = $AnimationPlayer

#@onready var brain = AIBrain.new()
#@onready var movement_component = $MovementComponent

enum State {IDLE, PURSUE}
var state = State.IDLE
var attack_target : Node3D = null

func attack():
	weapon.fire_weapon(-basis.z)

func _ready():
	health_component.connect("health_changed", _on_health_changed)
	health_component.connect("health_depleted", _on_health_depleted)
	player_detection.connect("player_detected", _on_player_detected)
	player_detection.connect("player_lost", _on_player_lost)


func _physics_process(delta: float) -> void:
	match state:
		State.IDLE:
			velocity = Vector3.ZERO
			# chill
		State.PURSUE:
			# Move towards target
			var to_player = attack_target.position - position
			if to_player.length() > attack_range:
				attack()
			else:
				var dir = to_player.normalized()
				velocity = move_speed * dir
	velocity += get_gravity()
	move_and_slide()


func _on_player_detected(player: Player):
	state = State.PURSUE
	attack_target = player
	#play wake sound

func _on_player_lost():
	state = State.IDLE
	attack_target = null

func _on_health_changed(delta):
	animation_player.play("hurt")

func _on_health_depleted():
	animation_player.play("die")
	await animation_player.animation_finished
	queue_free()

func _enter_tree() -> void:
	# Make sure we have a sprite node
	if not has_node("Sprite3D"):
		var new_sprite = Sprite3D.new()
		new_sprite.name = "Sprite3D"
		add_child(new_sprite)
		# Make it visible in the editor's scene tree
		new_sprite.owner = get_tree().edited_scene_root
		
	# Initial setup of the sprite
	_update_sprite()

func _update_sprite() -> Sprite3D:
	
	if not sprite and has_node("Sprite3D"):
		sprite = get_node("Sprite3D")
	
	# Set standard properties
	sprite.texture_filter = BaseMaterial3D.TEXTURE_FILTER_NEAREST
	sprite.billboard = BaseMaterial3D.BILLBOARD_FIXED_Y
	sprite.pixel_size = pixel_size
	
	sprite.texture = texture
	
	return sprite
