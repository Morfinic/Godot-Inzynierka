extends Control
class_name DeathScreen


@onready var floor_number: Label = %Floor_Number
@onready var gold_collected: Label = %Gold_Collected
@onready var enemies_killed: Label = %Enemies_Killed


func _ready() -> void:
	$Background.set_size(Vector2(42, 24))
	floor_number.text = str(RunStats.Floor)
	gold_collected.text = str(RunStats.Gold)
	enemies_killed.text = str(RunStats.EnemiesKilled)

func _on_new_run_pressed() -> void:
	SceneChangerAnim.change_scene(Resources.level_manager)


func _on_return_to_menu_pressed() -> void:
	SceneChangerAnim.change_scene(Resources.main_menu)
