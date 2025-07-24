class_name ProjectilePool
extends Node2D

const PROJECTILE_MAX = 400
const PROJECTILE_PATH = "res://scenes/projectile.tscn"

var pool: Array[Projectile]

@onready var projectile_scene = load(PROJECTILE_PATH)

func _ready():
	init_pool()
	set_active_pool()


func set_active_pool():
	ReferencesGlobal.projectile_pool = self


func init_pool():
	for i in range(PROJECTILE_MAX):
		var proj = projectile_scene.instantiate() as Projectile
		proj.disable()
		pool.push_back(proj)
		add_child(proj)
