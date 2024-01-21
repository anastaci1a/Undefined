/// @description Returns any ai object's core agent (gpt_agent object)

function ai_get_core(_id) {
	if (instance_exists(_id)) {
		with (_id) {
			return agent;
		}
	} else {
		show_debug_message("ERROR [In aicore_get_core - " + string(instance_id) + "/" + object_get_name(object_index) + "]: instance does not exist");
	}
}