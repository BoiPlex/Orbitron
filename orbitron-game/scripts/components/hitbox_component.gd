class_name HitboxComponent
extends Area2D

@export var team: TeamsGlobal.Team
@export var damage: int

@onready var parent = get_parent()


func _ready():
	collision_layer = 0
	collision_mask = TeamsGlobal.teamHitbox[team]
	area_entered.connect(_on_area_entered)
	

func _on_area_entered(area: Area2D):
	if area is HurtboxComponent and area.get_parent() != parent:
		if parent is GamePhysicsBody:
			parent.hitbox_contact.emit()
