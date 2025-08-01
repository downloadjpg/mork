@tool
class_name ParticleEmitter
extends Node3D

@export var particle_scene: Dictionary[String, PackedScene]

func spawn(particle_name: String):
	var particle : CPUParticles3D = particle_scene[particle_name].instantiate()
	add_child(particle)
	#particle.global_position = global_position
	particle.emitting = true
	await particle.finished
	particle.queue_free()
