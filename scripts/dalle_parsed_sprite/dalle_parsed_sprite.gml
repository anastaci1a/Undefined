/// @description Returns latest generated image as sprite.
/// @return Resource

function dalle_parsed_sprite(_id_of_instance) {
	if (instance_exists(_id_of_instance)) {
		return variable_instance_get(_id_of_instance, "image_sprite");
	} else {
		show_debug_message("ERROR [In dalle_parsed_sprite - " + string(instance_id) + "/" + object_get_name(object_index) + "]: Instance ID not found");
		return undefined;
	}
}