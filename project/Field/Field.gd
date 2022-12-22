class_name Field
extends VBoxContainer

export var field_name : String
export var sections : PoolStringArray

var _items := 0
var _field_name_length := 50

var has_info : bool setget , _get_has_info
var field_info : Array setget , _get_info

onready var _field_name_label := $FieldHeader/FieldName


func _ready()->void:
	_field_name_label.text = field_name
	for _i in _field_name_length - field_name.length():
		_field_name_label.text += "_"


func _on_AddButton_pressed()->void:
	_add_field()


func _add_field(info := {})->void:
	var field_item := FieldItem.new(sections, info)
	# warning-ignore:return_value_discarded
	field_item.connect("removed", self, "_on_item_removed", [], CONNECT_ONESHOT)
	add_child(field_item)
	_items += 1


func _on_item_removed()->void:
	_items -= 1


func _get_info()->Array:
	var info := []
	for i in get_child_count():
		if i > 0:
			var field_item : FieldItem = get_child(i)
			info.append(field_item.get_text())
	return info


func _get_has_info()->bool:
	return _items > 0


func refresh()->void:
	_items = 0
	for i in get_child_count():
		if i > 0:
			get_child(i).queue_free()


func create(info:Array)->void:
	for item in info:
		_add_field(item)
