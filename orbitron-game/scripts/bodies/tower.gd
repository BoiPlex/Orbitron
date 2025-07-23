class_name Tower
extends GravAffectedBody

@export var fire_factories: Array[Factory]
@onready var player: Player = $"../Player"

var target: Node2D

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	super(delta)
	
	# Auto correct to stable orbit
	var dir_to_planet = player.global_position - global_position
	var distance = dir_to_planet.length()
	var speed = sqrt(player.gravity_field.gravity_strength / max(distance, 1.0))
	var tangent = Vector2(-dir_to_planet.y, dir_to_planet.x).normalized()
	var desired_velocity = tangent * speed
	velocity = lerp(velocity, desired_velocity, 0.1)
