class_name Enemy
extends GravAffectedBody

enum States {
	ACTIVE,
	INACTIVE,
}


@export var speed: float = 50

var bounty: int = 0
var target: Node2D
var target_direction: Vector2 = Vector2.ZERO

var _state: States = States.ACTIVE


func _ready():
	super()
	if target == null:
		push_warning("No target for enemy.")
		return
	target_direction = global_position.direction_to(target.global_position)
	direction = target_direction
	_state = States.ACTIVE


func init_enemy(stats: EnemyStats): 
	speed = stats.speed
	bounty = stats.bounty


func _physics_process(delta):
	super(delta)

	match(_state):
		States.ACTIVE:
			if target == null:
				push_warning("No target for enemy.")
				return
			else:
				target_direction = global_position.direction_to(target.global_position)
				direction = Vector2.from_angle(lerp_angle(direction.angle(), target_direction.angle(), 
				1 - pow(0.25, 13 * delta)))
				velocity = direction * clampf(velocity.length(), speed, INF)
		States.INACTIVE:
			pass


func _kill():
	GameStateGlobal.add_money(bounty)
	super()
