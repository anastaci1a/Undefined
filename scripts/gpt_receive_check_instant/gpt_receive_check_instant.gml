/// @description Checks if message has been received from agent, returns true for one frame once received

function gpt_receive_check_instant(_id_of_instance) {
	if (instance_exists(_id_of_instance)) {
		var _message_received = false;
		with (_id_of_instance) {
			_message_received = message_received_;
			message_received_ = false;
		}
		return _message_received;
	} else {
		show_debug_message("ERROR [In gpt_receive_check_instant - " + string(instance_id) + "/" + object_get_name(object_index) + "]: Instance ID not found");
	}
}