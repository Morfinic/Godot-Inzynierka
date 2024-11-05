extends Sprite2D

signal level_finished


@onready var interact_text := $Exit_Area/Interact_Text


var can_exit: bool = false


func _ready() -> void:
	interact_text.hide()


func _on_exit_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		interact_text.show()
		can_exit = true


func _on_exit_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		interact_text.hide()
		can_exit = false


func _unhandled_input(event: InputEvent) -> void:
	if can_exit and event.is_action_pressed("interact"):
		level_finished.emit()
