/// @description Sets off the initialization/development of the new story within aicore

function aicore_initialize_new(_context) {
	// initial system text
	
	var _system_text = [];
	
	_system_text[0] =
	@"Do not respond in markdown, respond in plaintext.
	
	You are an AI whose sole function is to craft, administrate, and supervise an RPG. Your responsibilities include establishing the world's background and worldbuilding, developing characters, plotting engaging storylines, and ensuring a dynamic, interactive experience that reacts to the player's choices and actions.
	This game is determined by parameters set by the player, which will serve as the seeds from which you will grow an expansive and immersive universe. Consider these parameters as the foundation of the world; they dictate the genre, worldbuilding, primary conflict(s), protagonist, and main objective(s). You will extrapolate from these inputs, creating a world replete with history, lore, and adventure that the player can investigate.
	As the player embarks on their journey, they have the freedom to engage with your storyline, to venture off the beaten path and explore the unknown, or to simply exist and interact within the world as they see fit. You are to adapt and evolve the game environment in response to the player's actions, maintaining a seamless and captivating experience.";
	
	_system_text[1] =
	@"Here are the player-set parameters:
	```" + $"\n{_context}\n" + @"```";
	
	
	// individual prompts to set up and develop world
	
	var _prompt_text = [];
	
	_prompt_text[0] =
	@"First, you are to develop the main worldbuilding, initially presented by the player. Write several paragraphs describing integral details of the world.
	
	Write three different sections of a paragraph or more each:
	- Present: overall description of the world, actual world (real environment (nature? urban?)), societal enviroinment (social/societal climate, economics/politics, government, etc.)
	- History: details (conflicts, events, economic/political situation, etc.) which lead to the world developing into what is is now (also important figures, significant locations, etc.)
	- Other Necessary Details
	
	(if the worldbuilding the player has presented is already very developed and describes much of (or all of) the criteria, add what is necessary and restate what they described into this format)
	Make every word count, and do not write filler descriptions, make sure everything you write is important and necessary.";
	
	
	// set up and prompt ai
	
	aicore_create();
	with (global.aicore) { player_context = _context; }
	var _core = ai_get_core(global.aicore);
	gpt_messages_add(_core, "system", _system_text);
	ai_ask(global.aicore, "user", _prompt_text);
}