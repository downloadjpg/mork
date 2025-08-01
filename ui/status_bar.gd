extends Panel

var player : Player = null

@onready var health : Label = $MarginContainer/HBoxContainer/HealthHBox/Health
@onready var ammo : Label = $MarginContainer/HBoxContainer/Ammo
@onready var keys : Label = $MarginContainer/HBoxContainer/KeyHBox/KeyCounter

func _process(delta: float) -> void:
	if player == null:
		player = GameManager.player
		return
	
	# TODO: refactor this so it isn't called every frame
	update_health()
	update_ammo()
	update_keys()


func update_health():
	if health == null:
		return
	var value = (player.health.get_health() as float) / (player.health.get_max_health() as float) * 100
	health.text = ("%d%%" % value) # this is weird. prints something like '96%'

func update_ammo():
	ammo.text = "-/-"
	var weapon = player.weapon_inventory.held_weapon
	if not weapon or not weapon.uses_ammo:
		return
	ammo.text = "%d/%d" % [weapon.current_ammo, weapon.max_ammo]

func update_keys():
	var key_count : int = GameManager.inventory["key"]
	keys.text = "%d" % key_count
