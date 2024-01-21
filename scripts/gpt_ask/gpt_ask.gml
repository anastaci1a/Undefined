/// @description Prompts a gpt with message(s) - will ask subsequent messages if gpt has already being prompted or _content is an array.
/// @return undefined

function gpt_ask(_id_of_instance, _role, _content, _response_format = "text"  /* "text" or "json_object" */) {
	if (instance_exists(_id_of_instance)) {
		var _is_array = is_array(_content);
		
		// single prompt
		if (!_is_array) _gpt_ask_single(_id_of_instance, _role, _content, _response_format);
		
		// multiple prompts
		else {
			for (var _i = 0; _i < array_length(_content); _i++) {
				_gpt_ask_single(_id_of_instance, _role, _content[_i], _response_format);
			}
		}
	} else {
		show_debug_message("ERROR [In gpt_ask - " + string(instance_id) + "/" + object_get_name(object_index) + "]: instance does not exist");
	}
}