extends Label3D

export var annotationText := "Sample Text"
export var objectDescription := ""

func _ready() -> void:
	text = annotationText
	print("Text set")


func _on_Area_input_event(camera:Node, event:InputEvent, position:Vector3, normal:Vector3, shape_idx:int) -> void:
	if event is InputEventMouseButton:
		if event.pressed && event.button_index == BUTTON_LEFT:
			InfoBoxController.showInfoBox(objectDescription)
	
	if event is InputEventScreenTouch:
		if event.pressed:
			InfoBoxController.showInfoBox(objectDescription)
