class_name HurtboxComponent
extends Area2D


@export var max_health: int = 100	

@onready var health: int = 100
@onready var parent = get_parent() as GamePhysicsBody


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func take_damage(damage: int):
	health = clampi(health - damage, 0, max_health)
	if health == 0:
		parent.init_kill.emit()
			


func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		take_damage(area.damage)
