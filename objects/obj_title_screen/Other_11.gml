/// @description activate title (title_array_index = 2)
scribble_anim_wave(SCRIBBLE_DEFAULT_WAVE_SIZE, SCRIBBLE_DEFAULT_WAVE_FREQUENCY, SCRIBBLE_DEFAULT_WAVE_SPEED);
			
var _layer_id = layer_get_id("GUI_Back");
layer_enable_fx(_layer_id, true);

var _background_id = layer_background_get_id(layer_get_id("Background"));
layer_background_blend(_background_id, c_black);

title_array_index = 2;