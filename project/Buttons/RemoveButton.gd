class_name RemoveButton
extends TextureButton

signal custom_pressed(id)

var _id : int


func _init(id:int)->void:
	_id = id
	texture_normal = load("res://Buttons/Atlases/RemoveNormal.tres")
	texture_pressed = load("res://Buttons/Atlases/RemovePressed.tres")
	texture_hover = load("res://Buttons/Atlases/RemoveHover.tres")
	texture_disabled = load("res://Buttons/Atlases/RemoveDisabled.tres")
	# warning-ignore:return_value_discarded
	connect("pressed", self, "_on_RemoveButton_pressed")
	expand = true
	stretch_mode = TextureButton.STRETCH_KEEP


func _on_RemoveButton_pressed()->void:
	emit_signal("custom_pressed", _id)
