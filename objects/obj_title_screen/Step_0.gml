// text management
switch (title_array_index) {
	case 0:
		typist.in(0.09, 20);
		wave_size *= wave_size_multiplier;
		wave_size_multiplier *= 0.99995;
		scribble_anim_wave(wave_size, wave_freq, 0.1);
		
		var _next_title = false;
		var _skip_title = false;
		
		// background
		var _background_id = layer_background_get_id(layer_get_id("Background"));
		if (wave_size < 10) {
			var _col = layer_background_get_blend(_background_id);
			var _col_hsv = [color_get_hue(_col), color_get_saturation(_col), color_get_value(_col)];
			var _new_col = make_color_hsv(_col_hsv[0], _col_hsv[1] * 0.988, _col_hsv[2] * 1.01);
			layer_background_blend(_background_id, _new_col);
			
			if (_col_hsv[2] == 255) {
				_next_title = true;
			}
		}
		
		// skip initial title
		if (keyboard_check(vk_space) || keyboard_check(vk_enter)) {
			_next_title = true;
			_skip_title = true;
		}
		
		// move to next title
		if (_next_title) {
			layer_background_blend(_background_id, c_white);
			title_array_index = 1;
			
			if (_skip_title) {
				event_user(1);
			} else {
				alarm[0] = 60;
			}
		}
	break;
	
	case 2:
		typist.in(0.05, 0);
		if (keyboard_check(vk_space) || keyboard_check(vk_enter)) {
			typist.in(0.2, 0);
		}
		
		
		if (typist.get_position() == string_length_scribble(title_array[title_array_index]) + 1) {
			with (background) {
				if (!background_effect_countdown && background_text_received) {
					background_effect_countdown = true;
					alarm[0] = 60;
				}
				if (!draw_background) {
					draw_background = true;
					if (!background_text_received) alarm[1] = 120;
				}
			}
		}
	break;
}


