extends HBoxContainer

var creature_name : String setget , _get_name
var creature_type : String setget , _get_type

onready var _type_box : LineEdit = $Type
onready var _name_box : LineEdit = $Name


func _get_type()->String:
	return _type_box.text


func _get_name()->String:
	return _name_box.text


func _on_Page_refresh()->void:
	_type_box.text = ""
	_name_box.text = ""


func create(c_name:String, type:String)->void:
	_name_box.text = c_name
	_type_box.text = type
