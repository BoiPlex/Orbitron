class_name GravBodyFactory
extends Factory


var _grav_body_list: Array[GravAffectedBody] = []


func make():
	var grav_body = base_scene.instantiate() as GravAffectedBody
	grav_body.global_position = make_position
	if random_launch_direction:
		grav_body.velocity = Vector2.from_angle(2 * PI * randf())
	else:
		grav_body.velocity = launch_direction * launch_speed
	_grav_body_list.push_back(grav_body)
	parent.add_child(grav_body)
