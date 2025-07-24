class_name Tower
extends GravAffectedBody

enum States {
	ACTIVE,
	STANDBY,
}

@export var projectile_factory: Factory

var target: Node2D
var target_dir: Vector2 = Vector2.ZERO

var upgrades_to: TowerStats

var _state: States = States.STANDBY

@onready var player: Player = $"../Player"


func _ready() -> void:
	pass


func init_tower(stats: TowerStats):
	
	pass


func _fire():
	projectile_factory.launch_direction = target_dir


func _physics_process(delta: float) -> void:
	super(delta)
	
	# Auto correct to stable orbit
	var dir_to_planet = player.global_position - global_position
	var distance = dir_to_planet.length()
	var speed = sqrt(player.gravity_field.gravity_strength / max(distance, 1.0))
	var tangent = Vector2(-dir_to_planet.y, dir_to_planet.x).normalized()
	var desired_velocity = tangent * speed
	velocity = lerp(velocity, desired_velocity, 1 - pow(0.25, delta))
	
	if _state == States.ACTIVE:
		target_dir = (target.global_position - global_position).normalized()
		rotation = lerp_angle(rotation, target_dir.angle(), 1 - pow(0.25, delta))
		
