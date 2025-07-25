@tool

class_name ShopButton
extends Button

@export var tower_target: TowerStats:
	set(x):
		text = str(x.entity_name, "\n", x.cost)
		icon = x.sprite_texture
		tower_target = x
