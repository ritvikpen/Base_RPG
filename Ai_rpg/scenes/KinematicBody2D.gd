extends KinematicBody2D

const SPEED = 300
var motion = Vector2()
var speaking = false

# SAVE DATA -START-
var username = null
var location = null
# SAVE DATA -END-

func user_controls():
	if Input.is_action_pressed("ui_up"):
		motion.y = -SPEED
	elif Input.is_action_pressed("ui_down"):
		motion.y = SPEED
	elif Input.is_action_pressed("ui_right"):
		motion.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		motion.x = -SPEED

func _physics_process(delta):

	motion.x = 0
	motion.y = 0

	if not speaking:
		user_controls()

	move_and_slide(motion)

func save():
	var save_dict = {
		username = username,
		location = location
	}
	return save_dict

func save_game():
	var save_game = File.new()
	save_game.open("res://savegame.json", File.WRITE)
	save_game.store_line(to_json(save()))
	save_game.close()

func load_game():
	var save_raw = File.new()
	save_raw.open("res://savegame.json", File.READ)
	var save_text = save_raw.get_as_text()
	save_raw.close()
	var save_parsed = JSON.parse(save_text)
	var save_final = save_parsed.result
	return save_final

func _on_Dialogue_done():
	speaking = false

func _on_Dialogue_start():
	speaking = true

func _on_Dialogue_save():
	save_game()
