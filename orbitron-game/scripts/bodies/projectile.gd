class_name Projectile
extends GamePhysicsBody

@export var destroy_on_hit: bool
@export var initial_lifetime: float = 5

@onready var lifetime_timer = Timer.new()


func _ready():
	super()
	lifetime_timer.one_shot = true
	lifetime_timer.timeout.connect(_on_lifetime_expire)
	lifetime_timer.start(initial_lifetime)


func _on_hitbox_contact(_receiver: HurtboxComponent):
	if destroy_on_hit:
		init_kill.emit()


func _on_lifetime_expire():
	init_kill.emit()


func _kill():
	if _no_kill:
		return
	queue_free()
