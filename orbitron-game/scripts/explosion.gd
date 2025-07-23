class_name Explosion
extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	animation_player.play("explode")


func destroy() -> void:
	queue_free()
