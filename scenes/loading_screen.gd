extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_TextureButton_pressed():
	$Sprite.visible = true
	yield(get_tree().create_timer(0.5),"timeout")
	if get_tree().change_scene("res://scenes/menu.tscn") != OK:
		print("change scene error")
