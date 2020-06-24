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
var balls_per_over = 6
var flag = 0

var num_sides_batted_so_far = 0
var _player_batting
var _not_out = true
var _match_over = false

var player_overs = 0
var opp_overs = 0

var difficulty = 2;

var tournament_mode = false
var my_name = "You"
var opp_name = "Opponent"

func _ready():	
#	print("base_game path = " + str(self.get_path()))
	num_sides_batted_so_far += 1
	$player.set_texture(hand_10)
	$opponent.set_texture(hand_10)
	$opponent.flip_h = true

	$button_array.visible = true
	var save_inst = preload("res://scenes/save.tscn")
	self.add_child(save_inst.instance())
	_create_n_load_save()
	print("my_team choice is " + $save.read_save(2,"my_team"))
	if $save.read_save(2,"my_team") != "none":
		tournament_mode = true
	print("Tournament mode = " + str(tournament_mode))
	if tournament_mode:
		var idx1 = get_parent()._find_idx_of_team($save.read_save(2,"my_team"))
		var idx2 = get_parent()._find_idx_of_team($save.read_save(2,"curr_opponent"))
		$team_logo/my_team_logo.set_texture($save.team_icon_arr[idx1])
		$team_logo/opp_team_logo.set_texture($save.team_icon_arr[idx2])
		my_name = $save.read_save(2, "my_team")
		opp_name = $save.read_save(2, "curr_opponent")
		print("my_name is " +my_name)
		print("curr_opponent is " + opp_name)
		over_max = 5
	else:
		$team_logo.visible = false
		get_node("/root/menu/bg_music").playing = false
		over_max = get_node("/root/menu").no_overs
	# go back to main menu upon pressing back button
	# disable quitting on back press
	get_tree().set_quit_on_go_back(false)

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		_on_Back_pressed()
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		_on_Back_pressed()
	
func _on_Back_pressed():
	if $save.read(2,"my_team") != "none":
		$save.save(2,"my_team","none")
	if get_tree().change_scene("res://scenes/menu.tscn") != OK:
		print("change scene error")

func _create_n_load_save():
	if not $save.read_save(0,"sound"):
		$ambient_sound.stop()
		$special_event_sound.set_volume_db(-80)
	else:
		pass

func _set_toss_decision():
	_player_batting = $coin_toss._player_batting
#	print("base_game:38: coin_toss._player_batting = " + str($coin_toss._player_batting))
#	print("base_game:39: _player_batting = " + str(_player_batting))

func _end_match():
	yield(get_tree().create_timer(0.34),"timeout")
	$button_array.visible = false
	if _match_over:
		if player_score > opp_score:
			$you_won.visible = true
			$you_won/confetti.play("blow")
			if flag == 0:
				flag = 1
				$save.save(1,"games_won",$save.read_save(1,"games_won")+1)
				if tournament_mode:
					get_parent().game_stat = "won"
					get_parent()._my_game_results()
		elif player_score < opp_score:
			$they_won.visible = true
			if flag == 0:
				flag = 1
				$save.save(1,"games_lost",$save.read_save(1,"games_lost")+1)
				if tournament_mode:
					get_parent().game_stat = "lost"
					get_parent()._my_game_results()
		else:
			$drawn.visible = true
			if flag == 0:
				flag = 1
				$save.save(1,"games_drawn",$save.read_save(1,"games_drawn")+1)
				if tournament_mode:
					get_parent().game_stat = "drawn"
					get_parent()._my_game_results()
	_update_labels()
			
