class_name HitboxComponent
extends Area2D

@export var damage: int

@onready var parent = get_parent()


func _ready():
	area_entered.connect(_on_area_entered)
	

func _on_area_entered(area: Area2D):
	if area is HurtboxComponent:
		if parent is GamePhysicsBody:
			parent.hitbox_contact.emit()
