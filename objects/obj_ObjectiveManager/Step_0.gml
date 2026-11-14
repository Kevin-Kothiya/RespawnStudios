
/// obj_ObjectiveManager - Step Event

if (waiting_for_radar_dialogue)
{
    var dialogue_open = false;

    if (variable_global_exists("dialogue_active"))
    {
        dialogue_open = global.dialogue_active;
    }

    // Remember that Radar's dialogue opened
    if (dialogue_open)
    {
        radar_dialogue_seen_open = true;
    }
    // The conversation was open and has now closed
    else if (radar_dialogue_seen_open)
    {
        waiting_for_radar_dialogue = false;
        radar_dialogue_seen_open = false;

        on_radar_talk_completed();
    }
}


/// RETURN TO MAIN MENU AFTER TUTORIAL

if (objective_id == "complete")
{
    if (keyboard_check_pressed(vk_enter))
    {
        room_goto(Main_Menu);
    }
}

