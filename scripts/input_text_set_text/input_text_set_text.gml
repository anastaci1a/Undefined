/// @description  input_text_set_text(id, text, set_cursor_to_end)
/// @function  input_text_set_text
/// @param id
/// @param text
/// @param set_cursor_to_end
function input_text_set_text(argument0, argument1, argument2 = false) {
	// Sets the text of a text input instance. This will automatically move the text cursor to the end of the text. Example 0: A username input that has the option to "remember username", would use this script so the user wouldn't
	// have to type it everytime. Example 1: If you want e.g. a default name like "Player" in a name input, you can use this script. Example 2: If you have a random name generator, use this script to set to the randomized name.
	// id: The instance id of the obj_input_text to set the text for.
	// text: A string of the text.

	with (argument0) {
	    text_change_from_outside = string_replace_all(argument1, chr(13), "");
    
	    // Forces step event (this is done because the draw event uses variables assigned in the step event, and we want to have the correct text be drawn immediately).
	    event_perform(ev_step, ev_step_normal);
		
		if (argument2) {
			var _string_length = string_length(text_change_from_outside);
			cursor_position = _string_length + 1;
		}
	}
}
