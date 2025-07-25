class_name EnemyFactory
extends GravBodyFactory


const MAKE_RADIUS = 600

@export var enemy_list_candidates: Array[EnemyStats]

var num_candidates: int
var difficulty_timer: Timer
var spawn_timer: Timer
var credits: int
var target: Node2D


func _ready():
	difficulty_timer = Timer.new()
	difficulty_timer.one_shot = false
	add_child(difficulty_timer)
	difficulty_timer.start(3.0)
	difficulty_timer.timeout.connect(_on_difficulty_timer_timeout)
	
	spawn_timer = Timer.new()
	spawn_timer.one_shot = false
	add_child(spawn_timer)
	spawn_timer.start(4.0)
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	
	num_candidates = len(enemy_list_candidates)
	target = ReferencesGlobal.active_player


func make():
	var rand_dir: Vector2 = Vector2(0, -1.0).rotated(randf_range(-0.6 * PI, 0.6 * PI)).normalized()
	var new_guy = base_scene.instantiate() as Enemy
	new_guy.global_position = rand_dir * MAKE_RADIUS
	new_guy.target = target
	parent.add_child(new_guy)
	new_guy.init_game_entity(class_stats)
	new_guy.init_enemy(class_stats)
	


func _on_difficulty_timer_timeout():
	GameStateGlobal.difficulty += 1
	credits += 3 + (GameStateGlobal.difficulty / 10) * log(GameStateGlobal.difficulty) / log(4)


func _on_spawn_timer_timeout():
	for i in range(GameStateGlobal.difficulty / 5 + 1):
		_try_spawn_enemies()


func _try_spawn_enemies():
	for i in range(log(GameStateGlobal.difficulty) / log(2)):
		var ind = randi_range(0, num_candidates - 1)
		var check_enemy = enemy_list_candidates[ind]
		if _check_difficulty(check_enemy) and check_enemy.cost <= credits:
			class_stats = enemy_list_candidates[ind]
			make()
			credits -= check_enemy.cost
			break


func _check_difficulty(stats: EnemyStats) -> bool:
	if (GameStateGlobal.difficulty >= stats.min_difficulty and 
		GameStateGlobal.difficulty <= stats.max_difficulty):
			return true
	return false
