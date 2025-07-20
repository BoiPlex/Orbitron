class_name GravAffectedBody
extends CharacterBody2D

var display_path: bool

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	move_and_slide()
