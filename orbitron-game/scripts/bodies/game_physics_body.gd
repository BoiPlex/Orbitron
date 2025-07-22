class_name GamePhysicsBody
extends CharacterBody2D

@export var mass: float = 10

var direction: Vector2

func force_push(push_dir: Vector2, force: float):
	velocity += push_dir.normalized() * force / mass
