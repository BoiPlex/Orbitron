extends Label


func _ready():
	change_text_to_money_cash(GameStateGlobal.get_money())
	GameStateGlobal.money_changed.connect(_on_money_changed)


func _on_money_changed(value: int):
	change_text_to_money_cash(value)


func change_text_to_money_cash(value: int):
	text = str("$", value)
