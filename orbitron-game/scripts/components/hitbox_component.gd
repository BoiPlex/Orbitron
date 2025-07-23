class_name HitboxComponent
extends Area2D

@export var damage: int

@onready var parent = get_parent() as GamePhysicsBody


func _ready():
	area_entered.connect(_on_area_entered)
	

func _on_area_entered(area: Area2D):
	if area is HurtboxComponent:
		parent.hitbox_contact.emit()
