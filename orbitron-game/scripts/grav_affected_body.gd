class_name GravAffectedBody
extends CharacterBody2D

var display_path: bool
var pulled_to_fields: Array[GravityField]

func _ready() -> void:
	pass
	

func add_field(field: GravityField):
	if !pulled_to_fields.has(field):
		pulled_to_fields.push_back(field)
	else:
		push_warning("Tried to attach field to body already attached.")

func remove_field(field: GravityField):
	if pulled_to_fields.has(field):
		pulled_to_fields.erase(field)
	else:
		push_warning("Tried to detach field from body that was not attached.")
		

func _physics_process(delta: float) -> void:
	move_and_slide()
	for field in pulled_to_fields:
		var dir_to_center = field.global_position - global_position
		var distance = dir_to_center.length()
		var gravity_force = field.gravity_strength / max(distance * distance, 1.0)
		var velocity_change = dir_to_center.normalized() * gravity_force * delta
		velocity += velocity_change
