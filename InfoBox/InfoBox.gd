extends Control

onready var infoBox = $Label
onready var animation = get_tree().root.get_node("Root/AnimationPlayer")

func _ready() -> void:
	InfoBoxController.connect("showInfo", self, "_on_infoBox_show")
	InfoBoxController.connect("hideInfo", self, "_on_infoBox_hide")
	set_position(Vector2(-400, 400))

func _on_infoBox_hide():
	if InfoBoxController.isInfoBoxShowing:
		animation.play("HideInfoBox")
		InfoBoxController.isInfoBoxShowing = false
	
func _on_infoBox_show(desc: String):
	print("shown")
	infoBox.text = desc
	animation.play("ShowInfoBox")