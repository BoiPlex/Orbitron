class_name GravityField
extends Area2D

@export var gravity_strength: float = 5000.0
@export var gravity_radius: float = 400.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node):
	if body is GravAffectedBody:
		body.add_field(self)


func _on_body_exited(body: Node):
	if body is GravAffectedBody:
		body.remove_field(self)
