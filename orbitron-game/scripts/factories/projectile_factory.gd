class_name ProjectileFactory
extends Factory

@export_category("Projectile Layout")
@export_range(1, 12) var copies: int = 1
@export_range(0, 2 * PI) var spread: float = 0.1
@export_range(1, 12) var bursts: int = 1
@export_range(0, 1) var burst_interval: float = 0.1

var _burst_timer: Timer
var _center_axis: Vector2 = Vector2.ZERO
var _remaining_copies: int = 1
var _remaining_bursts: int = 1
var _working_spread: float = 0
var _fire_lock: bool = false


func _ready():
	_burst_timer = Timer.new()
	_burst_timer.one_shot = true
	_burst_timer.autostart = false
	add_child(_burst_timer)


func fire():
	if _fire_lock:
		return
	_fire_lock = true
	_center_axis = launch_direction
	_remaining_bursts = bursts
	_init_burst()
	_fire_lock = false


func _init_burst():
	if bursts == 1:
		_init_spread()
	else:
		for i in bursts:
			_init_spread()
			_burst_timer.start(burst_interval)
			await _burst_timer.timeout


func _init_spread():
	_working_spread = 0
	_remaining_copies = copies
	if _remaining_copies % 2 == 0:
		_working_spread += spread / 2
		make()
		_working_spread *= -1
		make()
		_working_spread *= -1
		_remaining_copies -= 2
	else: 
		make()
		_remaining_copies -= 1
	for i in range(_remaining_copies / 2):
		_working_spread += spread
		make()
		_working_spread *= -1
		make()
		_working_spread *= -1


func make():
	var proj_stats = class_stats as ProjectileStats
	make_position = global_position
	launch_speed = proj_stats.initial_speed
	launch_direction = _center_axis.rotated(_working_spread)
	ReferencesGlobal.projectile_pool.request_projectile.emit(
		make_position, launch_direction * launch_speed, proj_stats
	)
	
