
/// obj_DialogueManager - Create Event

// Dialogue state
dialogue_visible = false;
dialogue_speaker = "";
dialogue_lines = [];
dialogue_line_index = 0;

// Prevent the E press that opens dialogue
// from immediately advancing it.
dialogue_just_opened = false;

// Shared state for the player
global.dialogue_active = false;

// Start a conversation
start_dialogue = function(_speaker, _lines)
{
    dialogue_speaker = _speaker;
    dialogue_lines = _lines;
    dialogue_line_index = 0;

    dialogue_visible = true;
    dialogue_just_opened = true;

    global.dialogue_active = true;
};
