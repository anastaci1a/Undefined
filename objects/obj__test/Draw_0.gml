if (mouse_check_button_pressed(mb_left)) {
	x = mouse_x;
	y = mouse_y;
}

if (mouse_check_button(mb_left)) {
	gui_draw_box_sprite_tiled_corners(x, y, mouse_x, mouse_y, spr_placeholder, 1, 10, 1, 10, c_white);
}