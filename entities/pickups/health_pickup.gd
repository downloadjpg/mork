extends Area3D
class_name HealthPickup

@export var heal_amount: int = 1
@export var pickup_message: String = "You quaff a health potion."

@onready var pickup_sound = $PickupSound

var disabled # stupid hack

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if disabled: # fuckin' stupid. see below.
		return
	if body is Player:
		var player = body as Player
		if player.health.health == player.health.max_health:
			return
			
		GameManager.send_message(pickup_message)
		player.health.health += heal_amount
		pickup_sound.play()
		
		# can't queue free because the pickup sound needs to play and finish... ugh.
		#monitorable = false
		#monitoring = false
		#$CollisionShape3D.disabled = true
		visible = false
		disabled = true # whyyyyy 
		await pickup_sound.finished
		queue_free()
