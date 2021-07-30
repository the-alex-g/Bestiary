extends TextureButton

var button_disabled := false setget set_disabled


func set_disabled(is_button_disabled:bool)->void:
	if is_button_disabled:
		disabled = true
		
