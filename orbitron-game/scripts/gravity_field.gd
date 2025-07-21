@tool
class_name GravityField
extends Area2D

@export var gravity_strength: float = 5000.0
@export var gravity_radius: float = 100.0:
	set(value):
		gravity_radius = value
		_update_gravity_radius()

var affected_bodies: Array[Node] = []


func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	_update_gravity_radius()


func _on_body_entered(body: Node):
	if body is GravityObject:
		affected_bodies.append(body)


func _on_body_exited(body: Node):
	affected_bodies.erase(body)


func _update_gravity_radius():
	if !is_inside_tree():
		return
	var shape_node = $CollisionShape2D
	if shape_node and shape_node.shape is CircleShape2D:
		shape_node.shape.radius = gravity_radius


func _physics_process(delta: float):
	for body in affected_bodies:
		var dir_to_center = global_position - body.global_position
		var distance = dir_to_center.length()
		var gravity_force = gravity_strength / max(distance * distance, 1.0)
		var velocity_change = dir_to_center.normalized() * gravity_force * delta
		body.velocity += velocity_change
