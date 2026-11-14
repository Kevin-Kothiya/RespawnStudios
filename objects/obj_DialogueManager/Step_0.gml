
/// obj_DialogueManager - Step Event

global.dialogue_just_closed = false;

if (!dialogue_visible) exit;

// Don't advance dialogue while paused
if (variable_global_exists("game_paused"))
{
    if (global.game_paused) exit;
}

// Ignore the same key press that opened dialogue
if (dialogue_just_opened)
{
    dialogue_just_opened = false;
    exit;
}

// Advance dialogue with E or Enter
if (keyboard_check_pressed(ord("E")) ||
    keyboard_check_pressed(vk_enter))
{
    dialogue_line_index++;

    // Close when all lines have been displayed
    if (dialogue_line_index >= array_length(dialogue_lines))
	{
    dialogue_visible = false;
    global.dialogue_active = false;
    global.dialogue_just_closed = true;
	}
}
