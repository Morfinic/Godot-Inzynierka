extends Node


@export var settings_menu: PackedScene


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_tree().paused = true
		$Pause_Menu.show()
		get_viewport().set_input_as_handled()

func _on_resume_pressed() -> void:
	$Pause_Menu.hide()
	get_tree().paused = false


func _on_settings_pressed() -> void:
	var sett_menu = settings_menu.instantiate()
	add_child(sett_menu)


func _on_return_to_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/Main_Menu/MainMenu.tscn")
