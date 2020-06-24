extends Node2D

var inst = preload("res://scenes/group_stage.tscn")
var save_inst = preload("res://scenes/save.tscn")
func _ready():
	self.add_child(save_inst.instance())
	$save.check_n_create_save()
	get_tree().set_quit_on_go_back(false)
	
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		_on_Back_pressed()
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		_on_Back_pressed()
	
func _on_Back_pressed():
	if $save.read(2,"my_team") != "none":
		$save.save(2,"my_team","none")
	if get_tree().change_scene("res://scenes/menu.tscn") != OK:
		print("change scene error")
func _on_ind_pressed():
	$save.save(2,"my_team","India")
	if get_tree().change_scene("res://scenes/group_stage.tscn") != OK:
		print("change_scene error")


func _on_sa_pressed():
	$save.save(2,"my_team","South Africa")
	if get_tree().change_scene("res://scenes/group_stage.tscn") != OK:
		print("change_scene error")


func _on_aus_pressed():
	$save.save(2,"my_team","Australia")
	if get_tree().change_scene("res://scenes/group_stage.tscn") != OK:
		print("change_scene error")


func _on_nz_pressed():
	$save.save(2,"my_team","New Zealand")
	if get_tree().change_scene("res://scenes/group_stage.tscn") != OK:
		print("change_scene error")


func _on_eng_pressed():
	$save.save(2,"my_team","England")
	if get_tree().change_scene("res://scenes/group_stage.tscn") != OK:
		print("change_scene error")


func _on_pak_pressed():
	$save.save(2,"my_team","Pakistan")
	if get_tree().change_scene("res://scenes/group_stage.tscn") != OK:
		print("change_scene error")


func _on_bng_pressed():
	$save.save(2,"my_team","Bangladesh")
	if get_tree().change_scene("res://scenes/group_stage.tscn") != OK:
		print("change_scene error")


func _on_afg_pressed():
	$save.save(2,"my_team","Afghanistan")
	if get_tree().change_scene("res://scenes/group_stage.tscn") != OK:
		print("change_scene error")


func _on_wi_pressed():
	$save.save(2,"my_team","West Indies")
	if get_tree().change_scene("res://scenes/group_stage.tscn") != OK:
		print("change_scene error")


func _on_sl_pressed():
	$save.save(2,"my_team","Sri Lanka")
	if get_tree().change_scene("res://scenes/group_stage.tscn") != OK:
		print("change_scene error")
