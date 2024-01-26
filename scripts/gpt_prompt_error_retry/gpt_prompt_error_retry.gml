/// @description Prompts agent for response if error (enter true for second argumemnt for an increasing delay between requests)

function gpt_prompt_error_retry(_id_of_instance, _response_format /* "text" or "json_object" */, _retry_max_times, _request_delay = false, _request_initial_delay = 30, _request_delay_multiplier = 1.5) {
	if (instance_exists(_id_of_instance)) {
		with (_id_of_instance) {
			if (_response_format != -1) response_format = _response_format;
			error_retry = true;
			error_retry_max_times = _retry_max_times;
			error_request_delay = _request_delay;
			error_retry_countdown_reset_ini = _request_initial_delay;
			error_retry_countdown_reset = _request_initial_delay;
			error_retry_countdown_reset_multiplier = _request_delay_multiplier;
			event_user(0);
		}
	} else {
		show_debug_message("ERROR [In gpt_error_retry_mode - " + string(instance_id) + "/" + object_get_name(object_index) + "]: Instance ID not found");
	}
}