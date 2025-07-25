class_name Player
extends StaticBody2D

@onready var gravity_field: GravityField = $GravityField

func _ready():
	ReferencesGlobal.active_player = self
	pass
