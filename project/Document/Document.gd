extends Control

enum Mode {READING, WRITING, EDITING}

const PATH := "res://savefile.dct"
const ALPHABET := {"a":25, "b":24, "c":23, "d":22, "e":21, "f":20, "g":19, "h":18, "i":17, "j":16, "k":15, "l":14, "m":13, "n":12, "o":11, "p":10, "q":9, "r":8, "s":7, "t":6, "u":5, "v":4, "w":3, "x":2, "y":1, "z":0}

var _bestiary_info : Array
var _page_index := 0
var _mode : int setget _set_mode

onready var _page : Page = $Page
onready var _display_page : RichTextLabel = $PageLabel
onready var _index_label : LineEdit = $MenuButtons/HBoxContainer/IndexField
onready var _back_button : Button = $MenuButtons/Back
onready var _save_button : Button = $MenuButtons/Save
onready var _left_button : TextureButton = $MenuButtons/HBoxContainer/Left
onready var _right_button : TextureButton = $MenuButtons/HBoxContainer/Right
onready var _edit_button : Button = $MenuButtons/Edit
onready var _remove_button : Button = $MenuButtons/Remove
onready var _new_page_button : Button = $MenuButtons/NewPage


func _ready()->void:
	_compile_master_dictionary()
	_reload_page()
	if _bestiary_info.size() > 0:
		_set_mode(Mode.READING)
	else:
		_set_mode(Mode.WRITING)


func _compile_master_dictionary()->void:
	_bestiary_info = []
	var save_file := File.new()
	if save_file.file_exists(PATH):
		# warning-ignore:return_value_discarded
		save_file.open(PATH, File.READ)
		
		while save_file.get_position() < save_file.get_len():
			_bestiary_info.append(save_file.get_var())
		
		save_file.close()


# turns an info dictionary into a formatted string for display
func _get_readable_from_info(info:Dictionary)->String:
	var readable := ""
	readable += info.name.capitalize() + "\n" + info.size.capitalize() + " " + info.type.capitalize() + "\n"
	readable += "Armor: " + info.armor.value + (" (" + info.armor.description + ")\n" if info.armor.description.length() > 0 else "\n")
	readable += "Ag: " + info.stats.ag_base + " (" + ("+" if info.stats.ag_bonus[0] != "-" else "") + info.stats.ag_bonus + ")\n"
	readable += "Cn: " + info.stats.cn_base + " (" + ("+" if info.stats.cn_bonus[0] != "-" else "") + info.stats.cn_bonus + ")\n"
	readable += "In: " + info.stats.in_base + " (" + ("+" if info.stats.in_bonus[0] != "-" else "") + info.stats.in_bonus + ")\n"
	readable += "Lr: " + info.stats.lr_base + " (" + ("+" if info.stats.lr_bonus[0] != "-" else "") + info.stats.lr_bonus + ")\n"
	readable += "Mg: " + info.stats.mg_base + " (" + ("+" if info.stats.mg_bonus[0] != "-" else "") + info.stats.mg_bonus + ")\n"
	readable += "Pe: " + info.stats.pe_base + " (" + ("+" if info.stats.pe_bonus[0] != "-" else "") + info.stats.pe_bonus + ")\n"
	readable += "Damage Levels: " + info.damage.light + "/" + info.damage.moderate + "/" + info.damage.severe + "\n\n"
	for field_name in info.fields.keys():
		var field_info : Array = info.fields[field_name]
		readable += field_name + "---------------------------------------\n"
		for section in field_info:
			for value in section.values():
				readable += value
				if section.values().find(value) == 0:
					readable += ":"
				readable += " "
			readable += "\n"
		readable += "\n"
	return readable


func _on_NewPage_pressed()->void:
	_set_mode(Mode.WRITING)
	_open_page_editor()


func _open_page_editor(info := {})->void:
	_page.visible = true
	_display_page.visible = false
	
	# new page
	if info.size() == 0:
		_page.refresh()
	else:
		_page.build(_bestiary_info[_page_index])


func _on_Save_pressed()->void:
	_save(_page.page_info)
	_set_mode(Mode.READING)
	_reload_page()


func _save(info:Dictionary = {})->void:
	# if there is a new entry, add it
	if info.size() > 0:
		if _mode == Mode.WRITING:
			_bestiary_info.append(info)
			_bestiary_info.sort_custom(self, "alphabetical_sort")
		elif _mode == Mode.EDITING:
			_bestiary_info[_page_index] = info
	
	# this saves ALL of the entries in _bestiary_info. Otherwise, it doesn't work.
	var save_file := File.new()
	# warning-ignore:return_value_discarded
	save_file.open(PATH, File.WRITE)
	for entry in _bestiary_info:
		save_file.store_var(entry)
	save_file.close()


func alphabetical_sort(a:Dictionary, b:Dictionary)->bool:
	return ALPHABET[a.name[0].to_lower()] > ALPHABET[b.name[0].to_lower()]


func _on_Previous_pressed()->void:
	_change_page(-1)


func _on_Next_pressed():
	_change_page(1)


func _change_page(direction:int)->void:
	if _bestiary_info.size() > 0:
		_page_index += direction
		_page_index %= _bestiary_info.size()
		_display_page.text = _get_readable_from_info(_bestiary_info[_page_index])
	_index_label.text = str(_page_index + 1)


func _reload_page()->void:
	_change_page(0)


func _on_IndexField_text_entered(new_text:String)->void:
	var new_index := int(new_text)
	if new_index - 1 >= 0 and new_index < _bestiary_info.size():
		_page_index = new_index
	else:
		new_index = _bestiary_info.size() - 1
		_reload_page()


func _on_Edit_pressed()->void:
	_set_mode(Mode.EDITING)
	_page.build(_bestiary_info[_page_index])


func _on_Remove_pressed()->void:
	_bestiary_info.remove(_page_index)
	if _bestiary_info.size() > 0:
		_reload_page()
	else:
		_set_mode(Mode.WRITING)
	_save()


func _on_Left_pressed()->void:
	_change_page(-1)


func _on_Right_pressed()->void:
	_change_page(1)


func _on_Back_pressed()->void:
	_set_mode(Mode.READING)


func _set_mode(value:int)->void:
	_mode = value
	match _mode:
		Mode.READING:
			_display_page.visible = true
			_page.visible = false
			_save_button.disabled = true
			_back_button.disabled = true
			_left_button.disabled = false
			_right_button.disabled = false
			_edit_button.disabled = false
			_remove_button.disabled = false
			_new_page_button.disabled = false
		Mode.WRITING, Mode.EDITING:
			_display_page.visible = false
			_page.visible = true
			_save_button.disabled = false
			
			# if there is a place to go back to, enable back button
			if _bestiary_info.size() > 0:
				_back_button.disabled = false
			else:
				_back_button.disabled = true
			
			_left_button.disabled = true
			_right_button.disabled = true
			_edit_button.disabled = true
			_remove_button.disabled = true
			_new_page_button.disabled = true
