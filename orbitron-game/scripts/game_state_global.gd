extends Node


signal start_game
signal finish_game
signal money_changed(new_value: int)
signal world_health_changed(new_value: int)

const STARTING_CASH: int = 9999
const WORLD_MAX_HEALTH: int = 1000

var world_health: int = 1000

var _money: int = 0
var _active_world: GameWorld


func _ready():
	start_game.connect(_init_game)
	set_money(STARTING_CASH)


func set_active_world(world: GameWorld):
	_active_world = world


func get_active_world() -> GameWorld:
	return _active_world


func get_money() -> int:
	return _money


func set_money(value: int):
	_money = value
	print("value")
	money_changed.emit(_money)


func add_money(value: int):
	_money += value
	money_changed.emit(_money)


func try_spend_money(value: int) -> bool:
	if _money < value:
		return false
	else:
		_money -= value
		money_changed.emit(_money)
		return true


func take_damage(value: int):
	world_health = clampi(world_health - value, 0, WORLD_MAX_HEALTH)
	world_health_changed.emit(world_health)


func _init_game():
	_money = 0
	world_health = WORLD_MAX_HEALTH
