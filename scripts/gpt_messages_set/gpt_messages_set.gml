// @description Set agent messages array.
// @return undefined

function gpt_messages_set(_id_of_instance, _context) {
	if (instance_exists(_id_of_instance)) {
		with (_id_of_instance) {
			context = _context;
		}
	} else {
		show_debug_message("ERROR [In gpt_messages_set - " + string(instance_id) + "/" + object_get_name(object_index) + "]: Instance ID not found");
	}
}