func _final_action():
	$save.save(1,"games_played",$save.read_save(1,"games_played")+1)
	# updated games_won, games_lost and games_drawn in _end_match()
	$save.save(1,"percent_win_rate",float($save.read_save(1,"games_won"))/$save.read_save(1,"games_played")*100)
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
			if tournament_mode:
				$squads._if_runs_scored($button_array.instantaneous_score,"player")
			$PUMP/pump_up.set_text("")
			_update_labels()
			_check_if_won()
		else:
			if player_wickets_rem == 1:
				if num_sides_batted_so_far == 1:
					_switch_sides()
					if tournament_mode:
						$squads.curr_ply_idx = 0
						$squads.ply1_idx = 0
						$squads.ply2_idx = 1
				else:
					_match_over = true
					_update_labels()
					_end_match()
			else:
				player_wickets_rem -= 1
				if tournament_mode:
					$squads._if_out()
				_update_labels()
			$PUMP/pump_up.set_text("OUT!")
			$PUMP/pump_up/AnimationPlayer.play("to_red")
			$special_event_sound.stream = load("res://audio/out_sound.ogg")
			$special_event_sound.play()
			_not_out = true
	else:
		if _not_out:
			if $button_array.opponent_move == null:
				$button_array.opponent_move = 0
			opp_score += $button_array.opponent_move
			if tournament_mode:
				$squads._if_runs_scored($button_array.opponent_move,"opponent")
			$PUMP/pump_up.set_text("")
			_update_labels()
			_check_if_won()
		else:
			if opp_wickets_rem == 1:
				if num_sides_batted_so_far == 1:
					_switch_sides()
					if tournament_mode:
						$squads.curr_ply_idx = 0
						$squads.ply1_idx = 0
						$squads.ply2_idx = 1
				else:
					_match_over = true
					_update_labels()
					_end_match()
			else:
				opp_wickets_rem -= 1
				if tournament_mode:
					$squads._if_out()
				_update_labels()
			$PUMP/pump_up.set_text("OUT!")
			$PUMP/pump_up/AnimationPlayer.play("to_red")
			$special_event_sound.stream = load("res://audio/out_sound.ogg")
			$special_event_sound.play()
			_not_out = true

	if ball_count >= 6*over_max:
		if num_sides_batted_so_far == 1:
			_switch_sides()
			if tournament_mode:
				$squads.curr_ply_idx = 0
				$squads.ply1_idx = 0
				$squads.ply2_idx = 1
		else:
			_match_over = true
			_end_match()
	if ball_count > 0 and ball_count%6 == 0:
		if tournament_mode:
			$squads._if_over_over()

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
	$button_array.visible = false

	yield(get_tree().create_timer(1),"timeout")
	$innings_over.visible = true
	_reset_hands()
	_clear_labels()

func _clear_labels():
	$PUMP/pump_up.set_text("Continue...")
	$my_stats/HBoxContainer/your_stat.set_text("")
	$my_stats/HBoxContainer/your_stat2.set_text("")
	$opp_stats/HBoxContainer/your_stat.set_text("")
	$opp_stats/HBoxContainer/your_stat2.set_text("")
	$ColorRect/misc_stats.set_text("Need " + str(abs(player_score-opp_score)+1) + " runs from " + str(over_max*6 - ball_count) + " balls to win.")
	
