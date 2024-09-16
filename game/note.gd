@tool
class_name Note
extends Node2D

enum NoteDuration {
	WHOLE = 1,
	HALF = 2,
	QUARTER = 4,
	EIGHTH = 8,
	SIXTEENTH = 16,
}

enum NoteType {
	HAT_PEDAL = -1,
	KICK = 0,
	VERY_LOW_TOM = 2,
	MID_TOM = 4,
	SNARE = 5,
	RIDE = 8,
	HAT = 9,
	CRASH = 10,
}

class NoteRes extends Resource:
	var type: NoteType
	var duration: NoteDuration
	func _init(_type, _duration) -> void:
		type = _type
		duration = _duration
	
	func get_time_dur() -> float:
		return 1.0 / duration

@export var open: bool = false
@export var duration: NoteDuration = NoteDuration.WHOLE
@export var type: NoteType = NoteType.HAT_PEDAL

@onready var sprite_2d: Sprite2D = %Sprite2D

func _ready() -> void:
	if open:
		sprite_2d.texture = preload("res://assets/circle_cross.png")
	elif type in [NoteType.CRASH, NoteType.HAT, NoteType.HAT_PEDAL]:
		sprite_2d.texture = preload("res://assets/cross_base.png")
	else:
		sprite_2d.texture = preload("res://assets/circle.png")
