extends CanvasLayer


@onready var player: CharacterBody2D = $"../Level_Manager/Player"


var paused: bool = false


func _ready() -> void:
	self.visible = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		#self.position = player.position
		if !paused:
			get_tree().paused = true
			paused = true
			self.visible = true
		elif paused and get_child_count() == 1:
			get_tree().paused = false
			paused = false
			self.visible = false
		get_viewport().set_input_as_handled()


func _on_resume_pressed() -> void:
	get_tree().paused = false
	paused = false
	self.visible = false


func _on_settings_pressed() -> void:
	var sett_menu = Resources.settings_menu.instantiate()
	add_child(sett_menu)


func _on_return_to_menu_pressed() -> void:
	get_tree().paused = false
	SceneChangerAnim.change_scene(Resources.main_menu)
