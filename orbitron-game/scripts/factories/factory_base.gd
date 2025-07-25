class_name Factory
extends Node2D

@export var force_make: bool:
	set(x):
		make()
@export var base_scene: PackedScene
@export var parent: Node
@export var class_stats: PhysicsBodyStats

@export var make_position: Vector2 = Vector2.ZERO
@export var random_launch_direction: bool
@export var launch_direction: Vector2 = Vector2.ONE
@export var launch_speed: float


func make():
	pass
