@tool
class_name GravityField
extends Area2D

@export var gravity_strength: float = 5000.0
@export var gravity_radius: float = 400.0:
	set(value):
		gravity_radius = value
		_update_gravity_radius()


func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	_update_gravity_radius()


func _on_body_entered(body: Node):
	if body is GravAffectedBody:
		body.add_field(self)


func _update_gravity_radius():
	if !is_inside_tree():
		return
	var shape_node = $CollisionShape2D
	if shape_node and shape_node.shape is CircleShape2D:
		shape_node.shape.radius = gravity_radius


func _on_body_exited(body: Node):
	if body is GravAffectedBody:
		body.remove_field(self)
