extends Node

var _player_name = ""

func _on_TextField_text_changed(new_text):
	_player_name = new_text

func _on_CreateButton_pressed():
	if _player_name == "":
		return
	Multiplayer.create_server(_player_name)
	_load_game()

func _on_JoinButton_pressed():
	if _player_name == "":
		return
	Multiplayer.connect_to_server(_player_name)
	_load_game()

func _load_game():
	var ins = preload("res://scenes/base_game_multiplayer.tscn").instance()
	get_node("/root/menu").add_child(ins)
