/// @description Draws a box with a tiled texture based on the sprite

function gui_draw_box_sprite_tiled(_x, _y, _w, _h, _sprite, _subimg = -1 /* -1 for default looping */, _sprite_scale = 1, _alpha = 1,  _outline_size = 0 /* in pixels */, _outline_col = c_white) {
	// sprites setup
	
	var _sprite_w = sprite_get_width(_sprite);
	var _sprite_h = sprite_get_height(_sprite);
	var _scaled_sprite_w = _sprite_w * _sprite_scale;
	var _scaled_sprite_h = _sprite_h * _sprite_scale;
	
	/* I wrote it but I legitimately have no idea how this line works */  var _x_sprites = ceil_even(_w / _scaled_sprite_w) + 1;
	/* refer to "The Odd Box Problem" paint file thing for this */        var _x_end_sprite_vis = ((_w - _scaled_sprite_w) % (2 * _scaled_sprite_w)) / _scaled_sprite_w / 2;
	/* weird byproduct of this system */                                  if (_x_sprites == 1) _x_end_sprite_vis = 1 + (2 * _x_end_sprite_vis);
	
	// same shit for y
	var _y_sprites = ceil_even(_h / _scaled_sprite_h) + 1;
	var _y_end_sprite_vis = ((_h - _scaled_sprite_h) % (2 * _scaled_sprite_h)) / _scaled_sprite_h / 2;
	if (_y_sprites == 1) _y_end_sprite_vis = 1 + (2 * _y_end_sprite_vis);
	
	if (_subimg < 0) _subimg = sprite_get_current_frame(_sprite);
	
	
	// drawing
	
	var _this_sprite_x = _x;
	for (var __x = 0; __x < _x_sprites; __x++) {
		// width
		var __draw_mode = 0;
		var _this_sprite_w = _sprite_w;
		if (__x == 0) {
			// left
			_this_sprite_w = _sprite_w * _x_end_sprite_vis;
			
			// single row
			if (_x_sprites == 1) __draw_mode = 9;
			// multi row
			else __draw_mode = 2;
		} else if (__x == _x_sprites - 1) {
			// right
			_this_sprite_w = _sprite_w * _x_end_sprite_vis;
			__draw_mode = 1;
		}
		
		var _this_sprite_y = _y;
		for (var __y = 0; __y < _y_sprites; __y++) {
			// height & draw mode
			var _draw_mode = __draw_mode;
			var _this_sprite_h = _sprite_h;
			if (__y == 0) {
				// top
				_this_sprite_h = _sprite_h * _y_end_sprite_vis;
				
				// single row
				if (_y_sprites == 1) {
					// single column
					if (_x_sprites == 1) {
						_draw_mode = 9;
					}
					// multi column
					else {
						if (_draw_mode == 2) _draw_mode = 5;
						else if (_draw_mode == 1) _draw_mode = 6;
						else _draw_mode = 9;
					}
				}
				// multi row
				else {
					if (_draw_mode == 1) _draw_mode = 3;
					else if (_draw_mode == 9) _draw_mode = 7;
					else _draw_mode = 2;
				}
			} else if (__y == _y_sprites - 1) {
				// bottom
				_this_sprite_h = _sprite_h * _y_end_sprite_vis;
				if (_draw_mode == 2) _draw_mode = 4;
				else if (_draw_mode == 9) _draw_mode = 8;
				else _draw_mode = 1;
			}
			
			// draw
			switch (_draw_mode) {
				// normal
				case 0: draw_sprite_ext(_sprite, _subimg, _this_sprite_x, _this_sprite_y, _sprite_scale, _sprite_scale, 0, c_white, _alpha);
				break;
				
				// bottom || right
				case 1: draw_sprite_part_ext(_sprite, _subimg, 0, 0, _this_sprite_w, _this_sprite_h, _this_sprite_x, _this_sprite_y, _sprite_scale, _sprite_scale, c_white, _alpha);
				break;
				
				// top || left
				case 2:  draw_sprite_part_ext(_sprite, _subimg, _sprite_w - _this_sprite_w, _sprite_h - _this_sprite_h, _this_sprite_w, _this_sprite_h, _this_sprite_x, _this_sprite_y, _sprite_scale, _sprite_scale, c_white, _alpha);
				break;
				
				// top && right
				case 3: draw_sprite_part_ext(_sprite, _subimg, 0, _sprite_h - _this_sprite_h, _this_sprite_w, _this_sprite_h, _this_sprite_x, _this_sprite_y, _sprite_scale, _sprite_scale, c_white, _alpha);
				break;
				
				// bottom && left
				case 4: draw_sprite_part_ext(_sprite, _subimg, _sprite_w - _this_sprite_w, 0, _this_sprite_w, _this_sprite_h, _this_sprite_x, _this_sprite_y, _sprite_scale, _sprite_scale, c_white, _alpha);
				break;
				
				// single row && left
				case 5: {
					var _left = _sprite_w - _this_sprite_w;
					var _top = (_sprite_h - _this_sprite_h) / 2;
					draw_sprite_part_ext(_sprite, _subimg, _left, _top, _this_sprite_w, _this_sprite_h, _this_sprite_x, _this_sprite_y, _sprite_scale, _sprite_scale, c_white, _alpha);
				}
				break;
				
				// single row && right
				case 6: {
					var _left = 0;
					var _top = (_sprite_h - _this_sprite_h) / 2;
					draw_sprite_part_ext(_sprite, _subimg, _left, _top, _this_sprite_w, _this_sprite_h, _this_sprite_x, _this_sprite_y, _sprite_scale, _sprite_scale, c_white, _alpha);
				}
				break;
				
				// single column && top
				case 7: {
					var _left = (_sprite_w - _this_sprite_w) / 2;
					var _top = _sprite_h - _this_sprite_h;
					draw_sprite_part_ext(_sprite, _subimg, _left, _top, _this_sprite_w, _this_sprite_h, _this_sprite_x, _this_sprite_y, _sprite_scale, _sprite_scale, c_white, _alpha);
				}
				break;
				
				// single column && bottom
				case 8: {
					var _left = (_sprite_w - _this_sprite_w) / 2;
					var _top = 0;
					draw_sprite_part_ext(_sprite, _subimg, _left, _top, _this_sprite_w, _this_sprite_h, _this_sprite_x, _this_sprite_y, _sprite_scale, _sprite_scale, c_white, _alpha);
				}
				break;
				
				// single row || single column (not edge)
				case 9: {
					var _left = (_sprite_w - _this_sprite_w) / 2;
					var _top = (_sprite_h - _this_sprite_h) / 2;
					draw_sprite_part_ext(_sprite, _subimg, _left, _top, _this_sprite_w, _this_sprite_h, _this_sprite_x, _this_sprite_y, _sprite_scale, _sprite_scale, c_white, _alpha);
				}
				break;
			}
			
			// y
			_this_sprite_y += _this_sprite_h * _sprite_scale;
		}
		
		// x
		_this_sprite_x += _this_sprite_w * _sprite_scale;
	}
	
	
	// outline
	
	if (_outline_size > 0) {
		var _outline_h = clamp(_outline_size, 0, _h);
		var _outline_w = clamp(_outline_size, 0, _w);
		
		draw_set_color(_outline_col);
		draw_set_alpha(_alpha);
		
		// top
		draw_rectangle(_x, _y, _x + _w, _y + _outline_h, false);
		// bottom
		draw_rectangle(_x, _y + _h - _outline_h, _x + _w, _y + _h, false);
		// left
		draw_rectangle(_x, _y, _x + _outline_w, _y + _h, false);
		// right
		draw_rectangle(_x + _w - _outline_w, _y, _x + _w, _y + _h, false);
	}
}