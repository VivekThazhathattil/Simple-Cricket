extends Node2D

var my_dec
var dec
var _player_batting

func _ready():
	pass # Replace with function body.
	
func _final_action():
	queue_free()
	
func _pop_up_opp_choice(opp_choice):
	$opp_choice.visible = true
	if opp_choice == 0:
		dec = "bat"
		_player_batting = false
	else:
		dec = "bowl"
		_player_batting = true
	$opp_choice.set_text("You lost the toss! Opponent has chosen to " + str(dec) + " first.")
	$coinbox.visible = false

func _pop_up_select_batting():
	$player_choice/Label.set_text("You won the toss! Do you wish to bat or bowl?")
	$player_choice.visible = true
	$coinbox.visible = false
	

func _on_heads_pressed():
	my_dec = 0
	_final_judger()

func _on_tails_pressed():
	my_dec = 1
	_final_judger()
	
func _final_judger():
	randomize()
	if my_dec == randi()%2:
		_pop_up_select_batting()
	else:
		my_dec = randi()%2
		_pop_up_opp_choice(my_dec)

func _on_opp_choice_confirmed():
	_hide_toss_menu()
	get_parent()._set_toss_decision()
	
func _hide_toss_menu():
	self.visible = false
	$player_choice.visible = false
	$opp_choice.visible = false
	
func _on_Batting_pressed():
	_player_batting = true
	print("coin_toss:56: _player_batting = " + str(_player_batting))
	_hide_toss_menu()
	get_parent()._set_toss_decision()
	
func _on_Bowling_pressed():
	_player_batting = false
	_hide_toss_menu()
	get_parent()._set_toss_decision()
