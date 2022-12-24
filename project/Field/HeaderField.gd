extends HBoxContainer

var creature_name : String setget , _get_name
var creature_type : String setget , _get_type
var creature_alignment : String setget , _get_alignment

onready var _type_box : LineEdit = $Type
onready var _name_box : LineEdit = $Name
onready var _alignment_box : LineEdit = $Alignment


func _get_type()->String:
	return _type_box.text


func _get_name()->String:
	return _name_box.text


func _get_alignment()->String:
	return _alignment_box.text


func _on_Page_refresh()->void:
	_type_box.text = ""
	_name_box.text = ""
	_alignment_box.text = ""


func create(c_name:String, type:String, c_alignment:String)->void:
	_name_box.text = c_name
	_type_box.text = type
	_alignment_box.text = c_alignment
