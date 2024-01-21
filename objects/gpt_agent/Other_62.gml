/// @description [Receive request]

var _size = ds_map_size(async_load);
var _key = ds_map_find_first(async_load);
for (var i = 0; i < _size; i++) {
	if (_key == "result") {
		try {
			var _response_id = async_load[? "id"];
			if (request_id == _response_id) {
				var __response = async_load[? _key];
				var _response = undefined;
				try {
					if (!stream) {
						_response = json_parse(__response);
						var _msg = _response.choices[0].message.content;
						latest_response = _msg;
						array_push(context, {
							"role": "assistant",
							"content": _msg
						});
					} else {
						_response = string(__response);
						_response = string_replace_all(_response, "data: [DONE]", "");
						_response = string_copy(_response, 7, string_length(_response) - 6);
						_response = string_replace_all(_response, "data:", ",");
						_response = "[" + _response + "]";
						_response = json_parse(_response);
						
						var _last_index = _response[array_length(_response) - 2];
						finish_reason = _last_index.choices[0].finish_reason;
						
						var _msg = "";
						for (var _i = 0; _i < array_length(_response) - 1; _i++) {
							_msg += _response[_i].choices[0].delta.content;
						}
						latest_response = _msg;
						array_push(context, {
							"role": "assistant",
							"content": _msg
						});
					}
					
					prompted = array_length(future_prompts) != 0; // if the array length of future_prompts isn't 0, keep prompting using future prompts
					// multiple prompts
					if (prompted) {
						var _next_prompt = future_prompts[0];
						array_push(context, _next_prompt.msg);
						response_format = _next_prompt.response_format;
						array_delete(future_prompts, 0, 1);
						event_user(0);
					}
					
					// prompting finished
					else {
						message_received_ = true;
						message_received = true;
					}
					
					error = 0;
					error_retry = false;
					error_retry_countdown_reset = error_retry_countdown_reset_ini;
				} catch (_e) {
					prompted = false;
					error = 1;
					show_debug_message("\n--- RESPONSE ---\n" + string(__response) + "\n----------------\n\n--- ERROR ---\n" + string(_e) + "\n-------------");
				}
			}
		} catch (_e) {
			prompted = false;
			error = 2;
			show_debug_message("ERROR: No response (" + string(_e) + ")");
		}
	}
	_key = ds_map_find_next(async_load, _key);
}