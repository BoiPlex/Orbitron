class_name HurtboxComponent
extends Area2D

@export var team: TeamsGlobal.Team
@export var max_health: int = 100	

@onready var health: int = 100
@onready var parent = get_parent() as GamePhysicsBody


func _ready() -> void:
	collision_layer = TeamsGlobal.teamHurtbox[team]
	collision_mask = 0
	area_entered.connect(_on_area_entered)


func take_damage(damage: int):
	health = clampi(health - damage, 0, max_health)
	if health == 0:
		parent.init_kill.emit()
			


func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent and area.get_parent() != parent:
		take_damage(area.damage)
		if parent is GamePhysicsBody:
			parent.hurtbox_contact.emit(area)
