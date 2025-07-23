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
		make_position = get_global_mouse_position()
			
		if _dev_click_mode == DevClickMode.STILL:
			launch_speed = 0
			make()
		elif _dev_click_mode == DevClickMode.DIRECT:
			launch_speed = 7
			launch_direction = player.global_position - make_position
			make()
		elif _dev_click_mode == DevClickMode.ORBITAL:
			var dir_to_planet = player.global_position - make_position
			var distance = dir_to_planet.length()
			launch_speed = sqrt(player.gravity_field.gravity_strength / max(distance, 1.0))
			launch_direction = Vector2(-dir_to_planet.y, dir_to_planet.x).normalized()
			make()
			
