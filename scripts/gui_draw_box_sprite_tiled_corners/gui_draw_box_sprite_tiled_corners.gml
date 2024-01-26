/// @description Draws a box with a tiled texture based on the sprite (corners mode)

function gui_draw_box_sprite_tiled_corners(_x1, _y1, _x2, _y2, _sprite, _subimg = -1 /* -1 for default looping */, _sprite_scale = 1, _alpha = 1,  _outline_size = 0 /* in pixels */, _outline_col = c_white) {
	box = _gui_parse_corners(_x1, _y1, _x2, _y2);
	gui_draw_box_sprite_tiled(box.x, box.y, box.w, box.h, _sprite, _subimg, _sprite_scale, _alpha, _outline_size, _outline_col);
}