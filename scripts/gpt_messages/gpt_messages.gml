/// @description Returns all previous messages in agent

function gpt_messages(_id_of_instance) {
	if (instance_exists(_id_of_instance)) {
		return variable_instance_get(_id_of_instance, "context");
	} else {
		show_debug_message("ERROR [In gpt_messages - " + string(instance_id) + "/" + object_get_name(object_index) + "]: Instance ID not found");
		return undefined;
	}
}