// menu stuff
if (menu.start) {
	// title ease
	if (menu.title.ease != 1) {
		var _function_output = ease_inOutQuart(menu.title.ease);
		title_x = map_value(_function_output, 0, 1, room_width / 2, menu.title.pos.x);
		title_y = map_value(_function_output, 0, 1, room_height / 2, menu.title.pos.y);
		title_scale = map_value(_function_output, 0, 1, 1, menu.title.scale);
		menu.title.ease = min(menu.title.ease + 0.01, 1);
	}
	
	// actual menu
	else {
		menu.options.start = true;
		
		// menu selection
		var _current_menu = menu.options.gui;
		for (var _i = 0; _i < array_length(menu.options.state); _i++) {
			_current_menu = _current_menu.inner[menu.options.state[_i]];
		}
		if (menu.options.new_menu) {
			menu.options.text = "[fnt_source_code_pro_mediocre][c_lime]" + _current_menu.display_text + "\n";
			for (var _i = 0; _i < array_length(_current_menu.inner); _i++) {
				menu.options.text += "  /" + _current_menu.inner[_i].display_text + "\n";
			}
			menu.options.text += "[/]";
			menu.options.count = array_length(_current_menu.inner);
			menu.options.new_menu = false;
		}
		
		// menu selection cursor
		menu.options.selection.display = menu.options.typist.get_state() >= 0.5;
		var _line_height = string_height_scribble("[fnt_source_code_pro_mediocre]test[/]");
		var _mouse_in_position = (menu.options.pos.x < mouse_x && mouse_x < menu.options.pos.x + string_width_scribble(menu.options.text)) && (menu.options.pos.y + _line_height < mouse_y && mouse_y < menu.options.pos.y + (1 + menu.options.count) * _line_height);
		if (menu.options.selection.display && _mouse_in_position && !box.using && !start_effect) {
			var _selected = min(menu.options.count, int64((mouse_y - menu.options.pos.y) / _line_height)) - 1;
			menu.options.selection.text = menu.options.selection.select(_selected);
			
			// clicked
			if (mouse_check_button_pressed(mb_left)) {
				var _selected_menu = _current_menu.inner[_selected];
				var _type = _selected_menu.type;
				switch (_type) {
					case "inner":
						array_push(menu.options.state, _selected);
						menu.options.new_menu = true;
					break;
					case "upper":
						array_delete(menu.options.state, array_length(menu.options.state) - 1, 1);
						menu.options.new_menu = true;
					break;
					case "function":
						_selected_menu.func();
					break;
					case "start game":
						event_user(0);
					break;
					
					// boxes
					case "read box":
						box.using = true;
					break;
					case "input box":
						box.using = true;
					break;
					case "parameter box":
						box.using = true;
					break;
				}
				
				// if it's box time make some boxes
				if (box.using) {
					box.using_type = _type;
					box.using_index = _selected;
					box.name = _selected_menu.display_text;
					var _box_text = "";
					
					var _c_orange = make_color_rgb(255, 140, 0);
					
					var _fbox = {
						x: 3*room_width/4,
						y: room_height/2 - menu.padding/2,
						w: room_width/2,
						h: room_height/2 - menu.padding,
						w_wrap: room_width/2 - 2*menu.padding,
						h_align: fa_center,
						v_align: fa_bottom
					}
					
					if (box.using_type == "read box" || box.using_type == "input box") {
						box.contents = _selected_menu.contents;
						_box_text = box.contents;
					} else {
						box.parameters = _selected_menu.parameters;
						box.editables = variable_clone(_selected_menu.editables);
						box.parameters_index = 0;
						_box_text = box.editables[box.parameters_index]
						
						var _pbox = {
							x: _fbox.x,
							y: _fbox.y,
							w: _fbox.w,
							h: _fbox.h,
							w_wrap: _fbox.w_wrap,
							h_align: _fbox.h_align,
							v_align: _fbox.v_align
						}
						
						box.parameter_box = input_text_create_multiline_ext(_pbox.x, _pbox.y, _pbox.w, _pbox.h, fnt_source_code_pro_mediocre_small, _c_orange, 1, _pbox.w_wrap, -1, -1, -1, _pbox.h_align, _pbox.v_align, true, 0);
						input_text_set_text(box.parameter_box, box.parameters[box.parameters_index]);
						
						var _max_parameter_box_h = 0;
						for (var _i = 0; _i < array_length(box.parameters); _i++) {
							var _parameter_i_h = string_height_scribble_ext("[fnt_source_code_pro_mediocre_small]" + box.parameters[_i] + "[/]", _pbox.w_wrap);
							if (_parameter_i_h > _max_parameter_box_h) _max_parameter_box_h = _parameter_i_h;
						}
						_fbox.y -= _max_parameter_box_h + menu.padding/4;
					}
					
					var _bbox = {
						x: room_width/2 + menu.padding,
						y: room_height/2,
						w: _fbox.w,
						h: _fbox.h,
						w_wrap: _fbox.w_wrap,
						h_align: fa_left,
						v_align: fa_top
					}
					
					box.filename_box = input_text_create_multiline_ext(_fbox.x, _fbox.y, _fbox.w, _fbox.h, fnt_source_code_pro_mediocre, _c_orange, 1, _fbox.w_wrap, -1, -1, -1, _fbox.h_align, _fbox.v_align, true, 0);
					box.box = input_text_create_multiline_ext(_bbox.x, _bbox.y, _bbox.w, _bbox.h, fnt_source_code_pro_mediocre_small, _c_orange, 1, _bbox.w_wrap, -1, -1, -1, _bbox.h_align, _bbox.v_align, true, 0);
					input_text_set_selection_colors(box.box, _c_orange, c_black);
					
					// box background
					box.height = (room_height - _fbox.y) + input_text_get_text_height(box.filename_box) + menu.padding/2;
					if (box.using_type == "parameter box") box.height += 7.11*sprite_get_height(spr_title_screen_box_arrow_left) + 2*7.11;
					box.background.animate = 1;
				}
			}
		} else if (box.using) {
			menu.options.selection.text = menu.options.selection.select(box.using_index, "[shake]>");
		} else {
			menu.options.selection.text = "";
		}
	}
}