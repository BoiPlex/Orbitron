class_name PlayerHurtbox
extends HurtboxComponent


func take_damage(damage: int):
	GameStateGlobal.take_damage(damage)
