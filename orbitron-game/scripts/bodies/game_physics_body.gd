class_name GamePhysicsBody
extends CharacterBody2D

signal hitbox_contact(receiver: HurtboxComponent)
signal hurtbox_contact(sender: HitboxComponent)
signal init_kill

@export var entity_name: String
@export var pushable: bool = true
@export var mass: float = 10
@export var make_on_kill: Array[Factory]

@onready var sprite = $Sprite2D as Sprite2D
@onready var hitbox = $HitboxComponent as HitboxComponent
@onready var hurtbox = $HurtboxComponent as HurtboxComponent
@onready var collider = $ColoredCollider as CollisionShape2D

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
	entity_name = stats.name
	mass = stats.mass
	if sprite != null:
		sprite.texture = stats.sprite
	if hurtbox != null:
		hurtbox.max_health = stats.max_health
		hurtbox.health = stats.max_health
	if hitbox != null:
		hitbox.damage = stats.contact_damage


func force_push(push_dir: Vector2, force: float):
	velocity += push_dir.normalized() * force / mass


func _on_hitbox_contact(_receiver: HurtboxComponent):
	pass


func _on_hurtbox_contact(sender: HitboxComponent):
	if pushable and sender.parent is GamePhysicsBody:
		force_push(sender.parent.velocity.normalized(), 
			sender.parent.velocity.length() * sender.parent.mass)


func _kill():
	if not _no_kill:
		for factory in make_on_kill:
			factory.make()
