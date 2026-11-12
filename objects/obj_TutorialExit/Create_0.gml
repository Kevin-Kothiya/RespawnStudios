
/// obj_TutorialExit - Create Event

event_inherited();

interaction_label = "Use Exit";

on_interact = function()
{
    if (instance_exists(obj_ObjectiveManager))
    {
        with (obj_ObjectiveManager)
        {
            // Tutorial already finished
            if (objective_id == "complete")
            {
                // Do nothing
            }
            else if (try_reach_exit())
            {
                show_debug_message(
                    "Tutorial completed successfully!"
                );
            }
            else
            {
                show_debug_message(
                    "Complete your objectives first!"
                );
            }
        }
    }
};
