extends Node

enum Type {
	ENEMY,
	ALLY_1,
	ALLY_2,
	ALLY_3,
	GRAVITY,
	DEBUG_HITBOX,
	DEBUG_HURTBOX,
}

const type_color: Dictionary[Type, Color] = {
	Type.ENEMY: Color(0.99, 0.0, 0.512),
	Type.ALLY_1: Color(0.0, 0.99, 0.116),
	Type.ALLY_2: Color(0.0, 0.844, 0.976),
	Type.ALLY_3: Color(1.0, 1.0, 0.0),
	Type.GRAVITY: Color(0.0, 0.467, 1.0),
	Type.DEBUG_HITBOX: Color(1.0, 0.0, 0.0),
	Type.DEBUG_HURTBOX: Color(1.0, 0.742, 0.14),
}
