class_name Page
extends ScrollContainer

signal refresh

var page_info : Dictionary setget , _get_info

onready var _field_container := $Container/FieldContainer
onready var _header_field := $Container/HeaderField
onready var _size_list : OptionButton = $Container/SizeList
onready var _stat_field := $Container/StatField
onready var _damage_field := $Container/DamageField
onready var _armor_field := $Container/ArmorField
onready var _flavor_text := $Container/FlavorText


func _get_info()->Dictionary:
	var info := {
		"name":_header_field.creature_name,
		"type":_header_field.creature_type,
		"alignment":_header_field.creature_alignment,
		"juice":_flavor_text.text,
		"size":"",
		"armor":_armor_field.info,
		"stats":_stat_field.stat_info,
		"damage":_damage_field.damage_info
	}
	# get size
	if _size_list.selected >= 0:
		var index = _size_list.selected
		info["size"] = _size_list.get_item_text(index)
		# this is for loading and editing later
		info["size_index"] = index
	# get field information
	var fields := {}
	for field in _field_container.get_children():
		if field.has_info:
			fields[field.field_name] = field.field_info
	info["fields"] = fields
	return info


func refresh()->void:
	emit_signal("refresh")
	_flavor_text.text = ""
	_size_list.select(-1)
	for field in _field_container.get_children():
		field.refresh()


func build(info:Dictionary)->void:
	refresh()
	_header_field.create(info.name, info.type, info.alignment)
	if info.has("juice"):
		_flavor_text.text = info.juice
	_size_list.select(info.size_index)
	_damage_field.create(info.damage)
	_armor_field.create(info.armor)
	_stat_field.create(info.stats)
	for field in info.fields.keys():
		if field == "Spell-like Abilities":
			get_node("Container/FieldContainer/SpellLikes").create(info.fields[field])
		else:
			get_node("Container/FieldContainer/" + field).create(info.fields[field])
