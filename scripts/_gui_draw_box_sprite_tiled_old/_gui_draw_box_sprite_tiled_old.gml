/// @description Draws a box with a tiled texture based on the sprite (old)

function _gui_draw_box_sprite_tiled_old(_x, _y, _w, _h, _sprite, _subimg = -1 /* -1 for default looping */, _sprite_scale = 1, _alpha = 1,  _outline_size = 0 /* in pixels */, _outline_col = c_white) {
	// sprites
	var _sprite_w = sprite_get_width(_sprite);
	var _sprite_h = sprite_get_height(_sprite);
	var _scaled_sprite_w = _sprite_w * _sprite_scale;
	var _scaled_sprite_h = _sprite_h * _sprite_scale;
	
	var _x_sprites = int64(_w / _scaled_sprite_w) + 1;
	var _x_last_sprite_vis = (_w % _scaled_sprite_w) / _scaled_sprite_w;
	
	var _y_sprites = int64(_h / _scaled_sprite_h) + 1;
	var _y_last_sprite_vis = (_h % _scaled_sprite_h) / _scaled_sprite_h;
	
	if (_subimg < 0) _subimg = sprite_get_current_frame(_sprite);
	
	for (var __x = 0; __x < _x_sprites; __x++) {
		for (var __y = 0; __y < _y_sprites; __y++) {
			var _this_sprite_x = _x + (__x * _scaled_sprite_w);
			var _this_sprite_y = _y + (__y * _scaled_sprite_h);
			var _this_sprite_w = 0, _this_sprite_h = 0;
			
			if (__x == _x_sprites - 1) {
				_this_sprite_w = _sprite_w * _x_last_sprite_vis;
			} else {
				_this_sprite_w = _sprite_w;
			}
			
			if (__y == _y_sprites - 1) {
				_this_sprite_h = _sprite_h * _y_last_sprite_vis;
			} else {
				_this_sprite_h = _sprite_h;
			}
			
			draw_sprite_part_ext(_sprite, _subimg, 0, 0, _this_sprite_w, _this_sprite_h, _this_sprite_x, _this_sprite_y, _sprite_scale, _sprite_scale, c_white, _alpha);
		}
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