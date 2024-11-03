extends Control


@export var audio_player: AudioStreamPlayer


@onready var master_bus_idx = AudioServer.get_bus_index("Master")
@onready var music_bus_idx = AudioServer.get_bus_index("Music")
@onready var sfx_bus_idx = AudioServer.get_bus_index("SFX")


@onready var master_slider = %Master_Slider
@onready var music_slider = %Music_Slider
@onready var sfx_slider = %SFX_Slider
@onready var window_mode = %WindowMode_Button


func _ready() -> void:
	master_slider.value = GameSettings.Audio_Master
	music_slider.value = GameSettings.Audio_Music
	sfx_slider.value = GameSettings.Audio_SFX

	window_mode.selected = GameSettings.Window_Mode % 3


func _on_return_button_pressed() -> void:
	GameSettings.save_game_settings()
	queue_free()


func _on_window_mode_button_item_selected(index: int) -> void:
	match index:
		0:
			GameSettings.Window_Mode = 0
		1:
			GameSettings.Window_Mode = 4

	DisplayServer.window_set_mode(GameSettings.Window_Mode)


func _on_master_slider_value_changed(value: float) -> void:
	GameSettings.Audio_Master = value
	set_audio(value, master_bus_idx)


func _on_music_slider_value_changed(value: float) -> void:
	GameSettings.Audio_Music = value
	set_audio(value, music_bus_idx)


func _on_sfx_slider_value_changed(value: float) -> void:
	GameSettings.Audio_SFX = value
	set_audio(value, sfx_bus_idx)


func set_audio(audio_val, bus_idx):
	var bus_db = linear_to_db(audio_val)
	match bus_idx:
		0:
			AudioServer.set_bus_volume_db(bus_idx, bus_db)
			AudioServer.set_bus_mute(bus_idx, bus_db < -40)
		1:
			AudioServer.set_bus_volume_db(bus_idx, bus_db)
			AudioServer.set_bus_mute(bus_idx, bus_db < -40)
		2:
			AudioServer.set_bus_volume_db(bus_idx, bus_db)
			AudioServer.set_bus_mute(bus_idx, bus_db < -40)


func _on_sfx_test_button_pressed() -> void:
	toggle_testButton_disable()
	if !audio_player.playing:
		audio_player.set_stream(load("res://Scenes/Main_Menu/Settings/Audio/arrow_shot.wav"))
		audio_player.bus = "SFX"
		audio_player.play()


func _on_music_test_button_pressed() -> void:
	toggle_testButton_disable()
	if !audio_player.playing:
		audio_player.set_stream(load("res://Scenes/Main_Menu/Settings/Audio/light_match.wav"))
		audio_player.bus = "Music"
		audio_player.play()

func _on_test_audio_player_finished() -> void:
	toggle_testButton_disable()

func toggle_testButton_disable():
	%Music_Test_Button.disabled = !%Music_Test_Button.disabled
	%SFX_Test_Button.disabled = !%SFX_Test_Button.disabled
