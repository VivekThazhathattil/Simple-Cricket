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
var lost_wickets = 0
var which_innings = 1
var max_wickets = 1
var ovr_size = 6

func _ready():
	$base_game.visible = false
	$coin_toss.visible = true
	$winner.visible = false
	randomize()
	toss = randi()%2
	get_tree().set_quit_on_go_back(false)

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		_on_Back_pressed()
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		_on_Back_pressed()
	
func _on_Back_pressed():
	if get_tree().change_scene("res://scenes/menu.tscn") != OK:
		print("change scene error")


func _on_heads_or_tails_pressed():
	print("toss = " + str(toss))
	if toss == 0: # server won the toss
		print("you won the toss")
		$".."._server_won_the_toss()
	else: # client won the toss
		print("you lost the toss")
		$".."._client_won_the_toss()

func _change_coinbox_visibility():
	$coin_toss/VBoxContainer/HBoxContainer/heads.visible = false
	$coin_toss/VBoxContainer/HBoxContainer/tails.visible = false
	$coin_toss/VBoxContainer/coin_toss_text.set_text("Waiting for opponent to choose heads or tails ...")


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
	$winner.visible = false

func _exec_pvto(val):
	opp_send = true
	opp_num = val
	if ply_send and opp_send:
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
		_set_score()
		_set_display()

func _set_display():
	if _batting:
		$"base_game/VBoxContainer/player".set_text("  Player(Bat) Runs: " + str(ply_score) + " - " + str(lost_wickets))
		$"base_game/VBoxContainer/opponent".set_text("  Opponent(Bowl) Ovr: " + str(ball_count/ovr_size) +  "." + str(ball_count%ovr_size))
	else:
		$"base_game/VBoxContainer/opponent".set_text("  Opponent(Bat) Runs:" + str(opp_score) + " - " + str(lost_wickets))
		$"base_game/VBoxContainer/player".set_text("  Player(Bowl) Ovr: " + str(ball_count/ovr_size) +  "." + str(ball_count%ovr_size))
		
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

func _game_decider():
	pass

func _innings_over():
	$base_game.visible = false
	$Popup.visible = true
	which_innings = 2
	lost_wickets = 0
	_batting = not _batting
	ball_count = 0

func _set_score():
	_check_winner()
	ball_count += 1
	if ply_num == opp_num:
		lost_wickets += 1
		if lost_wickets == max_wickets:
			if which_innings == 2:
				_check_winner()
			else:
				_innings_over()
		ply_num = 0
		opp_num = 0
	else:
		if _batting:
			ply_score += ply_num
		else:
			opp_score += opp_num

func _check_winner():
	if which_innings == 2:
		if _batting and ply_score > opp_score:
			_declare_winner("You")
		elif not _batting and ply_score < opp_score:
			_declare_winner("Opponent")

func _declare_winner(val):
	$base_game.visible = false
	$winner.visible = true
	if val == "You":
		$"winner/Label2".set_text("You won the match!!!")
	else:
		$"winner/Label2".set_text("You lost the match...")
		
func _on_ok_pressed():
	$Popup.visible = false
	$base_game.visible = true


func _on_Button_pressed():
	if get_tree().change_scene("res://scenes/menu.tscn") != OK:
		print("change scene error mp")
