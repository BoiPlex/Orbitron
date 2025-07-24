class_name ProjectilePool
extends Node2D

signal request_projectile(pos: Vector2, velocity: Vector2, stats: ProjectileStats)

const PROJECTILE_MAX = 555
const PROJECTILE_PATH = "res://scenes/projectile.tscn"

var _pool: Array[Projectile]
var _index: int = 0

@onready var _projectile_scene = load(PROJECTILE_PATH)

func _ready():
	init_pool()
	set_active_pool()
	request_projectile.connect(_on_request_projectile)


func set_active_pool():
	ReferencesGlobal.projectile_pool = self


func init_pool():
	for i in range(PROJECTILE_MAX):
		var proj = _projectile_scene.instantiate() as Projectile
		_pool.push_back(proj)
		add_child(proj)
		proj.disable()


func _on_request_projectile(pos: Vector2, velocity: Vector2, stats: ProjectileStats):
	var proj = _pool[_index]
	if not proj.disabled:
		proj.disable()
	proj.init_game_entity(stats)
	proj.init_projectile(stats)
	proj.global_position = pos
	proj.velocity = velocity
	proj.enable()
	
	_index += 1
	if _index == PROJECTILE_MAX:
		_index = 0
