extends CharacterBody3D
 
const MOVE_SPEED = 3
 
@onready var raycast = $RayCast3D
#@onready var anim_player = $AnimationPlayer
 
var player: Player = null
var dead: bool = false

func _ready() -> void:
	GameManager.connect("player_set", _on_player_set)
	$Health.health_depleted.connect(_on_health_depleted)

func _physics_process(delta):
	if dead:
		return
	if player == null:
		player = GameManager.player
		return
 
	var vec_to_player = player.position - position
	vec_to_player = vec_to_player.normalized()
	raycast.target_position = vec_to_player * 1.5
 
	move_and_collide(vec_to_player * MOVE_SPEED * delta)

 
func kill():
	dead = true
	$CollisionShape.disabled = true
	#anim_player.play("die")
 
func _on_player_set():
	print('eek!')
	player = GameManager.player


func _on_health_depleted():
	queue_free()
