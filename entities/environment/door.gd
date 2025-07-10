extends Node3D

func _ready():
	$InteractionArea.interact

func player_has_key():
	#if GameManager.check_player_inventory("key"):
		#GameManager.remove_from_player_inventory("key"):
	#else:
	GameManager.send_message("The door rattles.")
	
