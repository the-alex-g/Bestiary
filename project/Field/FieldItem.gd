class_name FieldItem
extends HBoxContainer

signal removed


func _init(fields:PoolStringArray, field_contents:Dictionary)->void:
	for field in fields:
		var line_edit := LineEdit.new()
		line_edit.expand_to_text_length = true
		line_edit.placeholder_text = field
		if field_contents.size() > 0:
			line_edit.text = field_contents[field]
		add_child(line_edit)
	
	var remove_button := RemoveButton.new(-1)
	# warning-ignore:return_value_discarded
	remove_button.connect("custom_pressed", self, "_on_removed", [], CONNECT_ONESHOT)
	add_child(remove_button)


func _on_removed(_id:int)->void:
	emit_signal("removed")
	queue_free()


func get_text()->Dictionary:
	var text := {}
	for i in get_child_count():
		if i < get_child_count() - 1:
			var field : LineEdit = get_child(i)
			text[field.placeholder_text] = field.text
	return text
