@tool
extends Node2D

@export var measures_count := 4
var measure_scene = preload("res://game/measure.tscn")

#var measures_arr: Array = []
#var note_arr: Array[Note.NoteRes] = []

#class res_test extends Resource:
	#var i: int
#@export var notes: Array[res_test] = []
#@export var obj = {
	#"test": []
#}

func _ready() -> void:
	var prev_pos = 0
	for i in range(measures_count):
		var measure := measure_scene.instantiate()
		measure.position.x = prev_pos
		add_child(measure)
		prev_pos += measure.length
