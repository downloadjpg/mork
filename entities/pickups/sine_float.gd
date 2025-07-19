@tool
class_name SineFloat
extends Node3D
## A node that oscillates its position along a specified axis using sinusoidal motion.
## This creates smooth, wave-like movement that can be used for floating objects,
## gentle swaying animations, or rhythmic motion effects in 3D space.

@export var enabled := true
@export var starting_position := Vector3.ZERO ## The base position around which the node oscillates
@export var amplitude := 0.2 ## Peak deviation from the starting position (maximum distance moved)
@export var frequency := 0.2 ## Number of complete oscillations per second (Hz)
@export_range(0, 1) var phase := 0.0 ## Starting phase offset (0-1 maps to 0-2π radians)
@export var axis := Vector3.UP : ## Direction vector for oscillation movement
	set(value):
		axis = value.normalized() # Ensure axis is always a unit vector

var time = 0.0 ## Accumulated time for calculating oscillation position

# Sinusoidal motion equation: x = A sin(ωt + φ) = A * sin(2πft + φ)
# Where: A = amplitude, ω = angular frequency, f = frequency, t = time, φ = phase offset
func _process(delta: float) -> void:
	if not enabled:
		return
	# Initialize time if it's falsy (handles both 0 and null cases)
	if not time:
		time = 0.0
	
	time += delta # Accumulate elapsed time
	# TODO: Consider wrapping time to prevent floating point precision issues over long periods
	
	var omega = TAU * frequency  # Convert frequency to angular frequency (ω = 2πf)
	var phi = TAU * phase        # Convert phase from 0-1 range to 0-2π radians
	
	# Calculate new position using sinusoidal motion equation
	# Move along the specified axis by the sine wave displacement
	position = starting_position + amplitude * sin(omega * time + phi) * axis
