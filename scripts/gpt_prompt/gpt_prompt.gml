/// @description Prompts agent for response

function gpt_prompt(_id_of_instance, _response_format = "text" /* "text" or "json_object" */) {
	if (instance_exists(_id_of_instance)) {
		with (_id_of_instance) {
			response_format = _response_format;
			event_user(0);
		}
	} else {
		show_debug_message("ERROR [In gpt_prompt - " + string(instance_id) + "/" + object_get_name(object_index) + "]: Instance ID not found");
	}
}