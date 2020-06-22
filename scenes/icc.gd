extends Node2D

	
func _ready():
	get_tree().set_quit_on_go_back(false)
	
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		_on_Back_pressed()
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		_on_Back_pressed()
	
func _on_Back_pressed():
	get_tree().change_scene("res://scenes/menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
