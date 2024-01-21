/// @description Returns a string of the real-time status of the current "error retry"-ing prompt.
/// @return String

function gpt_error_retry_status(_id_of_instance) {
	var _r = "";
	var _text_states = ["loading API...", "request error.", "check internet connection."];
	with (_id_of_instance) {
		if (!message_received) {
			_r = _text_states[0];
			var _secs = ceil(wait_time / game_get_speed(gamespeed_fps));
			_r += " (" + string(_secs) + " secs)";
		}
	
		if (0 < error_retry_times && error_retry_times < error_retry_max_times) {
			_r = _text_states[1];
			if (error_retry_times > 0) {
				_r += "\n> request retries: " + string(error_retry_times) + "x";
			}
			if (error_retry_countdown) {
				var _secs = ceil(error_retry_countdown_count / game_get_speed(gamespeed_fps));
				_r += "\n> retrying in " + string(_secs) + " secs...";
			} else {
				var _secs = ceil(wait_time / game_get_speed(gamespeed_fps));
				_r += "\n> waiting for request... (" + string(_secs) + " secs)";
			}
		} else if (error_retry_failed) {
			_r = _text_states[2];
			_r += "\n> exceeded retries limit: " + string(error_retry_max_times) + "x";
			_r += "\n> check internet connection and restart.";
		}
	}
	
	return _r;
}