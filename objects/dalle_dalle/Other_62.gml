/// @description [Receive request]

var _size = ds_map_size(async_load);
var _key = ds_map_find_first(async_load);
for (var i = 0; i < _size; i++) {
	if (_key == "result") {
		try {
			var _response_id = async_load[? "id"];
			if (request_id == _response_id) {
				var _response = json_parse(async_load[? _key]);
				try {
					var _url = _response.data[0].url;
					var _filename = "dall-e " + string(int64(random_range(1000000, 10000000))) + ".png";
					image_path = "DALL·E Generations\\" + _filename;
					download_id = http_get_file(_url, image_path);
				} catch (_e) {
					show_debug_message(_response);
				}
			}
		} catch (_e) {
			show_debug_message("ERROR: No internet connection.", "(" + string(_e) + ")");
		}
	}
	_key = ds_map_find_next(async_load, _key);
}

// add downloaded image to sprites
if (ds_map_find_value(async_load, "id") == download_id) {
	var _status = ds_map_find_value(async_load, "status");
    if _status == 0	{
		image_path = ds_map_find_value(async_load, "result");
		image_sprite = sprite_add(image_path, 1, false, false, 0, 0);
		image_parsed = true;
	}
}