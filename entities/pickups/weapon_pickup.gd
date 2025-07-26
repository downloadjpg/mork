extends Area3D
class_name WeaponPickup

@export var weapon_scene: PackedScene = preload("res://weapons/crossbow.tscn")
@export var pickup_message: String = "You pick up something strange..."

@onready var pickup_sound = $PickupSound

var disabled # stupid hack

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if disabled:
		return
	if body is Player:
		GameManager.send_message(pickup_message)
		body = body as Player
		body.pickup_weapon(weapon_scene)
		pickup_sound.play()
		
		# can't queue free because the pickup sound needs to play and finish... ugh.
		#monitorable = false
		#monitoring = false
		#$CollisionShape3D.disabled = true
		visible = false
		disabled = true # whyyyyy 
		await pickup_sound.finished
		queue_free()
