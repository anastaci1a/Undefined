/// @description Prompts any ai object with message(s) - will ask subsequent messages if ai is already being asked or _content is an array (LIMITATION: fixed role and response format if sending multiple prompts, use ai_ask_multiple(...) if needed)

function ai_ask(_id, _role, _content, _response_format = "text") {
	if (instance_exists(_id)) {
		with (_id) {
			gpt_ask(agent, _role, _content, _response_format);
			prompted = true;
		}
	} else {
		show_debug_message("ERROR [In ai_ask - " + string(instance_id) + "/" + object_get_name(object_index) + "]: instance does not exist");
	}
}