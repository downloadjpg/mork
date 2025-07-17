extends Panel

var player : Player = null

@onready var health : Label = $HBoxContainer/Health

func _process(delta: float) -> void:
	if player == null:
		player = GameManager.player
		return
	
	update_health()


func update_health():
	if health == null:
		return
	var value = (player.health.get_health() as float) / (player.health.get_max_health() as float) * 100
	health.text = ("%d%%" % value) # this is weird. prints something like '96%'
