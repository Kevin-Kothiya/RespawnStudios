
/// obj_ObjectiveManager - Create Event

// Prevent duplicate managers in the same room
if (instance_number(obj_ObjectiveManager) > 1)
{
    instance_destroy();
    exit;
}

// Current objective
objective_id = "talk_radar";
objective_text = "Talk to Radar";

// Track the status of each objective
objective_states = {
    talk_radar: "active",
    collect_gears: "not_started",
    return_radar: "not_started",
    reach_exit: "not_started"
};

// Collection progress
gears_collected = 0;
gears_required = 5;

// Track Radar conversations
waiting_for_radar_dialogue = false;
radar_dialogue_seen_open = false;


// FUNCTION: Move to the next objective
advance_objective = function(_new_id)
{
    if (objective_id == _new_id)
    {
        return;
    }

    // Mark the previous objective complete
    if (objective_id != "complete")
    {
        variable_struct_set(
            objective_states,
            objective_id,
            "complete"
        );
    }

    objective_id = _new_id;

    // Mark the new objective active
    if (_new_id != "complete")
    {
        variable_struct_set(
            objective_states,
            _new_id,
            "active"
        );
    }

    // Update the objective text
    switch (_new_id)
    {
        case "collect_gears":
            objective_text = "Collect 5 gears (0/5)";
            break;

        case "return_radar":
            objective_text = "Return to Radar";
            break;

        case "reach_exit":
            objective_text = "Reach the exit";
            break;

        case "complete":
            objective_text = "Tutorial complete!";
            break;
    }

    show_debug_message("Objective: " + objective_text);
};


// FUNCTION: Radar dialogue has finished
on_radar_talk_completed = function()
{
    if (objective_id == "talk_radar")
    {
        // Start collecting gears
        advance_objective("collect_gears");

        // NEW: Count gears Vector already collected
        on_gear_collected();
    }
    else if (objective_id == "return_radar")
    {
        advance_objective("reach_exit");
    }
};


 // FUNCTION: Update gear objective progress
 on_gear_collected = function()
 {
     // Read the player's actual gear inventory
     if (!instance_exists(obj_Player))
     {
         return;
     }

     // Keep track of gears even before the objective starts
     gears_collected = min(
         obj_Player.player_gears,
         gears_required
     );

     // Only update the objective HUD when collecting gears
     if (objective_id == "collect_gears")
     {
         objective_text =
             "Collect " + string(gears_required) + " gears (" +
             string(gears_collected) + "/" +
             string(gears_required) + ")";

         // Advance when enough gears have been collected
         if (gears_collected >= gears_required)
         {
             advance_objective("return_radar");
         }
     }
 };


// FUNCTION: Check whether the exit is available
try_reach_exit = function()
{
    if (objective_id != "reach_exit")
    {
        return false;
    }

    advance_objective("complete");
    return true;
};
