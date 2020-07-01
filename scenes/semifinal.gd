extends Node2D

func _set_teams(team_no,team_idx):
	print("_set_teams called")
	if team_no == 1:
		$vbc/hbc/team1.set_texture($"../save".team_icon_arr[team_idx])
	elif team_no == 2:
		$vbc/hbc/team2.set_texture($"../save".team_icon_arr[team_idx])
	elif team_no == 3:
		$vbc/hbc2/team3.set_texture($"../save".team_icon_arr[team_idx])
	else:
		$vbc/hbc2/team4.set_texture($"../save".team_icon_arr[team_idx])
