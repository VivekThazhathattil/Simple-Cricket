extends GridContainer
var opponent_move = 6
var instantaneous_score = 0
var classic_mode = true #remove init later
var max_nums_allowed = 10
#var wght_arr = [2, 4, 7, 12, 25, 50]
func _ready():
	if classic_mode:
		$Button7.visible = false
		$Button8.visible = false
		$Button9.visible = false
		$Button10.visible = false
		max_nums_allowed = 6
	pass
	
func _get_opponent_move(wght_arr):
	var rnd = randi()%100
	for i in range(6):
		if rnd < wght_arr[i]:
			return i+1
		rnd -= wght_arr[i]
		
func _get_req_runrate():
	var rr
	if get_parent().over_max*6 - get_parent().ball_count <= 0:
		rr = 0
	else:
		rr = float (get_parent().player_score - get_parent().opp_score)/(get_parent().over_max*6 - get_parent().ball_count)
	print(rr)
	if rr >= 0 and rr <= 6:
		return rr
	else:
		return 6
		
func adjust_for_player_difficulty(opponent_move, instantaneous_score):
	if instantaneous_score == opponent_move:
		if not get_parent()._player_batting:
			if(randi()%get_parent().difficulty == 0):
				get_parent()._not_out = false
			else:
				if opponent_move == 6:
					opponent_move = randi()%5 + 1
				else:
					opponent_move += 1
		else:
			get_parent()._not_out = false
	return opponent_move
	
func get_opponent_action():
	randomize()
	if classic_mode:
		if get_parent()._player_batting:
			opponent_move = _get_opponent_move([2, 4, 7, 12, 25, 50])
		elif not get_parent()._player_batting and get_parent().num_sides_batted_so_far == 1:
			opponent_move = _get_opponent_move([8, 12, 16, 18, 20, 25])
		elif not get_parent()._player_batting and get_parent().num_sides_batted_so_far == 2:
			var rr = _get_req_runrate()
			if rr >= 6:
				opponent_move = randi()%6 + 1
			elif int(rr) == 0:
				opponent_move = randi()%6 + 1
			elif rr < 5:
				opponent_move = int(rr) + randi()%int(7-rr)
			else:
				opponent_move = 5 + randi()%2
		else:
			opponent_move = randi()%6 + 1
	else:
		opponent_move = randi()%10 + 1
	
	opponent_move = adjust_for_player_difficulty(opponent_move, instantaneous_score)
	set_opponent_move(opponent_move)
	get_parent()._main_handler()

func set_opponent_move(opponent_move):
	if opponent_move == 1:
		get_parent().get_node("opponent").set_texture(get_parent().hand_1)
	elif opponent_move == 2:
		get_parent().get_node("opponent").set_texture(get_parent().hand_2)
	elif opponent_move == 3:
		get_parent().get_node("opponent").set_texture(get_parent().hand_3)
	elif opponent_move == 4:
		get_parent().get_node("opponent").set_texture(get_parent().hand_4)
	elif opponent_move == 5:
		get_parent().get_node("opponent").set_texture(get_parent().hand_5)
	elif opponent_move == 6:
		get_parent().get_node("opponent").set_texture(get_parent().hand_6)
	elif opponent_move == 7:
		get_parent().get_node("opponent").set_texture(get_parent().hand_7)
	elif opponent_move == 8:
		get_parent().get_node("opponent").set_texture(get_parent().hand_8)
	elif opponent_move == 9:
		get_parent().get_node("opponent").set_texture(get_parent().hand_9)
	elif opponent_move == 10:
		get_parent().get_node("opponent").set_texture(get_parent().hand_10)

