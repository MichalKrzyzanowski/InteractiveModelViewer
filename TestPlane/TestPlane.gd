extends Spatial

onready var screw = $RootNode/FW190/Propeller
onready var temp = $RootNode/FW190/Screw
onready var temp2 = $RootNode/FW190/pCylinder2

var acceleration := 0.0
var spinPower := 20.0
var slowDown := 0.01

func _ready() -> void:
	temp.hide()
	temp2.hide()

func _physics_process(delta: float) -> void:
	screw.rotate_z(acceleration * delta)
	acceleration = lerp(acceleration, 0.0, slowDown)

func _on_Area_input_event(camera:Node, event:InputEvent, position:Vector3, normal:Vector3, shape_idx:int) -> void:
	if event is InputEventMouseButton:
		if event.pressed && event.button_index == BUTTON_LEFT:
			acceleration = spinPower
	
	if event is InputEventScreenTouch:
		if event.pressed && event.button_index == BUTTON_LEFT:
			acceleration = spinPower
