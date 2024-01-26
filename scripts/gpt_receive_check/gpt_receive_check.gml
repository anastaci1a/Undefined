/// @description Checks if message has been received from agent

function gpt_receive_check(_id_of_instance) {
	if (instance_exists(_id_of_instance)) {
		with (_id_of_instance) {
			return message_received;
		}
	} else {
		show_debug_message("ERROR [In gpt_receive_check - " + string(instance_id) + "/" + object_get_name(object_index) + "]: Instance ID not found");
	}
}