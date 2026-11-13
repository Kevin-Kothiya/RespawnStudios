
/// obj_Player - End Step Event


// Prevent interactions while dialogue is active
if (variable_global_exists("dialogue_active"))
{
    if (global.dialogue_active)
    {
        exit;
    }
}

// Don't reopen dialogue on the same E press
if (variable_global_exists("dialogue_just_closed"))
{
    if (global.dialogue_just_closed)
    {
        exit;
    }
}

// Clear the previous interaction target
interact_target = noone;

// Do not interact while the game is paused
if (variable_global_exists("game_paused"))
{
    if (global.game_paused) exit;
}

// Find the nearest interactable object
var nearest = instance_nearest(x, y, obj_Interactable);

// Check if an interactable exists
if (nearest != noone)
{
    var distance = point_distance(
        x, y,
        nearest.x, nearest.y
    );

    // Only interact when close enough
    if (distance <= interact_distance)
    {
        interact_target = nearest;

        // Press E to interact
        if (keyboard_check_pressed(ord("E")))
        {
            with (nearest)
            {
                on_interact();
            }
        }
    }
}


/// obj_Player - End Step
// Correct overlap when landing on an enemy

var enemy = instance_place(x, y, obj_Enemy);

if (enemy != noone)
{
    // Only correct when Vector is above the enemy
    // and is falling or no longer moving vertically
    if (v_speed >= 0 &&
        bbox_top < enemy.bbox_top &&
        bbox_bottom > enemy.bbox_top)
    {
        // Move Vector onto the enemy's head
        var overlap = bbox_bottom - enemy.bbox_top;

        y -= overlap;
        v_speed = 0;
    }
}
