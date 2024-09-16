@tool
class_name Measure
extends VisibleOnScreenEnabler2D

@export var MEASURE_NUMERATOR: int = 4
@export var MEASURE_DENOMINATOR: int = 4
@export var half_line_height: float
@export var length: float


@onready var measure_start: Line2D = %MeasureStart
@onready var measure_end: Line2D = %MeasureEnd
@onready var notes: Node2D = %Notes

var notes_arr: Array[Note.NoteRes] = []
var current_duration := 0.0
var measure_duration: float
var note_scene := preload("res://game/note.tscn")

func _ready() -> void:
	measure_duration = 1.0 / MEASURE_DENOMINATOR * MEASURE_NUMERATOR
	#print("measure duration: ", measure_duration)
	length = -measure_start.position.x + measure_end.position.x
	
	var new_note = Note.NoteRes.new(Note.NoteType.SNARE, Note.NoteDuration.QUARTER)
	add_note(new_note, 0)
	add_note(new_note, 0)
	add_note(new_note, 0)
	add_note(Note.NoteRes.new(Note.NoteType.KICK, Note.NoteDuration.SIXTEENTH), 0)
	add_note(Note.NoteRes.new(Note.NoteType.KICK, Note.NoteDuration.SIXTEENTH), 0)
	add_note(Note.NoteRes.new(Note.NoteType.KICK, Note.NoteDuration.SIXTEENTH), 0)
	add_note(Note.NoteRes.new(Note.NoteType.KICK, Note.NoteDuration.SIXTEENTH), 0)
	


func add_note(note: Note.NoteRes, beat: int) -> void:
	if !check_note(note):
		printerr("can not add note")
		return
	
	notes_arr.append(note)
	
	var note_node := note_scene.instantiate()
	
	note_node.type = note.type
	note_node.duration = note.duration
	
	note_node.position.y = $Lines/E4.position.y - half_line_height * note_node.type
	var occupied_space = current_duration / measure_duration * length
	note_node.position.x = occupied_space + length * note.get_time_dur() / 2.0
	notes.add_child(note_node)
	
	current_duration += note.get_time_dur()

func check_note(note: Note.NoteRes) -> bool:
	if current_duration + note.get_time_dur() > measure_duration:
		return false
	return true
