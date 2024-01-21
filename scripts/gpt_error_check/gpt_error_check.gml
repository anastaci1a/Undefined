/// @description Checks if error has occurred in request.
/// @return Real

/*
	0: no error
	>0: error
*/

function gpt_error_check(_id_of_instance) {
	if (instance_exists(_id_of_instance)) {
		var _error = false;
		with (_id_of_instance) {
			_error = error;
			error = 0;
		}
		return _error;
	} else {
		show_debug_message("ERROR [In gpt_error_check - " + string(instance_id) + "/" + object_get_name(object_index) + "]: Instance ID not found");
	}
}