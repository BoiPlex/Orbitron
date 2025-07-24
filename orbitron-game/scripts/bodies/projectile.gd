class_name Projectile
extends GamePhysicsBody

@export var destroy_on_hit: bool
@export var initial_lifetime: float = 5

@onready var lifetime_timer = Timer.new()

var disabled: bool = false


func _ready():
	super()
	lifetime_timer.one_shot = true
	lifetime_timer.timeout.connect(_on_lifetime_expire)
	add_child(lifetime_timer)
	lifetime_timer.start(initial_lifetime)


func init_projectile(stats: ProjectileStats):
	destroy_on_hit = stats.destroy_on_hit
	initial_lifetime = stats.lifetime


func _on_hitbox_contact(_receiver: HurtboxComponent):
	if destroy_on_hit:
		init_kill.emit()


func _on_lifetime_expire():
	init_kill.emit()


func _kill():
	if _no_kill:
		return
	disable()


func disable():
	visible = false
	if hitbox:
		hitbox.monitorable = false
		hitbox.monitoring = false
	set_deferred("process_mode", PROCESS_MODE_DISABLED)
	disabled = true


func enable():
	print("asdfasdf")
	visible = true
	if hitbox:
		hitbox.monitorable = true
		hitbox.monitoring = true
	set_deferred("process_mode", PROCESS_MODE_INHERIT)
	disabled = false
