/// @description Returns true for one frame if image has been received from DALL·E

function dalle_parse_check_instant(_id_of_instance) {
	if (instance_exists(_id_of_instance)) {
		var _image_parsed = false;
		with (_id_of_instance) {
			_image_parsed = image_parsed;
			image_parsed_ = false;
		}
		return _image_parsed;
	} else {
		show_debug_message("ERROR [In dalle_parse_check - " + string(instance_id) + "/" + object_get_name(object_index) + "]: Instance ID not found");
	}
}