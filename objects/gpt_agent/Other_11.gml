/// @description [Error retry disable]

if (error_retry_times < error_retry_max_times) {
	event_user(0);
} else {
	error_retry = false;
	error_retry_failed = true;
}