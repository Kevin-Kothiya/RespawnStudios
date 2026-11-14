
event_inherited();

interaction_label = "Activate Terminal";

terminal_active = false;

on_interact = function()
{
    terminal_active = !terminal_active;

    if (terminal_active)
    {
        interaction_label = "Deactivate Terminal";
        show_debug_message("Terminal activated!");
    }
    else
    {
        interaction_label = "Activate Terminal";
        show_debug_message("Terminal deactivated!");
    }
};
