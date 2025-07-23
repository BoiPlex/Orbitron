class_name DebugBodyFactory
extends GravBodyFactory

# Dev mode options
enum DevClickMode {STILL, DIRECT, ORBITAL}
var _dev_click_mode: DevClickMode = DevClickMode.STILL
var player: Player

func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_Q:
			_dev_click_mode += 1
			if _dev_click_mode >= DevClickMode.size():
				_dev_click_mode = 0
			print("Toggling to ", DevClickMode.keys()[_dev_click_mode])
			
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		var click_position = get_global_mouse_position()
			
		if _dev_click_mode == DevClickMode.STILL:
			launch_location(click_position, Vector2.ZERO)
		elif _dev_click_mode == DevClickMode.DIRECT:
			var direct_speed = 7
			var dir_to_planet = player.global_position - click_position
			var direct_velocity = direct_speed * dir_to_planet.normalized()
			launch_location(click_position, direct_velocity)
		elif _dev_click_mode == DevClickMode.ORBITAL:
			var dir_to_planet = player.global_position - click_position
			var distance = dir_to_planet.length()
			var speed = sqrt(player.gravity_field.gravity_strength / max(distance, 1.0))
			var tangent = Vector2(-dir_to_planet.y, dir_to_planet.x).normalized()
			launch_location(click_position, tangent * speed)
			
