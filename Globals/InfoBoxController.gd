extends Node

signal showInfo()
signal hideInfo()

var isInfoBoxShowing := false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed && event.button_index == BUTTON_LEFT:
			hideInfoBox()

	if event is InputEventScreenTouch:
		if event.pressed && event.button_index == BUTTON_LEFT:
			hideInfoBox()
	

func showInfoBox(desc: String):
	isInfoBoxShowing = true
	emit_signal("showInfo", desc)

func hideInfoBox():
	emit_signal("hideInfo")