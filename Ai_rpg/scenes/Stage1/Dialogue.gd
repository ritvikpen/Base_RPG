extends Control

signal start
signal done
signal save

onready var tie = get_node("text_interface_engine")
onready var player = get_node("Player")
var triggered = false

func _ready():
	tie.reset()

	tie.connect("input_enter", self, "_on_input_enter")
	tie.connect("buff_end", self, "_on_buff_end")
	tie.connect("state_change", self, "_on_state_change")
	tie.connect("enter_break", self, "_on_enter_break")
	tie.connect("resume_break", self, "_on_resume_break")
	tie.connect("tag_buff", self, "_on_tag_buff")

func _on_input_enter(s):
	pass

func _on_buff_end():
	print("Buff End")
	emit_signal("done")
	tie.reset()

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
	pass

func _on_Green_body_entered( body ):
	if not triggered:
		emit_signal("start")
		tie.set_color(Color(0.1,0.8,0.1))

		tie.buff_text("0MG, you finally finished! Took you long enough! I used to be the youngest one, but now you're here, so I pretty much get a promotion.",0.03)
		tie.buff_silence(0.5)
		tie.buff_clear()

		tie.buff_text("It's pretty nice, huh. The SIMULATION, I mean. You probably got some fancy explanation in there, but this is home to us. Sorry no one else came. They've all seen dozens of CREATIONS, this is my first. I've only been around for about 2 weeks. The last DELETIONS occured quickly after each other. . .",0.03)
		tie.buff_silence(0.5)
		tie.buff_clear()

		tie.buff_text("Anyway, you're here now, so I guess I'll be your guide. Go to the right, and you'll reach the NEXUS. I'll meet you there.",0.03)
		tie.set_state(tie.STATE_OUTPUT)
		triggered = true


func _on_NPC_body_entered( body ):
	if triggered:
		emit_signal("start")
		tie.buff_text("You should check out the NEXUS, I'll catch up later. I have -um- work to do.",0.03)
		tie.buff_silence(0.5)
		tie.buff_clear()
		tie.set_state(tie.STATE_OUTPUT)
