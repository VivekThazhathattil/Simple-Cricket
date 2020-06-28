extends Node2D
var count = 0 # 0 - player , 1 - opponent

func _ready():
	pass

func _display_team_checker(img_path):
	if count == 0:
		$select_options/display_selected_teams/player_team/team_logo.set_texture(load(img_path))
	else:
		$select_options/display_selected_teams/opponent_team/team_logo.set_texture(load(img_path))
	if count == 0:
		count += 1
	else:
		count = 0
	

func _on_afg_pressed():
	_display_team_checker("res://sprites/afgan_flag.png")
	pass # Replace with function body.


func _on_aus_pressed():
	_display_team_checker("res://sprites/australia_flag.png")
	pass # Replace with function body.


func _on_ban_pressed():
	_display_team_checker("res://sprites/bangla_flag.png")
	pass # Replace with function body.


func _on_eng_pressed():
	_display_team_checker("res://sprites/england_flag.png")
	pass # Replace with function body.


func _on_ind_pressed():
	_display_team_checker("res://sprites/india_flag.png")
	pass # Replace with function body.


func _on_nz_pressed():
	_display_team_checker("res://sprites/newzealand_flag.png")
	pass # Replace with function body.


func _on_pak_pressed():
	_display_team_checker("res://sprites/pakistan_flag.png")
	pass # Replace with function body.


func _on_sa_pressed():
	_display_team_checker("res://sprites/sa_flag.png")
	pass # Replace with function body.


func _on_sl_pressed():
	_display_team_checker("res://sprites/srilanka_flag.png")
	pass # Replace with function body.


func _on_wi_pressed():
	_display_team_checker("res://sprites/windies_flag.png")
	pass # Replace with function body.


func _on_next_button_pressed():
	pass # Replace with function body.


func _on_back_button_pressed():
	if get_tree().change_scene("res://scenes/menu.tscn") != OK:
		print("change scene error")
	pass # Replace with function body.
