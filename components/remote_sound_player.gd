extends Node3D
class_name RemoteSoundPlayer
## Can call sounds to be played without fear of being deleted or moved.

@export var sound_library: Dictionary[String, AudioStream]

func play_sound(name: String):
	var stream = sound_library[name]
	SoundManager.play_sound(stream, global_position)

func play_global_sound(name: String):
	SoundManager.play_global_sound(stream)
