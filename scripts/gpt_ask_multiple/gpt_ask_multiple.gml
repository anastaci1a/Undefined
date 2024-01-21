/// @description Prompts a gpt with multiple messages, first message will be prompted immediately (if gpt is not currently being asked) and the remaining will be asked as subsequent followup messages
/// @return undefined

/*

_prompts format:
----------------

[
	{
		response_format: "example",
		msg: {
			role: "example",
			content: "example
		}
	},
	
	{...},
	
	...
]

*/

function gpt_ask_multiple(_id_of_instance, _prompts) {
	if (instance_exists(_id_of_instance)) {
		for (var _i = 0; _i < array_length(_prompts); _i++) {
			var _prompt = _prompts[_i];
			_gpt_ask_single(_id_of_instance, _prompt.msg.role, _prompt.msg.content, _prompt.response_format);
		}
	} else {
		show_debug_message("ERROR [In gpt_ask_multiple - " + string(instance_id) + "/" + object_get_name(object_index) + "]: instance does not exist");
	}
}