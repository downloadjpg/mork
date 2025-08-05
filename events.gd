#class_name Events
extends Node

var ui = UI.new()
var game = Game.new()

# none of these are used yet... maybe refactor UI to use this
class UI:
	signal health_changed
	signal update_ammo
	signal key_count_changed
	signal send_message(msg: String)

class Game:
	@warning_ignore("unused_signal")
	signal player_death
	@warning_ignore("unused_signal")
	signal player_spawn(player : Player)
