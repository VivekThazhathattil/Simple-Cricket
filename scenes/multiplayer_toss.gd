extends Node2D

func client_coin_toss_action():
	$toss_event_text.set_text("Waiting for the toss...")
	$coinbox.visible = false
	
func server_coin_toss_action():
	$toss_event_text.set_text("Choose heads or tails ...")
	$coinbox.visible = true


func _on_heads_pressed():
	$coinbox.visible = false
	randomize()
	if (randi()%2 == 0):
		# you won the toss
		your_choice()
	else:
		# you lost the toss
		pass


func _on_tails_pressed():
	$coinbox.visible = false
	randomize()
	if (randi()%2 == 1):
		# you won the toss
		your_choice()
	else:
		# you lost the tos
		Network.ask_opponent_choice_rpc()

func your_choice():
	$toss_event_text.set_text("You won the toss, choose batting or bowling...")
