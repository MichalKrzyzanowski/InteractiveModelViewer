extends Spatial

onready var screw = $RootNode/FW190/Propeller
onready var temp = $RootNode/FW190/Screw
onready var temp2 = $RootNode/FW190/pCylinder2
onready var audioPlayer = $AudioStreamPlayer3D

var acceleration := 0.0
var spinPower := 40.0
var slowDown := 0.01

var animRunning := false

func _ready() -> void:
	temp.hide()
	temp2.hide()

func _physics_process(delta: float) -> void:
	screw.rotate_z(acceleration * delta)
	# acceleration = lerp(acceleration, 0.0, slowDown)
	print(acceleration)

func _on_Area_input_event(camera:Node, event:InputEvent, position:Vector3, normal:Vector3, shape_idx:int) -> void:
	if animRunning:
		return

	if event is InputEventMouseButton:
		if event.pressed && event.button_index == BUTTON_LEFT:
			runAnimation()
	
	if event is InputEventScreenTouch:
		if event.pressed && event.button_index == BUTTON_LEFT:
			runAnimation()

func runAnimation():
	animRunning = true
	audioPlayer.unit_db = 0.0
	var tw = create_tween()
	tw.tween_property(self, "acceleration", spinPower, 2).set_trans(Tween.TRANS_QUAD)
	tw.parallel().tween_callback(audioPlayer, "play")
	tw.tween_property(self, "acceleration", 0.0, 2).set_ease(Tween.EASE_IN)
	tw.parallel().tween_property(audioPlayer, "unit_db", -80.0, 2).set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN)
	tw.tween_callback(self, "animFinished")

func animFinished():
	animRunning = false
