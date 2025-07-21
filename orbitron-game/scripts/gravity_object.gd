class_name GravityObject
extends CharacterBody2D

var mass: float = 10

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()
