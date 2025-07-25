class_name Sword
extends Weapon



func fire_weapon(_forward_direction):
	if animation_player.is_playing():
		return
	animation_player.play("swing")
	$SwooshSound.play()
	
	#if GameManager.player.health.is_max():
		#projectile_spawner.spawn()
