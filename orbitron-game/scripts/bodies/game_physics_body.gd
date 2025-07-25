class_name GamePhysicsBody
extends CharacterBody2D

signal hitbox_contact(receiver: HurtboxComponent)
signal hurtbox_contact(sender: HitboxComponent)
signal init_kill

const TERMINAL_VELOCITY = 20

@export var entity_name: String
@export var pushable: bool = true
@export var mass: float = 10
@export var contact_knockback: float = 1
@export var make_on_kill: Array[Factory]

@onready var sprite = get_node_or_null("Sprite2D") as Sprite2D
@onready var hitbox = get_node_or_null("HitboxComponent") as HitboxComponent
@onready var hurtbox = get_node_or_null("HurtboxComponent") as HurtboxComponent
@onready var collider = get_node_or_null("ColoredCollider") as CollisionShape2D

var direction: Vector2

var _no_kill: bool = false


func _ready():
	hitbox_contact.connect(_on_hitbox_contact)
	hurtbox_contact.connect(_on_hurtbox_contact)
	init_kill.connect(_kill)


func init_team(team: TeamsGlobal.Team):
	if hitbox != null:
		hitbox.collision_mask = TeamsGlobal.teamHitbox[team]
	if hurtbox != null:
		hurtbox.collision_layer = TeamsGlobal.teamHurtbox[team]


func init_game_entity(stats: PhysicsBodyStats):
	entity_name = stats.entity_name
	mass = stats.mass
	if sprite != null:
		sprite.texture = stats.sprite_texture
	if hurtbox != null:
		hurtbox.max_health = stats.max_health
		hurtbox.health = stats.max_health
	if hitbox != null:
		hitbox.damage = stats.contact_damage
	contact_knockback = stats.contact_knockback


func disable_self():
	if hitbox:
		hitbox.set_deferred("monitorable", false)
		hitbox.set_deferred("monitoring", false)
	if hurtbox:
		hurtbox.set_deferred("monitorable", false)
		hurtbox.set_deferred("monitoring", false)
	if collider:
		collider.set_deferred("disabled", true)
	hide()


func enable_self():
	if hitbox:
		hitbox.set_deferred("monitorable", true)
		hitbox.set_deferred("monitoring", true)
	if hurtbox:
		hurtbox.set_deferred("monitorable", true)
		hurtbox.set_deferred("monitoring", true)
	if collider:
		collider.set_deferred("disabled", false)


func force_push(push_dir: Vector2, force: float):
	velocity += push_dir.normalized() * force / mass
	velocity.clampf(0.0, TERMINAL_VELOCITY)


func _on_hitbox_contact(receiver: HurtboxComponent):
	var target = receiver.parent
	if pushable and target is GamePhysicsBody:
		force_push(target.global_position.direction_to(global_position), 
			target.velocity.length() / 4  * target.mass)


func _on_hurtbox_contact(sender: HitboxComponent):
	var target = sender.parent
	if pushable and target is GamePhysicsBody:
		force_push(target.global_position.direction_to(global_position), 
			(target.velocity.length() / 4) * target.mass + target.contact_knockback)


func _kill():
	if not _no_kill:
		for factory in make_on_kill:
			factory.make()
	queue_free()
	

func _physics_process(delta):
	move_and_slide()