func _update_labels():
	if _player_batting:
		if player_score == 0 and opp_score == 0:
			$PUMP/pump_up.set_text("Begin!!!")
			$PUMP/pump_up/AnimationPlayer.play("to_white")
			$special_event_sound.stream = load("res://audio/six_sound.ogg")
			$special_event_sound.play()
		elif $button_array.instantaneous_score == 1:
			$PUMP/pump_up.set_text(str($button_array.instantaneous_score) + " run")
		elif $button_array.instantaneous_score == 4:
			$PUMP/pump_up.set_text(str($button_array.instantaneous_score) + " runs!")
			$PUMP/pump_up/AnimationPlayer.play("to_yellow")
			$special_event_sound.stream = load("res://audio/four_sound.ogg")
			$special_event_sound.play()
		elif $button_array.instantaneous_score == 6:
			$PUMP/pump_up.set_text(str($button_array.instantaneous_score) + " runs!!!")
			$PUMP/pump_up/AnimationPlayer.play("to_green")
			$special_event_sound.stream = load("res://audio/six_sound.ogg")
			$special_event_sound.play()
		else:
			$PUMP/pump_up.set_text(str($button_array.instantaneous_score) + " runs")
		$my_stats/HBoxContainer/your_stat.set_text(my_name + "\n(Batting)")
		$opp_stats/HBoxContainer/your_stat.set_text(opp_name + "\n(Bowling)")
		$my_stats/HBoxContainer/your_stat2.set_text("Score: " + str(player_score) + "-" + str(max_wickets - player_wickets_rem))
		$opp_stats/HBoxContainer/your_stat2.set_text("Overs: " + str(ball_count/6) + "." + str(ball_count%6))
	else:
		if player_score == 0 and opp_score == 0:
			$PUMP/pump_up.set_text("Begin!!!")
			$PUMP/pump_up/AnimationPlayer.play("to_white")
			$special_event_sound.stream = load("res://audio/six_sound.ogg")
			$special_event_sound.play()
		elif $button_array.opponent_move == 4:
			$PUMP/pump_up.set_text(str($button_array.opponent_move) + " runs!")
			$PUMP/pump_up/AnimationPlayer.play("to_yellow")
			$special_event_sound.stream = load("res://audio/four_sound.ogg")
			$special_event_sound.play()
		elif $button_array.opponent_move == 6:
			$PUMP/pump_up.set_text(str($button_array.opponent_move) + " runs!!!")
			$PUMP/pump_up/AnimationPlayer.play("to_green")
			$special_event_sound.stream = load("res://audio/six_sound.ogg")
			$special_event_sound.play()
		elif $button_array.opponent_move == 1:
			$PUMP/pump_up.set_text(str($button_array.opponent_move) + " run")
		else:
			$PUMP/pump_up.set_text(str($button_array.opponent_move) + " runs")
		$my_stats/HBoxContainer/your_stat.set_text(my_name +"\n(Bowling)")
		$opp_stats/HBoxContainer/your_stat.set_text(opp_name + "\n(Batting)")
		$my_stats/HBoxContainer/your_stat2.set_text("Overs: " + str(ball_count/6) + "." + str(ball_count%6))
		$opp_stats/HBoxContainer/your_stat2.set_text("Score: " + str(opp_score) + "-" + str(max_wickets - opp_wickets_rem))
	if num_sides_batted_so_far == 1:
		if _player_batting:
			if ball_count == 0:
				$ColorRect/misc_stats.set_text("Current runrate: -")
			else:
				print(str(ball_count/balls_per_over + 0.1*(ball_count%balls_per_over)))
				$ColorRect/misc_stats.set_text("Current runrate: " + str(stepify(float(player_score)/ball_count*balls_per_over,0.01)))
		else:
			if ball_count == 0:
				$ColorRect/misc_stats.set_text("Current runrate: -")
			else:
				print(str(ball_count/balls_per_over + 0.1*(ball_count%balls_per_over)))
				$ColorRect/misc_stats.set_text("Current runrate: " + str(stepify(float(opp_score)/ball_count*balls_per_over,0.01)))
	elif num_sides_batted_so_far == 2:
		if randi()%2 == 0:
			if not _match_over:
				$ColorRect/misc_stats.set_text("Need " + str(abs(player_score-opp_score)+1) + " runs from " + str(over_max*6 - ball_count) + " balls to win.")
			else:
				$ColorRect/misc_stats.set_text("Match finished!")
		else:
			if not _match_over:
				if _player_batting:
					if ball_count == 0 or ball_count == over_max*balls_per_over:
						$ColorRect/misc_stats.set_text("Current runrate: -")
					else:
						$ColorRect/misc_stats.set_text("Current runrate: " + str(stepify(float(player_score)/ball_count*balls_per_over,0.01)) + "\n required runrate: " + str(stepify(float(opp_score-player_score)/(balls_per_over*over_max-ball_count)*balls_per_over,0.01)))
				else:
					if ball_count == 0 or ball_count == over_max*balls_per_over:
						$ColorRect/misc_stats.set_text("Current runrate: -")
					else:
						$ColorRect/misc_stats.set_text("Current runrate: " + str(stepify(float(opp_score)/ball_count*balls_per_over,0.01)) + "\n required runrate: " + str(stepify(float(player_score-opp_score)/(balls_per_over*over_max-ball_count)*balls_per_over,0.01)))
			else:
				$ColorRect/misc_stats.set_text("Match finished!")
