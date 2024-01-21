/// @description Returns the latest message in agent.
/// @return Struct

function gpt_messages_latest(_id_of_instance) {
	if (instance_exists(_id_of_instance)) {
		return array_last(gpt_messages(_id_of_instance));
	} else {
		show_debug_message("ERROR [In gpt_messages_latest - " + string(instance_id) + "/" + object_get_name(object_index) + "]: Instance ID not found");
		return undefined;
	}
}