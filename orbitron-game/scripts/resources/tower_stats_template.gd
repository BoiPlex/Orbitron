class_name TowerStats
extends PhysicsBodyStats

@export_category("Upgrade Path")
@export var upgrades_to: TowerStats
@export var cost: int = 100
@export_category("Offense")
@export var projectile: ProjectileStats
@export var fire_rate: float = 1
@export var detection_range: float = 200
