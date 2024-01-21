/// @description Sets size of input text object.

function input_text_set_size(_id, _width, _height) {
	var _new_id = undefined;
	with (_id) {
		if (_width == -1) _width = width;
		if (_height == -1) _height = height;
		_new_id = input_text_create(multiline, x, y, _width, _height, font, color, alpha, wrapping_width, max_length, max_lines, line_separation, h_align, v_align, selection_enabled, fit_style);
	}
	input_text_set_text(_new_id, input_text_get_text(_id));
	instance_destroy(_id);
	
	return _new_id;
	
	
	// NOT WORKING
	
	//with (_id) {
	//	if (_width == -1) _width = width;
	//	if (_height == -1) _height = height;
	//	show_debug_message(_width);
	//	show_debug_message(_height);
		
	//	width = _width;
	//	height = _height;
	//	origin_x = 0; if (h_align == fa_center) origin_x += (width >> 1); else if (h_align == fa_right) origin_x += width;
	//	origin_y = 0; if (v_align == fa_middle) origin_y += (height >> 1); else if (v_align == fa_bottom) origin_y += height;
	//	matrix_identity = matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1);
	//	if (fit_style == 0) matrix_local = matrix_build(origin_x, origin_y, 0, 0, 0, 0, 1, 1, 1);
	//}
}