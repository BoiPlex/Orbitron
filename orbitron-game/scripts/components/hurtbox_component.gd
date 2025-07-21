class_name HurtboxComponent
extends Area2D

signal dead

@export var max_health: int = 100
var health: int = 100

func _ready() -> void:
	health = max_health
	area_entered.connect(_on_area_entered)


func take_damage(damage: int):
	health = clampi(health - damage, 0, max_health)
	if health == 0:
		dead.emit()


func _on_area_entered(area: Area2D) -> void:
	if area is HitboxComponent:
		take_damage(area.damage)
