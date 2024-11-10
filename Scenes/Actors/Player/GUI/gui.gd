extends CanvasLayer


@onready var health_bar: ProgressBar = %Health_Bar
@onready var gold_label: Label = %Gold


func _ready() -> void:
	%Stats.connect("took_damage", _update_healthbar)
	%Stats.connect("increased_max_health", _max_hp_inc)
	RunStats.connect("gold_changed", _gold_changed)


func _update_healthbar(health):
	health_bar.value = health


func _max_hp_inc(health):
	health_bar.max_value = health


func _gold_changed(gold):
	gold_label.text = str(gold)
