@tool
extends Node3D
@export var starting_position := Vector3.ZERO
@export var amplitude := 0.2 # peak deviation from zero
@export var frequency := 0.2 # oscillations / sec
@export_range(0, 1) var phase := 0.0 # how far along to start, phi = 2pi phase
@export var axis := Vector3.UP :
	set(value):
		axis = value.normalized()
var time = 0

# Equation for sinusoidal motion:
# x = A sin( omega t + phi ) = A * sin( 2pi f t + phi)


func _process(delta: float) -> void:
	if not time:
		time = 0
	time += delta # TODO: wrap this somehow
	
	var omega = TAU * frequency
	var phi = TAU * phase
	position = starting_position + amplitude * sin(omega * time) * axis
	
	
