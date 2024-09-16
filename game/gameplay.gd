extends Node2D

@onready var song_pattern: Node2D = %SongPattern
@onready var song: Song = %Song
@onready var song_info: TextEdit = %SongInfo


func _ready() -> void:
	Events.connect("song_started", start_moving)
	song_info.text = "BPM - " + str(song.bpm)

var song_started := false
func start_moving() -> void:
	song_started = true

func _physics_process(delta: float) -> void:
	if !song_started:
		return
	
	#measure.length / spb / MEASURE_NOMINATOR
	var speed = 640.0 / song.spb / 4.0
	song_pattern.position.x -= speed * delta

func _process(delta):
	#song_pattern.position.x -= 10
	#if measures_on_screen < 3:
		#var prev_position = last_measure.position
		##print(prev_position.y)
		#last_measure = measure_sc.instantiate()
		#last_measure.position.y = prev_position.y
		#last_measure.position.x = prev_position.x+last_measure.rect.size.x
		#add_child(last_measure)
		#measures_on_screen+=1
	
	
	pass
