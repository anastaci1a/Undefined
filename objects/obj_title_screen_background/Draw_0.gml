if (draw_background) {
	background_textbox = scribble("[fnt_source_code_pro_small][c_lime]" + background_text + "[/]")
	.align(fa_left, fa_top)
	.wrap(room_width, room_height + 20);
	background_textbox.draw(5, 5, background_typist);
}