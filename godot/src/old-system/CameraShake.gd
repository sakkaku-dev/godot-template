class_name CameraShake
extends Node

enum Strength {
	LOW,
	MEDIUM,
	HIGH
}

## How much vibrations
@export var noise_shake_speed: float = 30.0
## How strong each vibration
@export var noise_shake_strength: float = 30.0
## How fast to return to normal
@export var shake_decay_rate: float = 30.0

@onready var rand = RandomNumberGenerator.new()
@onready var noise = FastNoiseLite.new()
@onready var camera = get_viewport().get_camera_2d()

# Used to keep track of where we are in the noise
# so that we can smoothly move through it
var noise_i: float = 0.0
var shake_strength: float = 0.0

func _ready() -> void:
	rand.randomize()
	noise.seed = rand.randi()
	noise.frequency = 2

func shake() -> void:
	shake_strength = noise_shake_strength

func _process(delta: float) -> void:
	shake_strength = lerp(shake_strength, 0.0, shake_decay_rate * delta)
	if shake_strength != 0:
		camera.offset = get_noise_offset(delta)

func get_noise_offset(delta: float) -> Vector2:
	noise_i += delta * noise_shake_speed
	return Vector2(
		noise.get_noise_2d(1, noise_i) * shake_strength,
		noise.get_noise_2d(100, noise_i) * shake_strength
	)
