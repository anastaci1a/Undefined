/// @descriptions [Management vars & error retry]

if (prompted) {
	wait_time += 1;
}

// Error Retry
if (error_retry) {
	if (error > 0) {
		error_retry_times++;
		if (error_request_delay) {
			error = 0;
			error_retry_countdown = true;
			error_retry_countdown_count = error_retry_countdown_reset;
		} else {
			error = 0;
			event_user(1);
		}
	}

	if (error_retry_countdown) {
		if (error_retry_countdown_count <= 0) {
			error_retry_countdown_count = 0;
			error_retry_countdown = false;
			error_retry_countdown_reset *= error_retry_countdown_reset_multiplier;
			event_user(1);
		}
	
		error_retry_countdown_count--;
	}
}