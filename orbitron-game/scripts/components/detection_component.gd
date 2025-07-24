@tool

class_name DetectionComponent
extends Area2D

@export var team: TeamsGlobal.Team
@export var radius: float = 5:
	set(r):
		if $ColoredCollider != null and $ColoredCollider.shape is CircleShape2D:
			$ColoredCollider.shape.radius = r


func _ready():
	collision_layer = 0
	collision_mask = TeamsGlobal.teamHitbox[team]
