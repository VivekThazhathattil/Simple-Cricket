extends Node2D

var savegame = File.new() #file
var save_path_settings = "user://save_settings.save" #place of the file
var trophy_unlock_arr = [0,0,0]
var achievement_unlock_arr = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var save_data_settings = {	 "music": true,
							 "sound": true,
							 "animation": true,
							 "trophy_unlock_arr" : trophy_unlock_arr,
							 "achievement_unlock_arr" : achievement_unlock_arr
							} #variable to store data

var save_path_game = "user://save_game.save"

var save_data_game = {	 	 "games_played": 0,
							 "games_won": 0,
							 "games_lost": 0,
							 "games_drawn": 0,
							 "total_tourns": 0,
							 "won_tourns": 0,
							 "lost_tourns": 0,
							 "percent_win_rate": 0,
							 "nrr": 0,
							 "nsr": 0,
							 "net_economy": 0
							} #variable to store data
							
var save_path_tournament = "user://save_tournament.save"
var team_list = ["Afghanistan", "Australia", "Bangladesh", "England", "India", "New Zealand", "Pakistan", "South Africa", "Sri Lanka", "West Indies"]
# Indices			0				1			2			3			4			5			6				7				8			9	
var team_list_short = ["AFG", "AUS", "BAN", "ENG", "IND", "NZ", "PAK", "SA", "SL", "WI"]
var team_wins = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
var team_losses = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
var team_draws = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
var team_probs = [1,9,5,8,9,7,7,5,5,3]
var match_idx = -1
var my_team = "none"
var curr_opponent = "none"
var saved_tourn = false
var tournament_mode = false
var tourn_type = "tourn" # alts = "league","tourn"
var overs = 5 # alts = 10 for T10 tourn, 5 for T5 tourn, 5 for super_league
var save_data_tournament = {
							"team_list" : team_list,
							"team_wins" : team_wins,
							"team_losses" : team_losses,
							"team_draws" : team_draws,
							"my_team" : my_team,
							"curr_opponent" : curr_opponent,
							"saved_tourn" : saved_tourn,
							"tournament_mode" : tournament_mode,
							"match_idx" : match_idx,
							"tourn_type" : tourn_type,
							"overs" : overs
}
var team_icon_arr = [preload("res://sprites/afgan_flag.png"),
					preload("res://sprites/australia_flag.png"),
					preload("res://sprites/bangla_flag.png"),
					preload("res://sprites/england_flag.png"),
					preload("res://sprites/india_flag.png"),
					preload("res://sprites/newzealand_flag.png"),
					preload("res://sprites/pakistan_flag.png"),
					preload("res://sprites/sa_flag.png"),
					preload("res://sprites/srilanka_flag.png"),
					preload("res://sprites/windies_flag.png")]

# Tours
var num_matches = 1
var num_overs = 1
var ply_idx = 0
var opp_idx = 1
var ply_score = 0
var opp_score = 0
var matches_played = 0
var save_path_tours = "user://save_tours.save"
var saved_tours = false
var tours_mode = false
var save_data_tours = {
	"num_matches" : num_matches,
	"num_overs" : num_overs,
	"ply_idx" : ply_idx,
	"opp_idx" : opp_idx,
	"ply_score" : ply_score,
	"opp_score" : opp_score,
	"matches_played" : matches_played,
	"tours_mode" : tours_mode,
	"saved_tours" : saved_tours
}

func check_n_create_save():
	if not savegame.file_exists(save_path_settings):
		savegame.open(save_path_settings, File.WRITE)
		savegame.store_var(save_data_settings)
		savegame.close()
	if not savegame.file_exists(save_path_game):
		savegame.open(save_path_game, File.WRITE)
		savegame.store_var(save_data_game)
		savegame.close()
	if not savegame.file_exists(save_path_tournament):
		savegame.open(save_path_tournament, File.WRITE)
		savegame.store_var(save_data_tournament)
		savegame.close()
	if not savegame.file_exists(save_path_tours):
		savegame.open(save_path_tours, File.WRITE)
		savegame.store_var(save_data_tours)
		savegame.close()

func read_save(which_save, save_string):
	var save_path
	var save_data
	if which_save == 0:
		save_path = save_path_settings
		save_data = save_data_settings
	elif which_save == 1:
		save_path = save_path_game
		save_data = save_data_game
	elif which_save == 2:
		save_path = save_path_tournament
		save_data = save_data_tournament
	elif which_save == 3:
		save_path = save_path_tours
		save_data = save_data_tours
		
	savegame.open(save_path, File.READ) #open the file
	save_data = savegame.get_var() #get the value
	savegame.close() #close the file
	return save_data[save_string] #return the value

func save(which_save, save_string, save_val):
	var save_path
	var save_data
	if which_save == 0:
		save_path = save_path_settings
		save_data = save_data_settings
	elif which_save == 1:
		save_path = save_path_game
		save_data = save_data_game
	elif which_save == 2:
		save_path = save_path_tournament
		save_data = save_data_tournament
	elif which_save == 3:
		save_path = save_path_tours
		save_data = save_data_tours
		
	savegame.open(save_path, File.READ) #open the file
	save_data = savegame.get_var() #get the value
	savegame.close() # close the file
	save_data[save_string] = save_val #data to save
	savegame.open(save_path, File.WRITE) #open file to write
	savegame.store_var(save_data) #store the data
	savegame.close() # close the file

