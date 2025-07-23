extends Node

# Collision Masks
# ---------------
# 1: General Collision
# 2: Ally Hurtbox
# 3: Enemy Hurtbox


enum Team {
	ALLY,
	ENEMY,
	NEUTRAL,
}


const teamHurtbox: Dictionary[Team, int] = {
	Team.ALLY: 0b010,
	Team.ENEMY: 0b100,
	Team.NEUTRAL: 0b110,
}


const teamHitbox: Dictionary[Team, int] = {
	Team.ALLY: 0b100,
	Team.ENEMY: 0b010,
	Team.NEUTRAL: 0b110,
}
