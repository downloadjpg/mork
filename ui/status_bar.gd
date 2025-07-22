extends Panel

var player : Player = null

@onready var health : Label = $HBoxContainer/Health
@onready var ammo : Label = $HBoxContainer/Ammo

func _process(delta: float) -> void:
	if player == null:
		player = GameManager.player
		return
	
	update_health()
	update_ammo()


func update_health():
	if health == null:
		return
	var value = (player.health.get_health() as float) / (player.health.get_max_health() as float) * 100
	health.text = ("%d%%" % value) # this is weird. prints something like '96%'

func update_ammo():
	ammo.text = "-/-"
	var weapon = player.weapon_inventory.held_weapon
	if not weapon or weapon.infinite_ammo:
		return
	ammo.text = "%d/%d" % [weapon.current_ammo, weapon.max_ammo]
