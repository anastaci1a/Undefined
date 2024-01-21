/// @description [Send request]

// HTTP Request Headers
var _headers = ds_map_create();
ds_map_add(_headers, "Content-Type", "application/json");
ds_map_add(_headers, "Authorization", "Bearer " + OpenAI_key);

// HTTP Request Body
var __body = {
	model: model,
	prompt: prompt,
	size: size,
	style: style
};

var _body = json_stringify(__body);

// Send HTTP Post Request
request_id = http_request(OpenAI_dalle_url, "POST", _headers, _body);

// Clean up the headers map
ds_map_destroy(_headers);