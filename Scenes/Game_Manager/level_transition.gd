extends CanvasLayer


@onready var anim_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	$ColorRect.visible = false


func change_level():
	if anim_player.is_playing():
		anim_player.stop()
	anim_player.play("change_level")
