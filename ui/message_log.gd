extends Label

var messages = [] # moving queue
var message_limit = 5

func _ready():
	send_message("hello")
	send_message("you picked up a silver key!")
	send_message("hello")
	send_message("hello")
	send_message("hello")
	send_message("hello")
	send_message("hello")
	send_message("hello")
	send_message("hello")
	
	
	_update_text()

func send_message(msg : String) -> void:
	if messages.size() >= message_limit:
		messages.pop_front()
	messages.push_back(msg)
	_update_text()

func _update_text():
	var buffer = ""
	for msg in messages:
		buffer += msg
		buffer += '\n'
	text = buffer
