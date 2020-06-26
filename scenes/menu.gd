extends Node2D
var no_overs = 1
var new_game = preload("res://scenes/base_game.tscn")
var my_stats = preload("res://scenes/my_stats.tscn")
var how_to_play = preload("res://scenes/how_to_play.tscn")

func _ready():
	var save_inst = preload("res://scenes/save.tscn")
	self.add_child(save_inst.instance())
	_create_load_save()
	$save.save(2,"tournament_mode",false)
#	print(self.get_path())

func _create_load_save():
	$save.check_n_create_save()
	if not $save.read_save(0,"music"):
		$bg_music.stop()
		$bottom_panel/panel_container/music_off.set_normal_texture(preload("res://sprites/music_off.png"))
	else:
		$bg_music.play()
		$bottom_panel/panel_container/music_off.set_normal_texture(preload("res://sprites/music_on.png"))
	if not $save.read_save(0,"sound"):
		$bottom_panel/panel_container/sound_off.set_normal_texture(preload("res://sprites/sound_off.png"))
	else:
		$bottom_panel/panel_container/sound_off.set_normal_texture(preload("res://sprites/sound_on.png"))
		
func _on_PLAY_NOW_pressed():
	$Sprite.visible = true
	yield(get_tree().create_timer(0.5),"timeout")
	var ins = load("res://scenes/game_mode.tscn").instance()
	self.add_child(ins)

func _on_MY_PROFILE_pressed():
	var ins = my_stats.instance()
	self.add_child(ins)

func _on_HOW_TO_PLAY_pressed():
	var ins = how_to_play.instance()
	self.add_child(ins)
	
func _on_exit_pressed():
	queue_free()
	get_tree().quit()

func _on_music_off_pressed():
	if not $bg_music.playing:
		$bg_music.play()
		$save.save(0, "music", true)
		$bottom_panel/panel_container/music_off.set_normal_texture(preload("res://sprites/music_on.png"))
	else:
		$bg_music.stop()
		$save.save(0, "music", false)
		$bottom_panel/panel_container/music_off.set_normal_texture(preload("res://sprites/music_off.png"))

func _on_sound_off_pressed():
	if $save.read_save(0,"sound"):
		$save.save(0, "sound", false)
		$bottom_panel/panel_container/sound_off.set_normal_texture(preload("res://sprites/sound_off.png"))
	else:
		$save.save(0, "sound", true)
		$bottom_panel/panel_container/sound_off.set_normal_texture(preload("res://sprites/sound_on.png"))
