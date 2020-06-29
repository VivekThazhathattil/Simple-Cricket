extends Node2D
var toss = 0
var _batting = false
var ply_send = false
var opp_send = false
var ply_num = 0
var opp_num = 0
var ply_score = 0
var opp_score = 0
var ball_count = 0

func _ready():
	$base_game.visible = false
	$coin_toss.visible = true
	toss = randi()%2

func _on_heads_or_tails_pressed():
	if toss == 0: # server won the toss
		$".."._server_won_the_toss()
	else: # client won the toss
		$".."._client_won_the_toss()

func _change_coinbox_visibility():
	$coin_toss/VBoxContainer/HBoxContainer.visible = false
	$coin_toss/VBoxContainer/coin_toss_text.visible = false


func _on_batting_pressed():
	_batting = true
	Network._set_opp_bat_or_bowl(not _batting)
	Network._start_game()

func _on_bowling_pressed():
	_batting = false
	Network._set_opp_bat_or_bowl(not _batting)
	Network._start_game()

func _exec_sobob(bool_val):
	_batting = bool_val
	print("_batting = " + str(bool_val))

func _exec_sg():
	$coin_toss/VBoxContainer/decider.visible = false
	$coin_toss.visible = false
	$base_game.visible = true

func _exec_pvto(val):
	opp_send = true
	opp_num = val
	if ply_send and opp_send:
		ball_count += 1
		_temp_fn()
		_set_score()
		_set_display()
	
func _temp_fn():
	if ball_count == 5:
		get_tree().quit()

func _handle_val_display(val):
	ply_num = val
	Network._pass_val_to_opp(ply_num)
	ply_send = true
	if ply_send and opp_send:
		ball_count += 1
		_temp_fn()
		_set_score()
		_set_display()

func _set_display():
	if _batting:
		$"base_game/VBoxContainer/player".set_text("Player: " + str(ply_score))
		$"base_game/VBoxContainer/opponent".set_text("Opp: Overs = " + str(ball_count))
	else:
		$"base_game/VBoxContainer/opponent".set_text("Opp: " + str(opp_score))
		$"base_game/VBoxContainer/player".set_text("Player: Overs = " + str(ball_count))
		
	$"base_game/VBoxContainer/action/ply".set_text(str(ply_num))
	$"base_game/VBoxContainer/action/opp".set_text(str(opp_num))
	ply_send = false
	opp_send = false

func _on_1_pressed():
	_handle_val_display(1)


func _on_2_pressed():
	_handle_val_display(2)


func _on_3_pressed():
	_handle_val_display(3)


func _on_4_pressed():
	_handle_val_display(4)


func _on_5_pressed():
	_handle_val_display(5)


func _on_6_pressed():
	_handle_val_display(6)

func _set_score():
	if _batting:
		ply_score += ply_num
	else:
		opp_score += opp_num
