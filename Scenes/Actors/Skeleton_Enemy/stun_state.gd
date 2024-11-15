extends State
class_name StunState


@onready var stun_timer: Timer = $"../../Stun_Timer"


func enter():
	$"../../AnimationPlayer".play("stun")
	stun_timer.start(0.3)


func _on_stun_timer_timeout() -> void:
	if $"../../Engage_Area".has_overlapping_bodies():
		change_state.emit(self, "followstate")
	else:
		change_state.emit(self, "idlestate")
