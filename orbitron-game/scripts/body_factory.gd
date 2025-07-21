class_name GravBodyFactory
extends Node2D

@export var body_scene: PackedScene
@export var parent: Node


var _grav_body_list: Array[GravAffectedBody] = []


func make_body(position: Vector2, velocity: Vector2):
	var grav_body = body_scene.instantiate() as GravAffectedBody
	grav_body.global_position = position
	grav_body.velocity = velocity
	_grav_body_list.push_back(grav_body)
	parent.add_child(grav_body)
