/// @description Returns current frame of sprite using convert_time_to_frames (uses current_time)

function sprite_get_current_frame(_sprite) {
	return convert_time_to_frames(sprite_get_speed(_sprite), sprite_get_number(_sprite));
}