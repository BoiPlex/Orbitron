class_name Player
extends Node2D

@export var gravity_strength: float = 5000.0
@export var gravity_radius: float = 400.0

var affected_bodies: Array[Node] = []

@onready var gravity_field: Area2D = $GravityField

func _ready():
	# Initialize gravity field
	#gravity_field.get_node("CollisionShape2D").shape.radius = gravity_radius
	gravity_field.connect("body_entered", _on_body_entered)
	gravity_field.connect("body_exited", _on_body_exited)


func _on_body_entered(body: Node):
	if body is CharacterBody2D:
		affected_bodies.append(body)


func _on_body_exited(body: Node):
	affected_bodies.erase(body)


func _physics_process(delta: float):
	for body in affected_bodies:
		var dir_to_center = global_position - body.global_position
		var distance = dir_to_center.length()
		var gravity_force = gravity_strength / max(distance * distance, 1.0)
		var velocity_change = dir_to_center.normalized() * gravity_force * delta
		body.velocity += velocity_change
