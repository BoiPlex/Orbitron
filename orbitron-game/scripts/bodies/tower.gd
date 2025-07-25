class_name Tower
extends GravAffectedBody

signal target_check

enum States {
	ACTIVE,
	STANDBY,
	READYING,
}

enum Orbit {
	CW,
	CCW,
}

const READYING_SPEED: float = 300
const FINISH_READY_RADIUS: float = 50

@export var debug_build_template: TowerStats = null
@export var projectile_factory: ProjectileFactory
@export var orbit_speed: float = 40
@export var orbit: Orbit = Orbit.CW

var target_list: Array[Node2D]
var target: Node2D
var target_dir: Vector2 = Vector2.ZERO

var ready_position: Vector2 = Vector2.ZERO

var upgrades_to: TowerStats
var upgrade_cost: int = 100

var fire_rate: float = 1.0

var _state: States = States.STANDBY


@onready var player: Player = $"../Player"
@onready var _fire_timer: Timer = $"Timer"
@onready var detection: DetectionComponent = get_node_or_null("DetectionComponent")


func _ready() -> void:
	super()
	_fire_timer.autostart = false
	_fire_timer.one_shot = true
	detection.area_entered.connect(_on_add_target)
	detection.area_exited.connect(_on_remove_target)
	target_check.connect(_on_target_check)
	if debug_build_template != null:
		init_tower(debug_build_template)
		init_game_entity(debug_build_template)


func init_tower(stats: TowerStats):
	upgrades_to = stats.upgrades_to
	orbit_speed = stats.orbiting_speed
	if upgrades_to != null:
		upgrade_cost = upgrades_to.cost
	fire_rate = stats.fire_rate
	print(_fire_timer)
	if fire_rate >= 0.0:
		_fire_timer.wait_time = 1.0 / fire_rate
	else:
		_fire_timer.wait_time = 1.0
	if detection != null:
		detection.radius = stats.detection_range
	if projectile_factory != null:
		projectile_factory.class_stats = stats.projectile
		projectile_factory.copies = stats.spread_copies
		projectile_factory.spread = stats.spread_angle
		projectile_factory.bursts = stats.bursts
		projectile_factory.burst_interval = stats.burst_interval


func start_readying():
	if hitbox:
		hitbox.set_deferred("monitorable", false)
		hitbox.set_deferred("monitoring", false)
	if hurtbox:
		hurtbox.set_deferred("monitorable", false)
		hurtbox.set_deferred("monitoring", false)
	if detection:
		detection.set_deferred("monitorable", false)
		detection.set_deferred("monitoring", false)
	collider.disabled = true
	_state = States.READYING


func finish_readying():
	if hitbox:
		hitbox.set_deferred("monitorable", true)
		hitbox.set_deferred("monitoring", true)
	if hurtbox:
		hurtbox.set_deferred("monitorable", true)
		hurtbox.set_deferred("monitoring", true)
	if detection:
		detection.set_deferred("monitorable", true)
		detection.set_deferred("monitoring", true)
	collider.disabled = false
	_state = States.STANDBY


func upgrade():
	if upgrades_to == null:
		push_warning("Tried to upgrade to null tower.")
	init_game_entity(upgrades_to)
	init_tower(upgrades_to)


func _fire():
	#print("fire!!!!")
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
	if closest == null:
		_state = States.STANDBY
	else:
		target = closest
		_state = States.ACTIVE


func _physics_process(delta: float) -> void:
	super(delta)
	
	# Auto correct to stable orbit
	match(_state):
		States.ACTIVE:
			_orbit_velocity(delta)
			target_dir = (target.global_position - global_position).normalized()
			rotation = lerp_angle(rotation, target_dir.angle(), 1 - pow(0.25, 13 * delta))
			if _fire_timer.is_stopped():
				_fire()
				target_check.emit()
				_fire_timer.start()
		States.STANDBY:
			_orbit_velocity(delta)
		States.READYING:
			var dir_to_ready = global_position.direction_to(ready_position)
			var dist_to_ready = ready_position.distance_to(global_position)
			print(dist_to_ready)
			if dist_to_ready <= FINISH_READY_RADIUS:
				finish_readying()
				print("readysdfsdf")
			else:
				velocity = lerp(READYING_SPEED * dir_to_ready,
				READYING_SPEED * dir_to_ready / 10, 
				1 - dist_to_ready / ready_position.distance_to(player.global_position))
		_:
			push_error("Unknown state: ", _state)
				

func _orbit_velocity(delta: float):
	var dir_to_planet = player.global_position - global_position
	var distance = dir_to_planet.length()
	var tangent = (Vector2(-dir_to_planet.y, dir_to_planet.x).normalized() if 
		orbit == Orbit.CCW else Vector2(dir_to_planet.y, -dir_to_planet.x).normalized())
	var desired_velocity = tangent * orbit_speed
	velocity = lerp(velocity, desired_velocity, 1 - pow(0.1, 20 * delta))