func _hand_motion():
	var tween1 = get_parent().get_node("player/Tween")
	var tween2 = get_parent().get_node("opponent/Tween")
	
	get_parent().get_node("player").set_texture(get_parent().hand_10)
	get_parent().get_node("opponent").set_texture(get_parent().hand_10)
	
	$Button1.mouse_filter = self.MOUSE_FILTER_IGNORE
	$Button2.mouse_filter = self.MOUSE_FILTER_IGNORE
	$Button3.mouse_filter = self.MOUSE_FILTER_IGNORE
	$Button4.mouse_filter = self.MOUSE_FILTER_IGNORE
	$Button5.mouse_filter = self.MOUSE_FILTER_IGNORE
	$Button6.mouse_filter = self.MOUSE_FILTER_IGNORE
	
	tween1.interpolate_property(get_parent().get_node("player"), "rotation_degrees", 0, -60, 0.3, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween1.start()
	tween2.interpolate_property(get_parent().get_node("opponent"), "rotation_degrees", 0, 60, 0.3, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween2.start()
	yield(tween1, "tween_completed")
	
	tween1.interpolate_property(get_parent().get_node("player"), "rotation_degrees", -60, 0, 0.05, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween1.start()
	tween2.interpolate_property(get_parent().get_node("opponent"), "rotation_degrees", 60, 0, 0.05, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween2.start()
	yield(tween1, "tween_completed")
	
	$Button1.mouse_filter = self.MOUSE_FILTER_PASS
	$Button2.mouse_filter = self.MOUSE_FILTER_PASS
	$Button3.mouse_filter = self.MOUSE_FILTER_PASS
	$Button4.mouse_filter = self.MOUSE_FILTER_PASS
	$Button5.mouse_filter = self.MOUSE_FILTER_PASS
	$Button6.mouse_filter = self.MOUSE_FILTER_PASS
	
func _on_Button1_pressed():
	instantaneous_score = 1
	get_parent().ball_count += 1
	_hand_motion()
	if get_parent().get_node("player").get_texture() == get_parent().hand_10:
		yield(get_tree().create_timer(0.34), "timeout")
		get_parent().get_node("player").set_texture(get_parent().hand_1)
		get_opponent_action()

func _on_Button2_pressed():
	instantaneous_score = 2
	get_parent().ball_count += 1
	_hand_motion()
	if get_parent().get_node("player").get_texture() == get_parent().hand_10:
		yield(get_tree().create_timer(0.34), "timeout")
		get_parent().get_node("player").set_texture(get_parent().hand_2)
		get_opponent_action()

func _on_Button3_pressed():
	instantaneous_score = 3
	get_parent().ball_count += 1
	_hand_motion()
	if get_parent().get_node("player").get_texture() == get_parent().hand_10:
		yield(get_tree().create_timer(0.34), "timeout")
		get_parent().get_node("player").set_texture(get_parent().hand_3)
		get_opponent_action()

func _on_Button4_pressed():
	instantaneous_score = 4
	get_parent().ball_count += 1
	_hand_motion()
	if get_parent().get_node("player").get_texture() == get_parent().hand_10:
		yield(get_tree().create_timer(0.34), "timeout")
		get_parent().get_node("player").set_texture(get_parent().hand_4)
		get_opponent_action()

func _on_Button5_pressed():
	instantaneous_score = 5
	get_parent().ball_count += 1
	_hand_motion()
	if get_parent().get_node("player").get_texture() == get_parent().hand_10:
		yield(get_tree().create_timer(0.34), "timeout")
		get_parent().get_node("player").set_texture(get_parent().hand_5)
		get_opponent_action()

func _on_Button6_pressed():
	instantaneous_score = 6
	get_parent().ball_count += 1
	_hand_motion()
	if get_parent().get_node("player").get_texture() == get_parent().hand_10:
		yield(get_tree().create_timer(0.34), "timeout")
		get_parent().get_node("player").set_texture(get_parent().hand_6)
		get_opponent_action()

func _on_Button7_pressed():
	instantaneous_score = 7
	get_parent().ball_count += 1
	_hand_motion()
	if get_parent().get_node("player").get_texture() == get_parent().hand_10:
		yield(get_tree().create_timer(0.34), "timeout")
		get_parent().get_node("player").set_texture(get_parent().hand_7)
		get_opponent_action()

func _on_Button8_pressed():
	instantaneous_score = 8
	get_parent().ball_count += 1
	_hand_motion()
	if get_parent().get_node("player").get_texture() == get_parent().hand_10:
		yield(get_tree().create_timer(0.34), "timeout")
		get_parent().get_node("player").set_texture(get_parent().hand_8)
		get_opponent_action()

func _on_Button9_pressed():
	instantaneous_score = 9
	get_parent().ball_count += 1
	_hand_motion()
	if get_parent().get_node("player").get_texture() == get_parent().hand_10:
		yield(get_tree().create_timer(0.34), "timeout")
		get_parent().get_node("player").set_texture(get_parent().hand_9)
		get_opponent_action()

func _on_Button10_pressed():
	instantaneous_score = 10
	get_parent().ball_count += 1
	_hand_motion()
	if get_parent().get_node("player").get_texture() == get_parent().hand_10:
		yield(get_tree().create_timer(0.34), "timeout")
		get_parent().get_node("player").set_texture(get_parent().hand_10)
		get_opponent_action()
