class_name GameWorld
extends Node2D

@export var dev_mode: bool = true

# Dev mode options
enum DevClickMode {STILL, DIRECT, ORBITAL}
var _dev_click_mode: DevClickMode = DevClickMode.STILL
var _debug_spawner: DebugBodyFactory

var explosion_spawner: ExplosionFactory
var _explosion_cooldown_timer: Timer
var explosion_cooldown: float = 0.2


@onready var player: Player = $Player


func _ready() -> void:
	if dev_mode:
		init_debug_spawner()
	init_explosion_spawner()
	
	_explosion_cooldown_timer = Timer.new()
	_explosion_cooldown_timer.one_shot = true
	add_child(_explosion_cooldown_timer)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and _explosion_cooldown_timer.is_stopped():
		var click_position = get_global_mouse_position()
		explosion_spawner.make_explosion(click_position)
		_explosion_cooldown_timer.start(explosion_cooldown)

func init_debug_spawner():
	_debug_spawner = DebugBodyFactory.new()
	_debug_spawner.base_scene = load("res://scenes/test_body.tscn")
	_debug_spawner.parent = self
	_debug_spawner.player = player
	add_child(_debug_spawner)

func init_explosion_spawner():
	explosion_spawner = ExplosionFactory.new()
	explosion_spawner.explosion_scene = load("res://scenes/explosion.tscn")
	explosion_spawner.parent = self
	add_child(explosion_spawner)
