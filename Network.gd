extends Node

var DEFAULT_IP = "127.0.0.1"
const DEFAULT_PORT = 31400
const MAX_CLIENTS = 2

func create_server():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(DEFAULT_PORT, MAX_CLIENTS)
	get_tree().set_network_peer(peer)
	
func join_server(txt):
	var peer = NetworkedMultiplayerENet.new()
	if txt == "":
		peer.create_client(DEFAULT_IP, DEFAULT_PORT)
	else:
		peer.create_client(str(txt), DEFAULT_PORT)
	get_tree().set_network_peer(peer)

func pass_check_val(val):
	rpc("get_val", val)
	
remote func get_val(val):
	get_node("/root/Main").set_their_num(val)
	
## COIN TOSS EVENT ##

func coin_toss():
	if get_tree().is_network_server():
		get_node("/root/menu/multiplayer_toss").server_coin_toss_action()
	else:
		get_node("/root/menu/multiplayer_toss").client_coin_toss_action()

func ask_opponent_choice_rpc():
	rpc("ask_opponent_choice")
	
remote func ask_opponent_choice():
	get_node("/root/menu/multiplayer_toss").their_choice()

