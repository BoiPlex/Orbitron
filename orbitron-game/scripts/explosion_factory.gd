class_name ExplosionFactory
extends Node

@export var explosion_scene: PackedScene
@export var parent: Node

var _explosion_list: Array[Explosion] = []

func make_explosion(pos: Vector2):
	var explosion = explosion_scene.instantiate() as Explosion
	explosion.global_position = pos
	_explosion_list.push_back(explosion)
	parent.add_child(explosion)
