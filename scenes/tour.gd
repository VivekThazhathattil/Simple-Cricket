extends Node2D
var count = 0 # 0 - player , 1 - opponent
var num_matches = 1
var num_overs = 1
var ply_idx = 0
var opp_idx = 1
var ply_score = 0
var opp_score = 0
var matches_played = 0
var saved_tours = false
var tours_mode = false

func _ready():
	var save_inst = preload("res://scenes/save.tscn")
	add_child(save_inst.instance())
	if $save.read_save(3,"saved_tours"):
		_load_save()
		$transition_anim.play("sec")
	else:
		_save_tour()
	_second_screen_handler()
	tours_mode = true
	pass

func _save_tour():
	$save.save(3,"ply_idx",ply_idx)
	$save.save(3,"opp_idx",opp_idx)
	$save.save(3,"num_matches",num_matches)
	$save.save(3,"num_overs",num_overs)
	$save.save(3,"ply_score",ply_score)
	$save.save(3,"opp_score",opp_score)
	$save.save(3,"matches_played",matches_played)
	$save.save(3,"saved_tours", saved_tours)
	$save.save(3,"tours_mode", tours_mode)

func _load_save():
	ply_idx = $save.read_save(3,"ply_idx")
	opp_idx = $save.read_save(3,"opp_idx")
	num_matches = $save.read_save(3,"num_matches")
	num_overs = $save.read_save(3,"num_overs")
	ply_score = $save.read_save(3,"ply_score")
	opp_score = $save.read_save(3,"opp_score")
	matches_played = $save.read_save(3,"matches_played")
	tours_mode = $save.read_save(3,"tours_mode")
	
#	print("ply_idx = " + str(ply_idx))
#	print("opp_idx = " + str(opp_idx))
	print("ply_score_load = " + str(ply_score))
	print("opp_score_load = " + str(opp_score))
	
func _display_team_checker(idx):
	if count == 0:
		$select_options/display_selected_teams/player_team/team_logo.set_texture($save.team_icon_arr[idx])
		ply_idx = idx
	else:
		$select_options/display_selected_teams/opponent_team/team_logo.set_texture($save.team_icon_arr[idx])
		opp_idx = idx
	if count == 0:
		count += 1
	else:
		count = 0
	

func _on_afg_pressed():
	_display_team_checker(0)
	pass # Replace with function body.


func _on_aus_pressed():
	_display_team_checker(1)
	pass # Replace with function body.


func _on_ban_pressed():
	_display_team_checker(2)
	pass # Replace with function body.


func _on_eng_pressed():
	_display_team_checker(3)
	pass # Replace with function body.


func _on_ind_pressed():
	_display_team_checker(4)
	pass # Replace with function body.


func _on_nz_pressed():
	_display_team_checker(5)
	pass # Replace with function body.


func _on_pak_pressed():
	_display_team_checker(6)
	pass # Replace with function body.


func _on_sa_pressed():
	_display_team_checker(7)
	pass # Replace with function body.


func _on_sl_pressed():
	_display_team_checker(8)
	pass # Replace with function body.


func _on_wi_pressed():
	_display_team_checker(9)
	pass # Replace with function body.


func _on_next_button_pressed():
	if (typeof(num_matches) == TYPE_INT or typeof(num_matches) == TYPE_REAL) and (typeof(num_overs) == TYPE_INT or typeof(num_overs) == TYPE_REAL):
		$transition_anim.play("sec")
		_second_screen_handler()
		_save_tour()
#		print("local num_overs = " + str(num_overs))
#		print("num_overs_saved  = " + str($save.read_save(3,"num_overs")))
	else:
		pass
		
func _on_all_matches_completion():
	var val = _get_winner_idx()
	if val == -1:
		$thir_screen/winner/Label.set_text("Tour ended in a draw...")
		$thir_screen/winner/TextureRect.visible = false
	else:
		$thir_screen/winner/Label.set_text("Winner of the tour is ...")
		$thir_screen/winner/TextureRect.set_texture($save.team_icon_arr[val])
	$transition_anim.play("thir")
		
func _get_winner_idx():
	if ply_score > opp_score:
		return ply_idx
	elif ply_score < opp_score:
		return opp_idx
	else:
		return -1

func _update_scores():
	$sec_screen/main_container/match_container/ply_container/ply_score.set_text(str(ply_score))
	$sec_screen/main_container/match_container/opp_container/opp_score.set_text(str(opp_score))
	if num_matches <= matches_played:
		$sec_screen/main_container/next_match.set_text("Declare final results")

func _second_screen_handler():
	$sec_screen/main_container/match_container/ply_container/ply_texture.set_texture($save.team_icon_arr[ply_idx])
	$sec_screen/main_container/match_container/opp_container/opp_texture.set_texture($save.team_icon_arr[opp_idx])
	_update_scores()
	
func _on_back_button_pressed():
	if get_tree().change_scene("res://scenes/menu.tscn") != OK:
		print("change scene error")


func _on_SpinBox2_value_changed(value): # matches
	if typeof(value) == TYPE_INT or typeof(value) == TYPE_REAL:
		num_matches = value

func _on_SpinBox_value_changed(value): #overs 
	if typeof(value) == TYPE_INT or typeof(value) == TYPE_REAL:
		num_overs = value


func _on_next_match_pressed():
	$save.save(3,"tours_mode",true)
	if num_matches == matches_played:
		_on_all_matches_completion()
	else:
		var game_inst = preload("res://scenes/base_game.tscn")
		add_child(game_inst.instance())
		$transition_anim.play("init")
		matches_played += 1

func _on_save_tour_pressed():
	saved_tours = true
	_save_tour()
	$sec_screen/Panel.popup()
	yield(get_tree().create_timer(0.5),"timeout")
	$sec_screen/Panel.hide()


func _on_quit_tour_pressed():
	saved_tours = false
	tours_mode = false
	$save.save(3,"saved_tours",saved_tours)
	$save.save(3,"tours_mode",tours_mode)
	if get_tree().change_scene("res://scenes/menu.tscn") != OK:
		print("change scene error")

func _on_go_back_pressed():
	tours_mode = false
	$save.save(3,"tours_mode",tours_mode)
	if get_tree().change_scene("res://scenes/menu.tscn") != OK:
		print("change scene error")
