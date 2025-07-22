class_name TowerStats
extends Resource

enum Tier {
	I,
	II,
	III,
}

@export_category("General")
@export var sprite: Texture2D
@export var max_health: int = 100
@export var mass: int = 10
@export_category("Upgrade Path")
@export var tier: Tier = Tier.I
@export var upgrades_to: TowerStats
@export var cost: int = 100
@export_category("Offense")
@export var projectile: Resource
@export var fire_rate: float
@export var detection_range: float
