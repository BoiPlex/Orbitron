class_name HurtboxComponent
extends Area2D

@export var team: TeamsGlobal.Team
@export var max_health: int = 100	

var health: int = 100

@onready var parent = get_parent()
@onready var collider = $ColoredCollider as CollisionShape2D


func _ready() -> void:
	health = max_health
	collision_layer = TeamsGlobal.teamHurtbox[team].x
	collision_mask = TeamsGlobal.teamHurtbox[team].y
	area_entered.connect(_on_area_entered)


func take_damage(damage: int):
	health = clampi(health - damage, 0, max_health)
	if health == 0 and parent is GamePhysicsBody:
		parent.init_kill.emit()


func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.get_parent() != parent:
		take_damage(area.damage)
		if parent is GamePhysicsBody:
			parent.hurtbox_contact.emit(area)
