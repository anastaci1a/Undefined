/// @description [use gpt_ask] Prompts gpt with single message and adds to future prompts if gpt is being prompted.
/// @return undefined

function _gpt_ask_single(_id_of_instance, _role, _content, _response_format = "text") {
	if (instance_exists(_id_of_instance)) {
		var _msg = { role: _role, content: _content };
		
		with (_id_of_instance) {
			if (prompted) {
				array_push(future_prompts, {
					response_format: _response_format,
					msg: _msg
				});
			} else {
				array_push(context, _msg);
				gpt_prompt(id, _response_format);
			}
		}
	} else {
		show_debug_message("ERROR [In _gpt_ask_single - " + string(instance_id) + "/" + object_get_name(object_index) + "]: instance does not exist");
	}
}