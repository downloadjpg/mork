#class_name Events
extends Node

# none of these are used yet... maybe refactor UI to use this
signal health_changed(value)
signal ammo_changed(value)
signal max_ammo_changed(value)

signal player_death
signal player_spawn(player : Player)
