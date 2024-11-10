extends CanvasLayer


@onready var color_rect: ColorRect = $ColorRect
@onready var anim_player: AnimationPlayer = $AnimationPlayer


var target_scene: PackedScene


func _ready() -> void:
	color_rect.visible = false


func change_scene(scene):
	if anim_player.is_playing():
		anim_player.stop()
	target_scene = scene
	anim_player.play("change_scene")


func _load_scene():
	get_tree().change_scene_to_packed(target_scene)
