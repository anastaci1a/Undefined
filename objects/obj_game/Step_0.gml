//show_debug_message(fps);


// glow exit (escape key) effect
if (keyboard_check(vk_escape)) {
	if (!layer_exists("Glow")) layer_create(-1000, "Glow");
	glow_amount += 0.02;
	glow_amount = clamp(glow_amount, 0, 1);
} else {
	glow_amount *= 0.9;
}

if (layer_exists("Glow")) {
	var _glow_radius = 512 * glow_amount;
	var _glow_quality = 4;
	var _glow_intensity = 0.9 * glow_amount;
	var _glow_gamma = 2;
	var _glow_alpha = glow_amount;
	
	var _fx_glow = fx_create("_effect_glow");
	fx_set_parameter(_fx_glow, "g_GlowRadius", _glow_radius);
	fx_set_parameter(_fx_glow, "g_GlowQuality", _glow_quality);
	fx_set_parameter(_fx_glow, "g_GlowIntensity", _glow_intensity);
	fx_set_parameter(_fx_glow, "g_GlowGamma", _glow_gamma);
	fx_set_parameter(_fx_glow, "g_GlowAlpha", _glow_alpha);
	layer_set_fx("Glow", _fx_glow);
	
	if (glow_amount > 0.95) game_end();
	if (glow_amount < 0.01) layer_destroy("Glow");
}


// not first time title screen
if (room == rm_0_title_screen && !instance_exists(obj_title_screen)) {
	instance_create_layer(0, 0, "GUI_Back", obj_title_screen);
	with (obj_title_screen) {
		event_user(1);
	}
}

if (keyboard_check_pressed(vk_right)) {
	room_goto_next();
}
if (keyboard_check_pressed(vk_left)) {
	room_goto_previous();
}