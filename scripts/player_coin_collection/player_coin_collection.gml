
function player_coin_collection()
{
    // Check whether Vector is touching a gear
    var gear = instance_place(x, y, obj_Gears);

    if (gear != noone)
    {
        // Remove the collected gear
        with (gear)
        {
            instance_destroy();
        }

        // Add the gear to Vector's inventory
        player_gears += 1;

        show_debug_message(
            "Player gears: " + string(player_gears)
        );

        // Notify the objective manager
        if (instance_exists(obj_ObjectiveManager))
        {
            with (obj_ObjectiveManager)
            {
                on_gear_collected();
            }
        }
    }
}
