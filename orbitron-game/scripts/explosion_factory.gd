class_name ExplosionFactory
extends Node

@export var explosion_scene: PackedScene
@export var parent: Node


func make_explosion(pos: Vector2):
	var explosion = explosion_scene.instantiate() as Explosion
	explosion.global_position = pos
	parent.add_child(explosion)
