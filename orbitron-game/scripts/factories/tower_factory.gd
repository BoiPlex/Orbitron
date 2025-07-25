class_name TowerFactory
extends GravBodyFactory

@export var target_position: Vector2


func _ready():
	set_active_tower_factory()


func set_active_tower_factory():
	ReferencesGlobal.tower_factory = self


func make():
	var tower_stats = class_stats as TowerStats
	if tower_stats == null:
		push_warning("Tried to initialize null tower.")
		return
	var tower = base_scene.instantiate() as Tower
	tower.ready_position = target_position
	tower.global_position = make_position
	tower.debug_build_template = null
	parent.add_child(tower)
	tower.init_game_entity(tower_stats)
	tower.init_tower(tower_stats)
	tower.start_readying()
	
