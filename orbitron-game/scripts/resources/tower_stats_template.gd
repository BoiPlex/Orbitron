class_name TowerStats
extends PhysicsBodyStats

@export_category("Upgrade Path")
@export var upgrades_to: TowerStats
@export var cost: int = 100
@export_category("Offense")
@export var projectile: ProjectileStats
@export var fire_rate: float = 1
@export_group("Firing Mechanics")
@export_range(0, 12.1) var spread_copies: int = 1
@export_range(0, 2 * PI) var spread_angle: float = 0
@export_range(0, 22.1) var bursts: int = 1
@export_range(0, 1.0) var burst_interval: float = 0
@export var detection_range: float = 200
