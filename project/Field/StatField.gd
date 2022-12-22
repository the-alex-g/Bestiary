extends GridContainer

var stat_info : Dictionary setget , _get_info

onready var _ag_base : LineEdit = $AgBase
onready var _ag_bonus : LineEdit = $AgBonus
onready var _cn_base : LineEdit = $CnBase
onready var _cn_bonus : LineEdit = $CnBonus
onready var _in_base : LineEdit = $InBase
onready var _in_bonus : LineEdit = $InBonus
onready var _lr_base : LineEdit = $LrBase
onready var _lr_bonus : LineEdit = $LrBonus
onready var _mg_base : LineEdit = $MgBase
onready var _mg_bonus : LineEdit = $MgBonus
onready var _pe_base : LineEdit = $PeBase
onready var _pe_bonus : LineEdit = $PeBonus


func _get_info()->Dictionary:
	return {
		"ag_base":_ag_base.text,
		"ag_bonus":_ag_bonus.text,
		"cn_base":_cn_base.text,
		"cn_bonus":_cn_bonus.text,
		"in_base":_in_base.text,
		"in_bonus":_in_bonus.text,
		"lr_base":_lr_base.text,
		"lr_bonus":_lr_bonus.text,
		"mg_base":_mg_base.text,
		"mg_bonus":_mg_bonus.text,
		"pe_base":_pe_base.text,
		"pe_bonus":_pe_bonus.text,
	}


func _on_Page_refresh()->void:
	_ag_base.text = ""
	_ag_bonus.text = ""
	_cn_base.text = ""
	_cn_bonus.text = ""
	_in_base.text = ""
	_in_bonus.text = ""
	_lr_base.text = ""
	_lr_bonus.text = ""
	_mg_base.text = ""
	_mg_bonus.text = ""
	_pe_base.text = ""
	_pe_bonus.text = ""


func create(info:Dictionary)->void:
	_ag_base.text = info.ag_base
	_ag_bonus.text = info.ag_bonus
	_cn_base.text = info.cn_base
	_cn_bonus.text = info.cn_bonus
	_in_base.text = info.in_base
	_in_bonus.text = info.in_bonus
	_lr_base.text = info.lr_base
	_lr_bonus.text = info.lr_bonus
	_mg_base.text = info.mg_base
	_mg_bonus.text = info.mg_bonus
	_pe_base.text = info.pe_base
	_pe_bonus.text = info.pe_bonus
