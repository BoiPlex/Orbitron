@tool

class_name ColoredCollider
extends CollisionShape2D

func _ready() -> void:
	if not Engine.is_editor_hint():
		return
		
	if get_parent() is HitboxComponent:
		debug_color = ColorGlobal.type_color[ColorGlobal.Type.DEBUG_HITBOX]
	elif get_parent() is HurtboxComponent:
		debug_color = ColorGlobal.type_color[ColorGlobal.Type.DEBUG_HURTBOX]
	elif get_parent() is GravityField:
		debug_color = ColorGlobal.type_color[ColorGlobal.Type.GRAVITY]
	elif get_parent() is CollisionObject2D:
		debug_color = ColorGlobal.type_color[ColorGlobal.Type.DEBUG_COLLISION]
		
	debug_color.a = 0.5
