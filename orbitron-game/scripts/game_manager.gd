class_name GameManager
extends Node2D

@export var debris_scene: PackedScene
@export var dev_mode: bool = true

# Dev mode options
enum DevClickMode {STILL, DIRECT, ORBITAL}
var _dev_click_mode: DevClickMode = DevClickMode.STILL
var _debug_spawner: DebugBodyFactory

@onready var player: Player = $Player


func _ready() -> void:
	if dev_mode:
		init_debug_spawner()


func init_debug_spawner():
	_debug_spawner = DebugBodyFactory.new()
	_debug_spawner.body_scene = load("res://scenes/debris.tscn")
	_debug_spawner.parent = self
	_debug_spawner.player = player
	add_child(_debug_spawner)
