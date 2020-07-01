extends Node

var DEFAULT_IP = "127.0.0.1"
const DEFAULT_PORT = 31400
const MAX_CLIENTS = 2

func create_server():
	print("create server pressed")
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(DEFAULT_PORT, MAX_CLIENTS)
	get_tree().set_network_peer(peer)
	
func join_server(txt):
	print("join server pressed")
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

func coin_toss_init():
	print("coin_toss_init invoked")
	rpc("cti")

func load_game_for_each_other():
	rpc("lgfeo")

remotesync func lgfeo():
	get_node("/root/menu/multiplayer")._load_game()
	
remote func cti():
	print("cti invoked")
	if not get_tree().is_network_server():
		get_node("/root/menu/multiplayer")._change_coinbox_visibility()

func server_toss_win():
	rpc("stw")

func client_toss_win():
	rpc("ctw")
	
remotesync func stw():
	print("stw")
	get_node("/root/menu/multiplayer")._exec_stw()

remotesync func ctw():
	print("ctw")
	get_node("/root/menu/multiplayer")._exec_ctw()

func _set_opp_bat_or_bowl(val):
	rpc("sobob",val)

remote func sobob(val):
	get_node("/root/menu/multiplayer/mp")._exec_sobob(val)

func _start_game():
	rpc("_sg")

remotesync func _sg():
	get_node("/root/menu/multiplayer/mp")._exec_sg()

func _pass_val_to_opp(val):
	rpc("pvto",val)

remote func pvto(val):
	get_node("/root/menu/multiplayer/mp")._exec_pvto(val)
