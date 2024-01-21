// display title
titlebox = scribble(title_array[title_array_index])
.align(fa_middle, fa_center)
.transform(title_scale, title_scale, 0);
titlebox.draw(title_x, title_y, typist);


// menu text
if (menu.options.start) {
	var test_text = "[fnt_source_code_pro_mediocre][c_lime]test 1\ntest 2\ntest 3\ntest 4\ntest 5\ntest 6\ntest 7\ntest 8[/]";
	menu.options.textbox = scribble(menu.options.text)
	.align(fa_left, fa_top);
	menu.options.textbox.draw(menu.options.pos.x, menu.options.pos.y, menu.options.typist);
	
	if (menu.options.selection.display || box.using) {
		menu.options.selection.textbox = scribble(menu.options.selection.text)
		.align(fa_left, fa_top);
		menu.options.selection.textbox.draw(menu.options.pos.x, menu.options.pos.y);
	}
}


// boxes (THIS IS A FUCKING MESS DON'T LOOK (it works tho))
if (box.using) {
	// background
	if (box.background.visibility == 1) box.background.visibility = 0.999;
	
	var _background_ease_vis = ease_outQuart(box.background.visibility);
	var _background_sprite_height = box.background.scale * sprite_get_height(box.background.sprite);
	var _background_y_offset = _background_sprite_height - (box.height % _background_sprite_height);
	var _background_sprites = int64(box.height / _background_sprite_height) + 2;
	var _background_sprites_now = int64(_background_ease_vis * _background_sprites);
	
	for (var _i = 0; _i < _background_sprites_now; _i++) {
		var _x = box.background.x;
		var _y = box.background.y + _background_y_offset - (_i * _background_sprite_height);
		
		var _sprite = box.background.sprite;
		var _y_scale = box.background.scale;
		if (_i == _background_sprites_now - 1) {
			var _percentage = (_background_ease_vis * _background_sprites) % 1;
			_y_scale *= _percentage;
			_sprite = box.background.sprite_top;
		}
		var _alpha = map_value(box.background.visibility, 0, 1, 0.5, 0.9); // 0.9;
		draw_sprite_ext(_sprite, int64(box.background.sprite_frame), _x, _y, box.background.scale, _y_scale, 0, -1, _alpha);
	}
	box.background.sprite_frame += 1/6;
	
	if (box.background.visibility == 0.999) box.background.visibility = 1;
	
	
	// set _current_menu variable (reference of menu.options.gui.* struct)
	var _current_menu = menu.options.gui;
	for (var _i = 0; _i < array_length(menu.options.state); _i++) {
		_current_menu = _current_menu.inner[menu.options.state[_i]];
	}
	_current_menu = _current_menu.inner[box.using_index];
	
	
	// set box.contents or box.editables vars and add "*" to filename text if unsaved
	var _filename_text = box.name;
	var _box_text = "";
	var _box_enabled = box.background.visibility == 1;
	if  (box.using_type == "read box") _box_text = box.contents;
	if (box.using_type == "input box") {
		_box_text = box.contents;
		
		var _input_text = input_text_get_text(box.box);
		if (_box_enabled) {
			if (_input_text != box.contents) box.contents = _input_text;
		}
		if (box.background.animate != 1) {
			if (box.contents != _current_menu.contents) _filename_text += "*";
		}
	}
	if (box.using_type == "parameter box") {
		var _i = box.parameters_index;
		_box_text = box.editables[_i];
		
		_filename_text += " (" + string(_i + 1) + "/" + string(array_length(box.parameters)) + ")";
		
		var _input_text = input_text_get_text(box.box);
		if (_box_enabled) {
			if (_input_text != box.editables[_i]) box.editables[_i] = _input_text;
		}
		if (box.background.animate != 1) {
			if (box.editables[_i] != _current_menu.editables[_i]) _filename_text += "*";
		}
		
		var _parameter_text = box.parameters[_i];
		var _parameter_width = map_clamp_value(box.background.visibility, 0.4, 0.9, 1, box.width);
		box.parameter_box = input_text_set_size(box.parameter_box, _parameter_width, -1);
		if (_parameter_width == 1) _parameter_text = "";
		input_text_set_text(box.parameter_box, _parameter_text);
	}
	
	// filename box stuff
	var _filename_width = map_clamp_value(box.background.visibility, 0.5, 1, 1, box.width);
	box.filename_box = input_text_set_size(box.filename_box, _filename_width, -1);
	if (_filename_width == 1) _filename_text = "";
	input_text_set_text(box.filename_box, _filename_text);
	
	// box box display animation
	if (!_box_enabled) {
		var _box_text_amount = map_clamp_value(box.background.visibility, 0.3, 0.8, 0, string_length(_box_text));
		_box_text = substring(_box_text, 0, _box_text_amount)
		input_text_set_text(box.box, _box_text);
	}
	
	
	// animating
	if (box.background.animate != 0) {
		// open
		var _vis_spd = 0.025;
		if (box.background.animate == 1) {
			box.background.visibility += _vis_spd;
			if (box.background.visibility >= 1) {
				box.background.visibility = 1;
				box.background.animate = 0;
				
				if (box.using_type != "read box") input_text_set_enabled(box.box, true);
			}
		}
		
		// close
		else if (box.background.animate == 2) {
			input_text_set_enabled(box.box, false);
			
			box.background.visibility -= _vis_spd;
			if (box.background.visibility <= 0) {
				box.background.visibility = 0;
				box.background.animate = 0;
				
				// reset box vars
				box.contents = "";
				box.parameters = [];
				box.editables = [];
				box.parameters_index = 0;
				
				box.save_ease = 0;
				box.exit_ease = 0;
				
				box.saving_exit = false;
				
				box.using_type = "";
				box.using_index = -1;
				box.using = false;
				box.name = "";
				box.contents = "";
				box.background.animate = 2;
				
				//destroy boxes
				box.filename_box = undefined;
				box.parameter_box = undefined;
				box.box = undefined;
				instance_destroy(obj_input_text);
				
				box.arrow_left_vis = -0.5;
				box.arrow_right_vis = 0;
			}
		}
	}
	
	// box sprites
	
	// arrow buttons
	
	// drawing
	if (box.using_type == "parameter box") {
		var _arrow_vis = map_clamp_value(box.background.visibility, 0.7, 1, 0, 1);
		
		var _y = variable_instance_get(box.filename_box, "y") - input_text_get_text_height(box.filename_box) - menu.padding/2;
		var _btn = {
			scale: 7.11,
			left: {
				sprite: spr_title_screen_box_arrow_left,
				alpha: map_value(box.arrow_left_vis, 0, 1, 0.5, 0.75) * _arrow_vis,
				show: box.parameters_index != 0,
				x: room_width/2,
				y: _y
			},
			right: {
				sprite: spr_title_screen_box_arrow_right,
				alpha: map_value(box.arrow_right_vis, 0, 1, 0.5, 0.75) * _arrow_vis,
				show: box.parameters_index != array_length(box.parameters) - 1,
				x: room_width,
				y: _y
			}
		}
		
		
		// sprite subimage
		//_btn.left.sprite_info = sprite_get_info(_btn.left.sprite);
		//_btn.left.subimages = _btn.left.sprite_info.num_subimages;
		//_btn.left.subimg = int64(map_value(max(0, box.arrow_left_vis), 0, 1, 0, _btn.left.subimages - 1));
		_btn.left.subimg = 0;
		
		//_btn.right.sprite_info = sprite_get_info(_btn.right.sprite);
		//_btn.right.subimages = _btn.right.sprite_info.num_subimages;
		//_btn.right.subimg = int64(map_value(max(0, box.arrow_right_vis), 0, 1, 0, _btn.left.subimages - 1));
		_btn.right.subimg = 0;
		
		
		// draw
		draw_sprite_ext(_btn.left.sprite, _btn.left.subimg, _btn.left.x, _btn.left.y, _btn.scale, _btn.scale, 0, -1, _btn.left.alpha);
		draw_sprite_ext(_btn.right.sprite, _btn.right.subimg, _btn.right.x, _btn.right.y, _btn.scale, _btn.scale, 0, -1, _btn.right.alpha);
		
		
		// hovering/click
		var _show_speed = 0.08;
		var _hide_speed = 0.12;
		var _hidehide_speed = 0.16;
		var _update_box = false;
		
		// left
		var _left_x_bounds = _btn.left.x < mouse_x && mouse_x < _btn.left.x + _btn.scale*sprite_get_width(_btn.left.sprite);
		var _left_y_bounds = _btn.left.y - _btn.scale*sprite_get_height(_btn.left.sprite) < mouse_y && mouse_y < _btn.left.y;
		_btn.left.in_bounds = _left_x_bounds && _left_y_bounds;
		if (_btn.left.show) {
			if (_left_x_bounds && _left_y_bounds) {
				if (mouse_check_button_pressed(mb_left)) {
					box.parameters_index--;
					_update_box = true;
				}
				box.arrow_left_vis = min(1, box.arrow_left_vis + _show_speed);
			} else {
				box.arrow_left_vis = max(0, box.arrow_left_vis - _hide_speed);
			}
		} else {
			box.arrow_left_vis = max(-0.5, box.arrow_left_vis - _hidehide_speed);
		}
		
		// right
		var _right_x_bounds = _btn.right.x - _btn.scale*sprite_get_width(_btn.right.sprite) < mouse_x && mouse_x < _btn.right.x;
		var _right_y_bounds = _btn.right.y - _btn.scale*sprite_get_height(_btn.right.sprite) < mouse_y && mouse_y < _btn.right.y;
		_btn.right.in_bounds = _left_x_bounds && _left_y_bounds;
		if (_btn.right.show) {
			if (_right_x_bounds && _right_y_bounds) {
				if (mouse_check_button_pressed(mb_left)) {
					box.parameters_index++;
					_update_box = true;
				}
				box.arrow_right_vis = min(1, box.arrow_right_vis + _show_speed);
			} else {
				box.arrow_right_vis = max(0, box.arrow_right_vis - _hide_speed);
			}
		} else {
			box.arrow_right_vis = max(-0.5, box.arrow_right_vis - _hidehide_speed);
		}
		
		
		// update box if necessary
		if (_update_box) {
			input_text_set_text(box.parameter_box, box.parameters[box.parameters_index], true);
			input_text_set_text(box.box, box.editables[box.parameters_index], true);
		}
	}
	
	
	// exit buttons (save/no save)
	var _save = false, _exit = false;
	var _exit_vis = map_clamp_value(box.background.visibility, 0, 0.4, 0, 1);
	
	// save
	
	if (box.using_type != "read box") {
		// drawing
		var _save_btn = {
			sprite: spr_title_screen_box_exit_save,
			alpha: map_value(box.save_ease, 0, 0.9, 0.5, 0.75) * _exit_vis,
			ease: min(map_value(ease_inOutQuart(box.save_ease), 0, 0.95, 0, 1), 1),
			scale: 7.11
		}
		_save_btn.sprite_info = sprite_get_info(_save_btn.sprite);
		_save_btn.subimages = _save_btn.sprite_info.num_subimages;
		_save_btn.subimg = int64(map_value(_save_btn.ease, 0, 1, 0, _save_btn.subimages - 1));
		
		draw_sprite_ext(_save_btn.sprite, _save_btn.subimg, room_width, room_height, _save_btn.scale, _save_btn.scale, 0, -1, _save_btn.alpha);
		
		// hovering/click ease effect and box(es) reset
		var _save_x_bounds = mouse_x > room_width - (_save_btn.scale * sprite_get_width(_save_btn.sprite));
		var _save_y_bounds = mouse_y > room_height - (_save_btn.scale * sprite_get_height(_save_btn.sprite));
		if (_save_x_bounds && _save_y_bounds) {
			if (mouse_check_button(mb_left) && box.save_ease == 1) {
				_save = true;
				_exit = true;
				box.saving_exit = true;
			}
			box.save_ease = min(1, box.save_ease + 0.04);
		} else {
			if (!box.saving_exit) box.save_ease = max(0, box.save_ease - 0.06);
		}
	}
	
	
	// no save
	
	// drawing
	var _exit_btn = {
		sprite: spr_title_screen_box_exit,
		alpha: map_value(box.exit_ease, 0, 0.9, 0.5, 0.75) * _exit_vis,
		scale: 7.11
	}
	draw_sprite_ext(_exit_btn.sprite, 0, room_width/2, room_height, _exit_btn.scale, _exit_btn.scale, 0, -1, _exit_btn.alpha);
	
	// hovering/click ease effect and box(es) reset
	var _exit_x_bounds = room_width/2 < mouse_x && mouse_x < room_width/2 + (_exit_btn.scale * sprite_get_width(_exit_btn.sprite));
	var _exit_y_bounds = mouse_y > room_height - (_exit_btn.scale * sprite_get_height(_exit_btn.sprite));
	if (_exit_x_bounds && _exit_y_bounds) {
		if (mouse_check_button(mb_left)) {
			_exit = true;
		}
		box.exit_ease = min(1, box.exit_ease + 0.12);
	} else {
		if !(box.background.animate == 2 && !box.saving_exit) box.exit_ease = max(0, box.exit_ease - 0.15);
	}
	
	
	// exit stuff
	if (box.background.animate == 0 && _exit) {
		// save
		if (_save) {
			if (box.using_type == "input box") {
				_current_menu.contents = box.contents;
			}
			
			if (box.using_type == "parameter box") {
				for (var _i = 0; _i < array_length(box.editables); _i++) {
					_current_menu.editables[_i] = box.editables[_i];
				}
			}
		}
		
		
		// start closing animation
		box.background.animate = 2;
	}
}


// start game fade effect
if (start_effect) {
	// expanding linear blur
	var _layer_id = layer_get_id("Global_Effects");
	var _fx_linear_blur = fx_create("_filter_linear_blur");
	fx_set_parameter(_fx_linear_blur, "g_LinearBlurVector", [start_effect_blur_x_distance, 0]);
	layer_set_fx(_layer_id, _fx_linear_blur);
	start_effect_blur_x_distance += 20;
	
	//fade to black
	if (start_effect_blur_x_distance > room_width/2) {
		var _alpha = map_clamp_value(start_effect_blur_x_distance, room_width/2, room_width, 0, 1);
		
		// draw fading in black rectangle on entire screen
		draw_set_alpha(_alpha);
		draw_set_color(c_black);
		draw_rectangle(0, 0, room_width, room_height, false);
		
		// go to next room when fully black
		if (_alpha == 1) room_goto(game_start_room);
	}
}