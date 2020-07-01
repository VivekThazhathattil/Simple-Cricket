extends Node2D

func _set_final_teams(team_no,team_idx):
	if team_no == 1:
		$vbc/hbc3/team1.set_texture($"../save".team_icon_arr[team_idx])
	elif team_no == 2:
		$vbc/hbc3/team2.set_texture($"../save".team_icon_arr[team_idx])
