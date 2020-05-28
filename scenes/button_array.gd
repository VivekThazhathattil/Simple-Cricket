extends GridContainer
var opponent_move = 10
var instantaneous_score = 0

func _ready():
	pass # Replace with function body.
	
func get_opponent_action():
	randomize()
	opponent_move = randi() % 10 + 1
	if opponent_move == 1:
		get_node("/root/base_game/opponent").set_texture(get_parent().hand_1)
	elif opponent_move == 2:
		get_node("/root/base_game/opponent").set_texture(get_parent().hand_2)
	elif opponent_move == 3:
		get_node("/root/base_game/opponent").set_texture(get_parent().hand_3)
	elif opponent_move == 4:
		get_node("/root/base_game/opponent").set_texture(get_parent().hand_4)
	elif opponent_move == 5:
		get_node("/root/base_game/opponent").set_texture(get_parent().hand_5)
	elif opponent_move == 6:
		get_node("/root/base_game/opponent").set_texture(get_parent().hand_6)
	elif opponent_move == 7:
		get_node("/root/base_game/opponent").set_texture(get_parent().hand_7)
	elif opponent_move == 8:
		get_node("/root/base_game/opponent").set_texture(get_parent().hand_8)
	elif opponent_move == 9:
		get_node("/root/base_game/opponent").set_texture(get_parent().hand_9)
	elif opponent_move == 10:
		get_node("/root/base_game/opponent").set_texture(get_parent().hand_10)

	if instantaneous_score == opponent_move:
		get_parent()._not_out = false
	get_parent()._main_handler()
	

func _hand_motion():
	var tween1 = get_node("/root/base_game/player/Tween")
	var tween2 = get_node("/root/base_game/opponent/Tween")
	
	get_node("/root/base_game/player").set_texture(get_parent().hand_10)
	get_node("/root/base_game/opponent").set_texture(get_parent().hand_10)
	
	tween1.interpolate_property(get_node("/root/base_game/player"), "rotation_degrees", 0, -60, 0.3, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween1.start()
	tween2.interpolate_property(get_node("/root/base_game/opponent"), "rotation_degrees", 0, 60, 0.3, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween2.start()
	yield(tween1, "tween_completed")
	
	tween1.interpolate_property(get_node("/root/base_game/player"), "rotation_degrees", -60, 0, 0.05, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween1.start()
	tween2.interpolate_property(get_node("/root/base_game/opponent"), "rotation_degrees", 60, 0, 0.05, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween2.start()
	yield(tween1, "tween_completed")
	
func _on_Button1_pressed():
	instantaneous_score = 1
	get_parent().ball_count += 1
	_hand_motion()
	if get_node("/root/base_game/player").get_texture() == get_parent().hand_10:
		yield(get_tree().create_timer(0.34), "timeout")
		get_node("/root/base_game/player").set_texture(get_parent().hand_1)
		get_opponent_action()

func _on_Button2_pressed():
	instantaneous_score = 2
	get_parent().ball_count += 1
	_hand_motion()
	if get_node("/root/base_game/player").get_texture() == get_parent().hand_10:
		yield(get_tree().create_timer(0.34), "timeout")
		get_node("/root/base_game/player").set_texture(get_parent().hand_2)
		get_opponent_action()

func _on_Button3_pressed():
	instantaneous_score = 3
	get_parent().ball_count += 1
	_hand_motion()
	if get_node("/root/base_game/player").get_texture() == get_parent().hand_10:
		yield(get_tree().create_timer(0.34), "timeout")
		get_node("/root/base_game/player").set_texture(get_parent().hand_3)
		get_opponent_action()

func _on_Button4_pressed():
	instantaneous_score = 4
	get_parent().ball_count += 1
	_hand_motion()
	if get_node("/root/base_game/player").get_texture() == get_parent().hand_10:
		yield(get_tree().create_timer(0.34), "timeout")
		get_node("/root/base_game/player").set_texture(get_parent().hand_4)
		get_opponent_action()

func _on_Button5_pressed():
	instantaneous_score = 5
	get_parent().ball_count += 1
	_hand_motion()
	if get_node("/root/base_game/player").get_texture() == get_parent().hand_10:
		yield(get_tree().create_timer(0.34), "timeout")
		get_node("/root/base_game/player").set_texture(get_parent().hand_5)
		get_opponent_action()

func _on_Button6_pressed():
	instantaneous_score = 6
	get_parent().ball_count += 1
	_hand_motion()
	if get_node("/root/base_game/player").get_texture() == get_parent().hand_10:
		yield(get_tree().create_timer(0.34), "timeout")
		get_node("/root/base_game/player").set_texture(get_parent().hand_6)
		get_opponent_action()

func _on_Button7_pressed():
	instantaneous_score = 7
	get_parent().ball_count += 1
	_hand_motion()
	if get_node("/root/base_game/player").get_texture() == get_parent().hand_10:
		yield(get_tree().create_timer(0.34), "timeout")
		get_node("/root/base_game/player").set_texture(get_parent().hand_7)
		get_opponent_action()

func _on_Button8_pressed():
	instantaneous_score = 8
	get_parent().ball_count += 1
	_hand_motion()
	if get_node("/root/base_game/player").get_texture() == get_parent().hand_10:
		yield(get_tree().create_timer(0.34), "timeout")
		get_node("/root/base_game/player").set_texture(get_parent().hand_8)
		get_opponent_action()

func _on_Button9_pressed():
	instantaneous_score = 9
	get_parent().ball_count += 1
	_hand_motion()
	if get_node("/root/base_game/player").get_texture() == get_parent().hand_10:
		yield(get_tree().create_timer(0.34), "timeout")
		get_node("/root/base_game/player").set_texture(get_parent().hand_9)
		get_opponent_action()

func _on_Button10_pressed():
	instantaneous_score = 10
	get_parent().ball_count += 1
	_hand_motion()
	if get_node("/root/base_game/player").get_texture() == get_parent().hand_10:
		yield(get_tree().create_timer(0.34), "timeout")
		get_node("/root/base_game/player").set_texture(get_parent().hand_10)
		get_opponent_action()
