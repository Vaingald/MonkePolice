extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_anchor_and_margin(MARGIN_LEFT, Control.ANCHOR_RATIO, 0.25)
	set_anchor_and_margin(MARGIN_RIGHT, Control.ANCHOR_RATIO, 0.75)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
