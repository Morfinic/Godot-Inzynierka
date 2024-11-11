extends Node

@export_category("Menus")
@export var main_menu: PackedScene
@export var settings_menu: PackedScene
@export var death_screen: PackedScene


@export_category("Levels")
@export var level_manager: PackedScene
@export var walker_level: PackedScene


@export_category("Audio")
@export var coin_pickup: AudioStreamMP3
@export var background_noise: AudioStreamMP3
@export var bone_break: AudioStreamMP3
@export var bone_crack: AudioStreamMP3
@export var pain_noises: Array[AudioStreamMP3]
