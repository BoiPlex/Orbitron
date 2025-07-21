class_name HitboxComponent
extends Area2D

signal hit

@export var damage: int
var parent: CharacterBody2D

func _ready():
	pass
	

func _on_area_entered(area: Area2D):
	
