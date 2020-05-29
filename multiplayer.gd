extends Node

const DEFAULT_IP = '127.0.0.1'
const DEFAULT_PORT = 31400
const MAX_PLAYERS = 2

var players = { }
var self_data = { name = '', hand_move = 3}

var moves_in_a_turn = 0
var move_made = false

signal player_disconnected
signal server_disconnected

func _ready():
	get_tree().connect('network_peer_disconnected', self, '_on_player_disconnected')
	get_tree().connect('network_peer_connected', self, '_on_player_connected')

func create_server(player_nickname):
	self_data.name = player_nickname
	players[1] = self_data
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(DEFAULT_PORT, MAX_PLAYERS)
	get_tree().set_network_peer(peer)

func connect_to_server(player_nickname):
	self_data.name = player_nickname
	get_tree().connect('connected_to_server', self, '_connected_to_server')
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(DEFAULT_IP, DEFAULT_PORT)
	get_tree().set_network_peer(peer)

func _connected_to_server():
	var local_player_id = get_tree().get_network_unique_id()
	players[local_player_id] = self_data
	rpc('_send_player_info', local_player_id, self_data)

func _on_player_disconnected(id):
	players.erase(id)

func _on_player_connected(connected_player_id):
	var local_player_id = get_tree().get_network_unique_id()
	if not(get_tree().is_network_server()):
		rpc_id(1, '_request_player_info', local_player_id, connected_player_id)

remote func _request_player_info(request_from_id, player_id):
	if get_tree().is_network_server():
		rpc_id(request_from_id, '_send_player_info', player_id, players[player_id])
remote func _request_players(request_from_id):
	if get_tree().is_network_server():
		for peer_id in players:
			if( peer_id != request_from_id):
				rpc_id(request_from_id, '_send_player_info', peer_id, players[peer_id])

remote func _send_player_info(id, info):
	players[id] = info
#	var new_player = load('res://scenes/player_mp.tscn').instance()
#	new_player.name = str(id)
#	new_player.set_network_master(id)
#	$'/root/menu/base_game_multiplayer'.add_child(new_player)
#	new_player.init(info.name, info.hand_move, true)
	
remote func _finalise_wait_proceed():
	if moves_in_a_turn == 0:
		print("yaw")
		return
	elif moves_in_a_turn == 1 and move_made:
		print("one guy made move")
	elif moves_in_a_turn == 2:
		print("second guy also made the move")
		rpc("_reset_vars")
	else:
		print("not good")
		
remotesync func _set_moves_in_a_turn():
	print("_set_moves_in_a_turn:")
	rset(str(moves_in_a_turn), 1)
	print("value of moves_in_a_turn = " + str(moves_in_a_turn))

remotesync func _reset_vars():
	print("Multiplayer._reset_vars entered")
	rset("moves_in_a_turn", 0)
	rset("move_made", false)
		
remotesync func _show_hand_moves():
	pass
	
func update_move(id, hand_move):
	players[id].hand_move = hand_move
