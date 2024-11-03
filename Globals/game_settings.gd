extends Node

var settings_config = ConfigFile.new()

var Audio_Master: float
var Audio_Music: float
var Audio_SFX: float

var Window_Mode: int


func _ready() -> void:
	load_game_settings()
	set_game_settings()


func load_game_settings():
	var err = settings_config.load("res://Config/GameSettings.cfg")

	if err != OK:
		Audio_Master = 1.0
		Audio_Music = 1.0
		Audio_SFX = 1.0
		Window_Mode = 0
	else:
		Audio_Master = settings_config.get_value("Audio", "Master")
		Audio_Music = settings_config.get_value("Audio", "Music")
		Audio_SFX = settings_config.get_value("Audio", "SFX")
		Window_Mode = settings_config.get_value("Window", "Mode")


func save_game_settings():
	settings_config.set_value("Audio", "Master", Audio_Master)
	settings_config.set_value("Audio", "Music", Audio_Music)
	settings_config.set_value("Audio", "SFX", Audio_SFX)

	settings_config.set_value("Window", "Mode", Window_Mode)

	settings_config.save("res://Config/GameSettings.cfg")


func set_game_settings():
	DisplayServer.window_set_mode(Window_Mode)

	var bus_array: Array = [Audio_Master, Audio_Music, Audio_SFX]
	for bus_idx in range(bus_array.size()):
		var bus_db = linear_to_db(bus_array[bus_idx])
		AudioServer.set_bus_volume_db(bus_idx, bus_db)
		AudioServer.set_bus_mute(bus_idx, bus_db < -40)
