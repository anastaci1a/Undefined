/// @description input_text_set_selection_colors(_background_color, _background_alpha, _text_color, _text_alpha)

function input_text_set_selection_colors(_id, _background_color = c_black, _text_color = c_white, _background_alpha = 0.6, _text_alpha = 1) {
	with (_id) {
		selection_color_background = _background_color;
		selection_alpha_background = _background_alpha;
		selection_color_text = _text_color;
		selection_alpha_text = _text_alpha;
		
	    selection_red_text = color_get_red(selection_color_text) / 255;
		selection_green_text = color_get_green(selection_color_text) / 255;
		selection_blue_text = color_get_blue(selection_color_text) / 255;
		
	    selection_red_background = color_get_red(selection_color_background) / 255;
		selection_green_background = color_get_green(selection_color_background) / 255;
		selection_blue_background = color_get_blue(selection_color_background) / 255;
	}
}