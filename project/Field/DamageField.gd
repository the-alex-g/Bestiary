extends GridContainer

var damage_info : Dictionary setget , _get_info

onready var _light_box : LineEdit = $LightEdit
onready var _mod_box : LineEdit = $ModerateEdit
onready var _severe_box : LineEdit = $SevereEdit


func _get_info()->Dictionary:
	return {
		"light":_light_box.text,
		"moderate":_mod_box.text,
		"severe":_severe_box.text,
	}


func _on_Page_refresh()->void:
	_light_box.text = ""
	_mod_box.text = ""
	_severe_box.text = ""


func create(info:Dictionary)->void:
	_light_box.text = info.light
	_mod_box.text = info.moderate
	_severe_box.text = info.severe
