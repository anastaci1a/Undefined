// @description Add to agent messages array (_content can be an array)

function gpt_messages_add(_id_of_instance, _role, _content) {
	if (instance_exists(_id_of_instance)) {
		with (_id_of_instance) {
			var _is_array = is_array(_content);
			
			// add single message
			if (!_is_array) {
				array_push(context, {
					role: _role,
					content: _content
				});
			}
			
			// add multiple messages
			else {
				for (var _i = 0; _i < array_length(_content); _i++) {
					array_push(context, {
						role: _role,
						content: _content[_i]
					});
				}
			}
		}
	} else {
		show_debug_message("ERROR [In gpt_messages_add - " + string(instance_id) + "/" + object_get_name(object_index) + "]: Instance ID not found");
	}
}