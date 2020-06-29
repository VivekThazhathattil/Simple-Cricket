extends Node

var _player_name = ""

func _on_TextField_text_changed(new_text):
	_player_name = new_text

func _on_CreateButton_pressed():
	print("create button pressed")
#	if _player_name == "":
#		return
	Network.create_server()

func _on_JoinButton_pressed():
	print("join button pressed")
#	if _player_name == "":
#		return
	Network.join_server("")

func _load_game():
	var ins = preload("res://scenes/mp.tscn").instance()
	add_child(ins)
	Network.coin_toss_init()


func _on_start_pressed():
	Network.load_game_for_each_other()

func _change_coinbox_visibility():
	$"mp"._change_coinbox_visibility()

func _server_won_the_toss():
	Network.server_toss_win()

func _client_won_the_toss():
	Network.client_toss_win()

func _exec_stw():
	$"mp/coin_toss/VBoxContainer/decider".popup()

func _exec_ctw():
	$"mp/coin_toss/VBoxContainer/decider".popup()

