/// @description [Send request]

// HTTP Request Headers
var _headers = ds_map_create();
ds_map_add(_headers, "Content-Type", "application/json");
ds_map_add(_headers, "Authorization", "Bearer " + OpenAI_key);

// HTTP Request Body
var __body = {
	"model": model,
	"messages": context,
	"max_tokens": int64(max_tokens),
	"temperature": temperature,
	"stream": stream
};

// response_format compatibility
if (model == OpenAI_gpt_4_128k || model == OpenAI_gpt_3_5_turbo_new) {
	var _response_format = { "type": response_format };
	variable_struct_set(__body, "response_format", _response_format);
} else if (response_format != "text") {
	show_debug_message("WARNING: response format \"json_object\" is only supported by the \"" + OpenAI_gpt_3_5_turbo_new + "\" and \"" + OpenAI_gpt_4_128k + "\" models.");
}

var _body = json_stringify(__body);

// Send HTTP Post Request
request_id = http_request(OpenAI_chat_url, "POST", _headers, _body);
prompted = true;
wait_time = 0;

// Error Retry Reset
if (!error_retry) {
	error_retry_failed = false;
	error_request_delay = false;
	error_retry_times = 0;
	error_retry_countdown = false;
	error_retry_countdown_reset = error_retry_countdown_reset_ini;
	error_retry_countdown_count = 0;
}

// Clean up the headers map
ds_map_destroy(_headers);