extends Node

var _player_name = ""

func _ready():
	_show_ip_addr()
	
func _on_TextField_text_changed(new_text):
	_player_name = new_text

func _on_CreateButton_pressed():
	print("create button pressed")
#	if _player_name == "":
#		return
	Network.create_server()

func _on_JoinButton_pressed():
	print("join button pressed")
	$ip_prompt.visible = true
	$ip_prompt_text.visible = true
	$ok.visible = true

func _load_game():
	var ins = preload("res://scenes/mp.tscn").instance()
	add_child(ins)
	Network.coin_toss_init()

func _show_ip_addr():
	$Label.set_text("Your ip address is " + str(IP.get_local_addresses()[0]))

func _on_start_pressed():
	Network.load_game_for_each_other()

func _change_coinbox_visibility():
	$"mp"._change_coinbox_visibility()

func _server_won_the_toss():
	Network.server_toss_win()

func _client_won_the_toss():
	Network.client_toss_win()

func _exec_stw():
	if get_tree().is_network_server():
		$"mp/coin_toss/VBoxContainer/decider".popup()
	else:
		$"mp/coin_toss/VBoxContainer/decider".popup()
		$"mp/coin_toss/VBoxContainer/decider/VBoxContainer/Label".set_text("You lost the toss. Waiting for the opponent's action...")
		$"mp/coin_toss/VBoxContainer/decider/VBoxContainer/batting".visible = false
		$"mp/coin_toss/VBoxContainer/decider/VBoxContainer/bowling".visible = false
func _exec_ctw():
	if not get_tree().is_network_server():
		$"mp/coin_toss/VBoxContainer/decider".popup()
	else:
		$"mp/coin_toss/VBoxContainer/decider".popup()
		$"mp/coin_toss/VBoxContainer/decider/VBoxContainer/Label".set_text("You lost the toss. Waiting for the opponent's action...")
		$"mp/coin_toss/VBoxContainer/decider/VBoxContainer/batting".visible = false
		$"mp/coin_toss/VBoxContainer/decider/VBoxContainer/bowling".visible = false


func _on_quit_pressed():
	if get_tree().change_scene("res://scenes/menu.tscn") != OK:
		print("change scene error mp")


func _on_ok_pressed():
	var my_text = $ip_prompt.text
	if my_text == null:
		my_text = ""
	print("my_text  = " + str(my_text))
	Network.join_server(my_text)
