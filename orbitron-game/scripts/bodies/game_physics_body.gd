class_name GamePhysicsBody
extends CharacterBody2D

signal hitbox_contact(receiver: HurtboxComponent)
signal hurtbox_contact(sender: HitboxComponent)
signal init_kill

@export var pushable: bool = true
@export var mass: float = 10
@export var make_on_kill: Array[Factory]

var direction: Vector2

var _no_kill: bool = false


func _ready():
	hitbox_contact.connect(_on_hitbox_contact)
	hurtbox_contact.connect(_on_hurtbox_contact)
	init_kill.connect(_kill)


func force_push(push_dir: Vector2, force: float):
	velocity += push_dir.normalized() * force / mass


func _on_hitbox_contact(_receiver: HurtboxComponent):
	pass


func _on_hurtbox_contact(sender: HitboxComponent):
	if pushable and sender.parent is GamePhysicsBody:
		force_push(sender.parent.velocity.normalized(), 
			sender.parent.velocity.length() * sender.parent.mass)


func _kill():
	for factory in make_on_kill:
		factory.make()