func _on_continue_pressed():
	_final_action()
	if not tournament_mode:
		if get_tree().change_scene("res://scenes/menu.tscn") != OK:
			print("change scene error")

func _on_continue2_pressed():

	$innings_over.visible = false
	$button_array.visible = true

func _on_AnimationPlayer_animation_finished(_anim_name):
	$PUMP/pump_up.set("custom_colors/font_color", Color(1,1,1,1))
	$PUMP/pump_up.set("custom_fonts/font:size", str(50))
	print("animatiom finished")


func _on_Button_pressed():
	print("button pressed")
	if not _match_over and num_sides_batted_so_far == 2:
		print("match not over")
		if not "Current" in $ColorRect/misc_stats.get_text():
			print("current in misc_stats")
			if _player_batting:
				print("player batting")
				if ball_count == 0 or ball_count == over_max*balls_per_over:
					$ColorRect/misc_stats.set_text("Current runrate: -")
				else:
					print("printing current run rate")
					$ColorRect/misc_stats.set_text("Current runrate: " + str(stepify(float(player_score)/ball_count*balls_per_over,0.01)) + "\n required runrate: " + str(stepify(float(opp_score-player_score)/(balls_per_over*over_max-ball_count)*balls_per_over,0.01)))
			else:
				if ball_count == 0 or ball_count == over_max*balls_per_over:
					$ColorRect/misc_stats.set_text("Current runrate: -")
				else:
					$ColorRect/misc_stats.set_text("Current runrate: " + str(stepify(float(opp_score)/ball_count*balls_per_over,0.01)) + "\n required runrate: " + str(stepify(float(player_score-opp_score)/(balls_per_over*over_max-ball_count)*balls_per_over,0.01)))
		else:
			print("current not in misc_stats")
			$ColorRect/misc_stats.set_text("Need " + str(abs(player_score-opp_score)+1) + " runs from " + str(over_max*6 - ball_count) + " balls to win.")
	elif not _match_over and num_sides_batted_so_far == 1:
		print("match not over and num_sides is 1")
		if not "Current" in $ColorRect/misc_stats.get_text():
					print("current found in misc_stats")
					if _player_batting:
						if ball_count == 0:
							$ColorRect/misc_stats.set_text("Current runrate: -")
						else:
							print(str(ball_count/balls_per_over + 0.1*(ball_count%balls_per_over)))
							$ColorRect/misc_stats.set_text("Current runrate: " + str(stepify(float(player_score)/ball_count*balls_per_over,0.01)))
					else:
						if ball_count == 0:
							$ColorRect/misc_stats.set_text("Current runrate: -")
						else:
							print(str(ball_count/balls_per_over + 0.1*(ball_count%balls_per_over)))
							$ColorRect/misc_stats.set_text("Current runrate: " + str(stepify(float(opp_score)/ball_count*balls_per_over,0.01)))
		else:
			print("current not in misc_stats")
			$ColorRect/misc_stats.set_text("Odd or Even Hand Cricket")
	else:
		$ColorRect/misc_stats.set_text("Match finished!")


func _on_MenuButton_pressed():
	pass # Replace with function body.


func _on_scorecard_button_pressed():
	$squads._print_scorecard()
	$squads.visible = true
