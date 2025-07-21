class_name HitboxComponent
extends Area2D

signal hit

const col_type = ColorGlobal.Type.DEBUG_HITBOX

@export var damage: int
var parent: CharacterBody2D

func _ready():
	area_entered.connect(_on_area_entered)
	

func _on_area_entered(area: Area2D):
	if area is HurtboxComponent:
		hit.emit()
