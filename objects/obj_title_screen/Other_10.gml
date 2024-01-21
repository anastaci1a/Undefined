/// @description load game

// start blur and disable menu
start_effect = true;


// access settings from menu and commit to global settings variable
var _menu_settings = menu.options.gui.inner[2];
var _menu_settings_params = _menu_settings.parameters;
var _menu_settings_editables = _menu_settings.editables;
var _settings = ds_map_create();

for (var _i = 0; _i < array_length(_menu_settings_params); _i++) {
	var _param = string_split(_menu_settings_params[_i], ":")[0];
	var _editable = _menu_settings_editables[_i];
	ds_map_add(_settings, _param, _editable);
}

settings_set(_settings);


// access player inputted game parameters and start aicore initialization

var _new_game = menu.options.gui.inner[0];
var _context_params = _new_game.inner[2].parameters;
var _context_editables = _new_game.inner[2].editables;
var _more_context = _new_game.inner[3].contents;

var _context = "";
for (var _i = 0; _i < array_length(_context_params); _i++) {
	var _param = string_split(_context_params[_i], ":")[0];
	_context += _param + ":\n";
	var _editable = _context_editables[_i];
	_context += _editable;
	if (_i != array_length(_context_params) - 1) _context += "\n\n";
}

aicore_initialize_new(_context);


// character select room

game_start_room = room_new_game;