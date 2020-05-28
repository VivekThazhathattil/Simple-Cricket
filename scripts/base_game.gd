extends Node2D
var hand_1 = preload("res://sprites/1.png")
var hand_2 = preload("res://sprites/2.png")
var hand_3 = preload("res://sprites/3.png")
var hand_4 = preload("res://sprites/4.png")
var hand_5 = preload("res://sprites/5.png")
var hand_6 = preload("res://sprites/6.png")
var hand_7 = preload("res://sprites/7.png")
var hand_8 = preload("res://sprites/8.png")
var hand_9 = preload("res://sprites/9.png")
var hand_10 = preload("res://sprites/10.png")

var player_score = 0
var opp_score = 0
var over_count = 0
var over_max = 1
var ball_count = 0
var player_wickets_rem = 10
var opp_wickets_rem = 10
var max_wickets = 10

var num_sides_batted_so_far = 0
var _player_batting
var _not_out = true
var _match_over = false

var player_overs = 0
var opp_overs = 0

func _ready():	
	print("base_game path = " + str(self.get_path()))
	num_sides_batted_so_far += 1
	over_max = get_node("/root/menu").no_overs
	print("over_max =" + str(over_max))
	print("get_node(\"/root/menu\").no_overs =  " + str(get_node("/root/menu").no_overs))
	$player.set_texture(hand_10)
	$opponent.set_texture(hand_10)
	$opponent.flip_h = true
	
func _set_toss_decision():
	_player_batting = $coin_toss._player_batting
	print("base_game:38: coin_toss._player_batting = " + str($coin_toss._player_batting))
	print("base_game:39: _player_batting = " + str(_player_batting))
	_update_labels()

func _end_match():
	yield(get_tree().create_timer(1),"timeout")
	if _match_over:
		if player_score > opp_score:
			$you_won.visible = true
			$you_won/confetti.play("blow")
		elif player_score < opp_score:
			$they_won.visible = true
		else:
			$drawn.visible = true
			
func _final_action():
	queue_free()
	
func _check_if_won():
	if _player_batting and player_score > opp_score and num_sides_batted_so_far == 2:
		print("base_game:59: player has scored more than the opponent")
		_match_over = true
		_end_match()
	elif not _player_batting and opp_score > player_score and num_sides_batted_so_far == 2:
		print("base_game:62: opponent has scored more than the player")
		_match_over = true
		_end_match()
func _main_handler():
	if _player_batting:
		if _not_out:
			player_score += $button_array.instantaneous_score
			$pump_up.set_text("")
			_update_labels()
			_check_if_won()
		else:
			if player_wickets_rem == 1:
				if num_sides_batted_so_far == 1:
					_switch_sides()
				else:
					_update_labels()
					_match_over = true
					_end_match()
			else:
				player_wickets_rem -= 1
				_update_labels()
			$pump_up.set_text("OUT")
			_not_out = true
	else:
		if _not_out:
			opp_score += $button_array.opponent_move
			$pump_up.set_text("")
			_update_labels()
			_check_if_won()
		else:
			if opp_wickets_rem == 1:
				if num_sides_batted_so_far == 1:
					_switch_sides()
				else:
					_update_labels()
					_match_over = true
					_end_match()
			else:
				opp_wickets_rem -= 1
				_update_labels()
			$pump_up.set_text("OUT")
			_not_out = true

	if ball_count == 6*over_max:
		if num_sides_batted_so_far == 1:
			_switch_sides()
		else:
			_match_over = true
			_end_match()

func _reset_hands():
		$player.set_texture(hand_10)
		$opponent.set_texture(hand_10)
	
func _switch_sides():
	num_sides_batted_so_far += 1
	ball_count = 0
	over_count = 0
	if _player_batting == true:
		player_overs = str(ball_count/6) + str(ball_count%6)
	else:
		opp_overs = str(ball_count/6) + str(ball_count%6)
	_player_batting = not _player_batting
	yield(get_tree().create_timer(1),"timeout")
	$innings_over.visible = true
	_reset_hands()

func _update_labels():
	if _player_batting:
		if player_score == 0 and opp_score == 0:
			$pump_up.set_text("Begin!!!")
		elif $button_array.instantaneous_score == 1:
			$pump_up.set_text(str($button_array.instantaneous_score) + " run")
		else:
			$pump_up.set_text(str($button_array.instantaneous_score) + " runs")
		$my_stats/HBoxContainer/your_stat.set_text("You\n(Batting)")
		$opp_stats/HBoxContainer/your_stat.set_text("Opponent\n(Bowling)")
		$my_stats/HBoxContainer/your_stat2.set_text("Score: " + str(player_score) + "-" + str(max_wickets - player_wickets_rem))
		$opp_stats/HBoxContainer/your_stat2.set_text("Overs: " + str(ball_count/6) + "." + str(ball_count%6))
	else:
		if player_score == 0 and opp_score == 0:
			$pump_up.set_text("Begin!!!")
		elif $button_array.opponent_move == 1:
			$pump_up.set_text(str($button_array.opponent_move) + " run")
		else:
			$pump_up.set_text(str($button_array.opponent_move) + " runs")
		$my_stats/HBoxContainer/your_stat.set_text("You\n(Bowling)")
		$opp_stats/HBoxContainer/your_stat.set_text("Opponent\n(Batting)")
		$my_stats/HBoxContainer/your_stat2.set_text("Overs: " + str(ball_count/6) + "." + str(ball_count%6))
		$opp_stats/HBoxContainer/your_stat2.set_text("Score: " + str(opp_score) + "-" + str(max_wickets - opp_wickets_rem))


func _on_continue_pressed():
	_final_action()
	get_tree().change_scene("res://scenes/menu.tscn")

func _on_continue2_pressed():
	$innings_over.visible = false
