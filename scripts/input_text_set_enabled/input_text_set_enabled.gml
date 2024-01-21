/// @description  input_text_set_enabled(id, enabled)
/// @function  input_text_set_enabled
/// @param id
/// @param enabled
/// @param set_cursor_to_end
function input_text_set_enabled(argument0, argument1, argument2 = false) {
	// Enables/disables a text input unless it's not already enabled/disabled. When a text input is disabled, the user can't input text and the text cursor will not be shown. Text inputs are disabled when created,
	// so you need this script to enable them.
	// id: The instance id of the obj_input_text to be enabled.
	// enabled: Whether to enable (true) or disable (false).

	if (argument1) {
	    if (!argument0.enabled) {
	        with (obj_input_text) {enabled = false; selection_start = 0;}
	        with (argument0) {
	            enabled = true; enabled_step = 0;
	            keyboard_string = "";
	            cursor_timer = cursor_time;
	            key_pressed_timer = -1; key_down = -1;
	            event_perform(ev_step, ev_step_normal);
		
				if (argument2) {
					var _string_length = string_length(text_change_from_outside);
					cursor_position = _string_length + 1;
				}
	        }
	    }
	} else
	    if (argument0.enabled)
	        with (argument0) {enabled = false; selection_start = 0;}
}
