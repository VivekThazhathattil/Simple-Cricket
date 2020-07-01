extends Node2D

func _set_winner(team_name,tourn_name, tourn_cup_name, tourn_texture_name):
	$vbc/win_text.set_text("The winner of the " + str(tourn_name) + " is " + str(team_name) + "!!!")
	$vbc/win_text2.set_text(str(tourn_cup_name) + " has been added to your trophycase!")
	$vbc/TextureRect.set_texture(load(tourn_texture_name))

func _set_loser(team_name,curr_progress):
	$vbc/congrats.visible = false
	$vbc/win_text2.visible = false
	$vbc/TextureRect.visible = false
	$vbc/win_text.set_text(str(team_name) + " lost in the " + str(curr_progress))
