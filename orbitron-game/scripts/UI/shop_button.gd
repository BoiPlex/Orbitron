@tool

class_name ShopButton
extends Button

@export var tower_target: TowerStats:
	set(x):
		text = str(x.entity_name, "\n", x.cost)
		icon = x.sprite_texture
		tower_target = x


func _ready():
	if not Engine.is_editor_hint():
		GameStateGlobal.money_changed.connect(_on_money_changed)
		button_down.connect(_on_click)
	

func _on_click():
	if GameStateGlobal.try_spend_money(tower_target.cost):
		ReferencesGlobal.tower_factory.class_stats = tower_target
		ReferencesGlobal.tower_factory.make()


func _on_money_changed(value: int):
	if value > tower_target.cost:
		modulate = Color(1.0, 1.0, 1.0)
	else:
		modulate = Color(0.5, 0.5, 0.5)
