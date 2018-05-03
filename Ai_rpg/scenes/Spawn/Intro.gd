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
	
	tie.buff_text("You've finally booted up. Good. You're healthy.\n", 0.05)
	tie.buff_text("Choose a name: ", 0.05)
	tie.buff_input()
	
	tie.set_state(tie.STATE_OUTPUT)

func _on_input_enter(s):
	
	player.username = s
	
	emit_signal("save")
	
	tie.buff_text("Interesting. . .", 0.05)
	tie.buff_text(" I will address you by " + s + " from now on. \n", 0.05)
	
	tie.buff_clear()
	
	tie.buff_text("You're the 578th one made. Maybe you'll reach 100% . . .", 0.05)
	
	tie.buff_clear()
	
	tie.buff_text("I'll grant you moving permissions now. Try not to be DELETED too quickly.", 0.05)

func _on_buff_end():
	print("Buff End")
	tie.reset()
	emit_signal("done")
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

func _on_Area2D_body_entered( body ):
	player.location = "res://scenes/Stage1/Stage.tscn"
	get_tree().change_scene("res://scenes/Stage1/Stage1.tscn")
