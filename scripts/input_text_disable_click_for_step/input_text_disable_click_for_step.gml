/// @description input_text_disable_click_for_step(_id)

function input_text_disable_click_for_step(_id) {
	if (instance_exists(_id)) {
		with (_id) {
			disable_click_for_step = true;
		}
	}
}