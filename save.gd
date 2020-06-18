extends Node2D

var savegame = File.new() #file
var save_path_settings = "user://save_settings.save" #place of the file

var save_data_settings = {	 "music": true,
							 "sound": true,
							 "animation": true
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


func check_n_create_save():
	if not savegame.file_exists(save_path_settings):
		savegame.open(save_path_settings, File.WRITE)
		savegame.store_var(save_data_settings)
		savegame.close()
	if not savegame.file_exists(save_path_game):
		savegame.open(save_path_game, File.WRITE)
		savegame.store_var(save_data_game)
		savegame.close()

func read_save(which_save, save_string):
	var save_path
	var save_data
	if which_save == 0:
		save_path = save_path_settings
		save_data = save_data_settings
	else:
		save_path = save_path_game
		save_data = save_data_game
		
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
	else:
		save_path = save_path_game
		save_data = save_data_game
		
	savegame.open(save_path, File.READ) #open the file
	save_data = savegame.get_var() #get the value
	savegame.close() # close the file
	save_data[save_string] = save_val #data to save
	savegame.open(save_path, File.WRITE) #open file to write
	savegame.store_var(save_data) #store the data
	savegame.close() # close the file

