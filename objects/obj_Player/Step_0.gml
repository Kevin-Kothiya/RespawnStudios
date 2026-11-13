/// @description Player functions


/// Stop player controls after tutorial completion

if (instance_exists(obj_ObjectiveManager))
{
    if (obj_ObjectiveManager.objective_id == "complete")
    {
        exit;
    }
}



player_movement();
player_coin_collection();
player_shooting();
player_grenade();
player_climb();
player_damage();
player_melee();

// JUMP ANIMATION

// Check if Vector is on the ground
var grounded_after_move =
    place_meeting(x, y + 1, obj_Platform)
    || place_meeting(x, y + 1, par_Enemy);

// Only use the jump sprite when airborne
if (!grounded_after_move)
{
    if (sprite_index != spr_Vector_Jump)
    {
        sprite_index = spr_Vector_Jump;
    }

    // Control the jump animation manually
    image_speed = 0;

    if (v_speed < -9)
    {
        image_index = 1; // Takeoff
    }
    else if (v_speed < -5)
    {
        image_index = 2; // Rising
    }
    else if (v_speed < -1)
    {
        image_index = 3; // Near apex
    }
    else if (v_speed < 2)
    {
        image_index = 4; // Apex
    }
    else
    {
        image_index = 5; // Falling
    }
}