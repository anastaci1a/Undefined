if (gpt_receive_check_instant(agent)) {
	prompted = false;
	show_debug_message(gpt_messages_latest(agent).content);
}