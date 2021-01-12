extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var sound = $RigidBody/sound
onready var dmgarea = $RigidBody/dmgbox
onready var explosiontimer = $explosiontime

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	
	sound.play()
	dmgarea.monitorable = true
	explosiontimer.start()

func _on_explosiontime_timeout():
	remove_and_skip()
