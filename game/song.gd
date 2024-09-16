class_name Song
extends AudioStreamPlayer2D

@export var bpm: int
@onready var metronome: Timer = %Metronome

var spb: float
var _hspb: float
var _time_begin: int
var _time_delay: float
var _last_hb := 0

func _ready() -> void:
	spb = 60.0 / bpm
	_hspb = spb * 0.5
	metronome.wait_time = spb
	_time_begin = Time.get_ticks_usec()
	_time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	play()
	#Events.emit_signal("song_started")
	

var started := false

func _process(delta: float) -> void:
	var time := (Time.get_ticks_usec() - _time_begin) / 1000000.0
	# Compensate for latency.
	time -= _time_delay
	# May be below 0 (did not begin yet).
	time = max(0, time)
	
	
	if !started && time > 0.0:
		started = true
		Events.emit_signal("song_started")
	
	var hb := int(time / _hspb)
	
	var latency_in_beats = AudioServer.get_output_latency() / spb
	if int(time / _hspb + latency_in_beats) > _last_hb && _last_hb % 2 == 1:
		%AudioStreamPlayer2D.play()
		Events.emit_signal("hbeat_will_increment")
	#if hb < _last_hb:
		#print("wtf")
	if hb > _last_hb:
		_last_hb = hb
		
		print("beat")
		Events.emit_signal("hbeat_incremented", hb)
		
	#print("Time is: ", spb)


func _on_metronome_timeout() -> void:
	%AudioStreamPlayer2D.play()
