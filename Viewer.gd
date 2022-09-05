extends Spatial

var sensitivity := 0.001
var eventId := -1

onready var plane = $Plane
onready var pivot = $CameraPivot
onready var camera = $CameraPivot/Camera
onready var zoom = $CanvasLayer/VSlider
onready var annotations = $Annotations
onready var pof = $PointsOfInterest

var acceleration := Vector2()
var slowDown := 0.05
var zoomSlowDown := 0.1

onready var lineMat = preload("res://TestPlane/mat.tres")

var lines = []

func _ready() -> void:
	$UI/QuitButton.connect("button_up", self, "_on_QuitButton_button_up")
	zoom.value = camera.fov
	for i in range(annotations.get_child_count()):
		print(i)
		var line = ImmediateGeometry.new()
		line.clear()
		line.material_override = lineMat
		line.begin(Mesh.PRIMITIVE_LINES)
		line.add_vertex(annotations.get_child(i).transform.origin)
		line.add_vertex(pof.get_child(i).transform.origin)
		line.end()
		add_child(line)
		lines.append(line)


func _physics_process(delta: float) -> void:
	transform.basis = Basis()
	pivot.rotate_object_local(Vector3(0, 1, 0), acceleration.x)
	pivot.rotate_object_local(Vector3(1, 0, 0), acceleration.y)
	acceleration.x = lerp(acceleration.x, 0.0, slowDown)
	acceleration.y = lerp(acceleration.y, 0.0, slowDown)
	camera.fov = lerp(camera.fov, zoom.value, zoomSlowDown)
	var a = Quat(transform.basis)
	var b = Quat(transform.basis)

	a.slerp(b, 0.5)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			eventId = 1
		else:
			eventId = -1
	elif event is InputEventMouseMotion:
		if eventId == 1:
			acceleration = -event.relative * sensitivity
	
	if event is InputEventScreenTouch:
		if event.pressed:
			eventId = event.index
		else:
			eventId = -1
	elif event is InputEventScreenDrag:
		if eventId == event.index:
			acceleration = -event.relative * sensitivity


func _on_ResetButton_gui_input(event:InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed && event.button_index == BUTTON_LEFT:
			resetRotation()
			
	if event is InputEventScreenTouch:
		if event.pressed:
			resetRotation()

func _on_QuitButton_button_up() -> void:
	get_tree().quit()

func resetRotation():
	acceleration = Vector2.ZERO

	var tw = get_tree().create_tween()
	tw.tween_property(pivot, "rotation", Vector3.ZERO, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	# pivot.rotation = Vector3.ZERO

