extends Label

var messages = [] # moving queue
var message_limit = 5
const MESSAGE_DURATION = 4.0 # the time a message remains on screen

func _ready():
	send_message("The air is cold and damp, the darkness beckons.")

func send_message(msg : String) -> void:
	if messages.size() >= message_limit:
		messages.pop_front()
	messages.push_back(msg)
	_update_text()
	await get_tree().create_timer(MESSAGE_DURATION).timeout
	messages.erase(msg)
	_update_text()

func _update_text():
	var buffer = ""
	for msg in messages:
		buffer += msg
		buffer += '\n'
	text = buffer
