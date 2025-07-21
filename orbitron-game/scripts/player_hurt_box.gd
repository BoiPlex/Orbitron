class_name PlayerHurtBox
extends Area2D

@onready var player: Player = get_parent()


func _init() -> void: 
	#set_collision_layer_value(1, true)
	#set_collision_mask_value(3, true) # Detect enemy hitboxes
	area_entered.connect(_on_area_entered)


# Detect Area2D collision
func _on_area_entered(area: Area2D) -> void:
	pass
	#if area is EnemyHitBox:
		#var enemy := area.owner


# Detect Node2D collision
func _on_body_entered(body: Node2D) -> void:
	pass
	#if body is X:
		#player.instakill()
