class_name GameManager
extends Node2D

@export var debris_scene: PackedScene
@export var dev_mode: bool = true

# Dev mode options
enum DevClickMode {STILL, DIRECT, ORBITAL}
var _dev_click_mode: DevClickMode = DevClickMode.STILL

@onready var player: Player = $Player


func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_Q:
			_dev_click_mode += 1
			if _dev_click_mode >= DevClickMode.size():
				_dev_click_mode = 0
			print("Toggling to ", DevClickMode.keys()[_dev_click_mode])
			
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var click_position = get_global_mouse_position()
		
		if _dev_click_mode == DevClickMode.STILL:
			spawn_debris(click_position, Vector2.ZERO)
		elif _dev_click_mode == DevClickMode.DIRECT:
			var direct_speed = 7
			var dir_to_planet = player.global_position - click_position
			var direct_velocity = direct_speed * dir_to_planet.normalized()
			spawn_debris(click_position, direct_velocity)
		elif _dev_click_mode == DevClickMode.ORBITAL:
			var dir_to_planet = player.global_position - click_position
			var distance = dir_to_planet.length()
			var speed = sqrt(player.gravity_field.gravity_strength / max(distance, 1.0))
			var tangent = Vector2(-dir_to_planet.y, dir_to_planet.x).normalized()
			spawn_debris(click_position, tangent * speed)



func spawn_debris(position: Vector2, velocity: Vector2):
	var debris = debris_scene.instantiate()
	add_child(debris)
	debris.global_position = position
	debris.velocity = velocity
