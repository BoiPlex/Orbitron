class_name GravBodyFactory
extends Factory


var _grav_body_list: Array[GravAffectedBody] = []


func launch_location(pos: Vector2, velocity: Vector2):
	var grav_body = base_scene.instantiate() as GravAffectedBody
	grav_body.global_position = pos
	grav_body.velocity = velocity
	_grav_body_list.push_back(grav_body)
	parent.add_child(grav_body)
