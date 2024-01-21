/// @description Prompts any ai object with multiple messages, first message will be prompted immediately (if ai is not currently being asked) and the remaining will be asked as subsequent followup messages

function ai_ask_multiple(_id, _prompts) {
	if (instance_exists(_id)) {
		with (_id) {
			gpt_ask_multiple(agent, _prompts);
			prompted = true;
		}
	} else {
		show_debug_message("ERROR [In ai_ask - " + string(instance_id) + "/" + object_get_name(object_index) + "]: instance does not exist");
	}
}