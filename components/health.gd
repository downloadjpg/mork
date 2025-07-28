class_name Health
extends Node

signal max_health_changed(diff: int)
signal health_changed(delta: int)
signal health_depleted

@export var max_health: int = 3 : set = set_max_health, get = get_max_health
@export var immortal : bool = false
@onready var health: int = max_health : set = set_health, get = get_health


func set_max_health(value: int):
	var clamped_value = 1 if value <= 0 else value

	if clamped_value != max_health:
		var difference = clamped_value - max_health
		max_health_changed.emit(difference)
		max_health = clamped_value
	
	if health > max_health:
		health = max_health


func get_max_health() -> int:
	return max_health

		

func set_health(value: int):
	if value < health and immortal:
		return
	
	var clamped_value = clampi(value, 0, max_health)

	if clamped_value != health:
		var difference = clamped_value - health
		health = clamped_value
		health_changed.emit(difference)
	
	if health == 0:
		health_depleted.emit()
	print(health)

func get_health() -> int:
	return health
