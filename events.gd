#class_name Events
extends Node

# none of these are used yet... maybe refactor UI to use this
#signal health_changed
#signal update_ammo
#signal key_count_changed

@warning_ignore("unused_signal")
signal player_death
@warning_ignore("unused_signal")
signal player_spawn(player : Player)
