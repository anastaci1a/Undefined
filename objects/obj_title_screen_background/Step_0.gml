// error management
if (display_loading) {
	with (background_generator) {
		other.background_typist.in(100, 0);
		other.background_text = gpt_error_retry_status(other.background_generator);
	}
}


// background generator request management
if (gpt_receive_check_instant(background_generator)) {
	var _msg = gpt_messages_latest(background_generator).content;
	background_text = string_replace_all(string_replace_all(_msg, "[", "[["), "]", "]]");
	background_typist.in(5, 0);
	background_text_received = true;
	display_loading = false;
}


// background effects
if (background_effect && blur_x_distance < 20) {
	var _layer_id = layer_get_id("Background_Text");
	var _fx_linear_blur = fx_create("_filter_linear_blur");
	fx_set_parameter(_fx_linear_blur, "g_LinearBlurVector", [blur_x_distance, 0]);
	fx_set_parameter(_fx_linear_blur, "g_LinearBlurVector", [blur_x_distance, 0]);
	layer_set_fx(_layer_id, _fx_linear_blur);
	if (blur_x_distance < 20) blur_x_distance += 0.15;
}