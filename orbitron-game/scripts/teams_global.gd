extends Node

# Collision Masks
# ---------------
# 1: General Collision
# 2: Ally Hitbox
# 3: Ally Hurtbox
# 4: Enemy Hitbox
# 5: Enemy Hurtbox
# 6: Neutral Hitbox
# 7: Neutral Hurtbox

enum Team {
	ALLY,
	ENEMY,
	NEUTRAL,
}


const teamHurtbox: Dictionary[Team, Vector2i] = {
	Team.ALLY: Vector2i(0b0000100, 0b0101000),
	Team.ENEMY: Vector2i(0b0010000, 0b0100010),
	Team.NEUTRAL: Vector2i(0b1000000, 0b0101010),
}


const teamHitbox: Dictionary[Team, Vector2i] = {
	Team.ALLY: Vector2i(0b0000010, 0b1010000),
	Team.ENEMY: Vector2i(0b0001000, 0b1000100),
	Team.NEUTRAL: Vector2i(0b0100000, 0b1010100),
}
