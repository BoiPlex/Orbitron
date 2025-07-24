class_name Tower
extends GravAffectedBody

signal target_check

enum States {
	ACTIVE,
	STANDBY,
}

@export var projectile_factory: ProjectileFactory

var target_list: Array[Node2D]
var target: Node2D
var target_dir: Vector2 = Vector2.ZERO

var upgrades_to: TowerStats
var upgrade_cost: int = 100

var fire_rate: float = 1.0

var _state: States = States.STANDBY
var _fire_timer: Timer

@onready var player: Player = $"../Player"
@onready var detection: DetectionComponent = get_node_or_null("DetectionComponent")


func _ready() -> void:
	super()
	_fire_timer = Timer.new()
	_fire_timer.autostart = false
	_fire_timer.one_shot = true
	add_child(_fire_timer)
	detection.area_entered.connect(_on_add_target)
	detection.area_exited.connect(_on_remove_target)


func init_tower(stats: TowerStats):
	upgrades_to = stats.upgrades_to
	if upgrades_to == null:
		upgrade_cost = upgrades_to.cost
	fire_rate = stats.fire_rate
	if fire_rate >= 0.0:
		_fire_timer.wait_time = 1.0 / fire_rate
	else:
		_fire_timer.wait_time = 1.0
	if detection != null:
		detection.radius = stats.detection_range
	if projectile_factory != null:
		projectile_factory.class_stats = stats.projectile


func upgrade():
	if upgrades_to == null:
		push_warning("Tried to upgrade to null tower.")
	init_game_entity(upgrades_to)
	init_tower(upgrades_to)


func _fire():
	projectile_factory.launch_direction = target_dir
	projectile_factory.fire()


func _on_add_target(node: Node2D):
	target_list.push_back(node)
	target_check.emit()


func _on_remove_target(node: Node2D):
	target_list.erase(node)
	target_check.emit()


func _on_target_check():
	var closest: Node2D = null
	var min_dist: float = INF
	for node in target_list:
		var new_dist = node.global_position.distance_to(global_position)
		if new_dist < min_dist:
			closest = node
			min_dist = new_dist
	target = closest


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
		rotation = lerp_angle(rotation, target_dir.angle(), 1 - pow(0.25, 13 * delta))
		if _fire_timer.is_stopped():
			_fire()
			target_check.emit()
			_fire_timer.start()
