@tool

class_name DetectionComponent
extends Area2D

@export var radius: float = 5:
	set(r):
		if $ColoredCollider != null and $ColoredCollider.shape is CircleShape2D:
			$ColoredCollider.shape.radius = r
