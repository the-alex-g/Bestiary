extends HBoxContainer

var info : Dictionary setget , _get_info

onready var _armor_value : LineEdit = $ArmorValue
onready var _description : LineEdit = $Description


func _get_info()->Dictionary:
	return {"value":_armor_value.text, "description":_description.text}


func create(armor_info:Dictionary)->void:
	_armor_value.text = armor_info.value
	_description.text = armor_info.description


func _on_Page_refresh()->void:
	_armor_value.text = ""
	_description.text = ""
