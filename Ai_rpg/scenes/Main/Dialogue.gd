extends Control

signal start
signal done
signal save

onready var tie = get_node("text_interface_engine")
onready var player = get_node("Player")

func _ready():
	
	emit_signal("start")
	
	tie.reset()
	
	tie.connect("input_enter", self, "_on_input_enter")
	tie.connect("buff_end", self, "_on_buff_end")
	tie.connect("state_change", self, "_on_state_change")
	tie.connect("enter_break", self, "_on_enter_break")
	tie.connect("resume_break", self, "_on_resume_break")
	tie.connect("tag_buff", self, "_on_tag_buff")
	
	tie.buff_text("Press ENTER . . .",0.05)
	tie.add_newline()
	tie.buff_input()
	tie.set_state(tie.STATE_OUTPUT)

func _on_input_enter(s):
	var save = player.load_game()
	get_tree().change_scene(save.location)
	pass
	
func _on_buff_end():
	print("Buff End")
	tie.reset()
	pass

func _on_state_change(i):
	print("New state: ", i)
	pass

func _on_enter_break():
	print("Enter Break")
	pass

func _on_resume_break():
	print("Resume Break")
	pass

func _on_tag_buff(s):
	print("Tag Buff ",s)
	pass