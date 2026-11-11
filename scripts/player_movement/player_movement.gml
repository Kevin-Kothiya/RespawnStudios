
// Script: PlayerFunctions

function player_movment()
{
    // 1. READ INPUTS (WASD + Arrow Keys)
    var move_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
    var move_left  = keyboard_check(vk_left)  || keyboard_check(ord("A"));

    var jump_key = keyboard_check_pressed(vk_space)
                || keyboard_check_pressed(vk_up)
                || keyboard_check_pressed(ord("W"));

    // NEW: Sprint and crouch inputs
    var sprint_key = keyboard_check(vk_shift);

    var crouch_key = keyboard_check(vk_control)
                  || keyboard_check(ord("S"))
                  || keyboard_check(vk_down);


   
	// 2. CHECK IF GROUNDED
	var is_grounded = place_meeting(x, y + 1, obj_Platform);


	// 3. CROUCHING WITH COLLISION MASKS

	if (crouch_key)
	{
	    // Start crouching only when grounded
	    if (!is_crouching && is_grounded)
	    {
	        // Remember the position of Vector's feet
	        var old_bottom = bbox_bottom;

	        // Switch to the crouching collision mask
	        mask_index = mask_crouch;

	        // Keep the bottom of the mask in the same place
	        y += old_bottom - bbox_bottom;

	        is_crouching = true;
	    }
	}
	else if (is_crouching)
	{
	    // Try standing up when crouch is released
	    var old_y = y;
	    var old_bottom = bbox_bottom;

	    // Temporarily use the standing mask
	    mask_index = mask_stand;

	    // Keep Vector's feet in the same position
	    y += old_bottom - bbox_bottom;

	    // Check if the standing mask hits anything
	    if (place_meeting(x, y, obj_Platform))
	    {
	        // Ceiling is blocking Vector
	        // Return to crouching
	        mask_index = mask_crouch;
	        y = old_y;

	        is_crouching = true;
	    }
	    else
	    {
	        // Enough room to stand
	        is_crouching = false;
	    }
	}

	// IMPORTANT:
	// Check the ground again after changing masks
	is_grounded = place_meeting(x, y + 1, obj_Platform);


    // 4. SPRINTING
    var move_dir = move_right - move_left;

    // Only sprint when moving and not crouching
    is_sprinting = sprint_key
                && !is_crouching
                && move_dir != 0;


    // 5. MOVEMENT SPEED
    if (is_crouching)
    {
        move_speed = crouch_speed;
    }
    else if (is_sprinting)
    {
        move_speed = sprint_speed;
    }
    else
    {
        move_speed = walk_speed;
    }

    // Apply horizontal movement speed
    h_speed = move_dir * move_speed;


    // 6. GRAVITY & JUMPING
    if (!is_grounded)
    {
        v_speed += grav;
    }
    else
    {
        v_speed = 0;

        // Only jump if not crouching
        if (jump_key && !is_crouching)
        {
            v_speed = jump_force;
        }
    }


    // 7. HORIZONTAL COLLISION (Walls)
    if (h_speed != 0 &&
        place_meeting(x + h_speed, y, obj_Platform))
    {
        // Move pixel-by-pixel until touching the wall
        while (!place_meeting(
            x + sign(h_speed), y, obj_Platform))
        {
            x += sign(h_speed);
        }

        h_speed = 0;
    }

    x += h_speed;


    // 8. VERTICAL COLLISION (Floors/Ceilings)
    if (v_speed != 0 &&
        place_meeting(x, y + v_speed, obj_Platform))
    {
        // Move pixel-by-pixel until touching the surface
        while (!place_meeting(
            x, y + sign(v_speed), obj_Platform))
        {
            y += sign(v_speed);
        }

        v_speed = 0;
    }

    y += v_speed;
}


// 9. LADDER CLIMBING
function player_climb()
{
    // Check if player is colliding with the ladder
    var in_ladder = place_meeting(x, y, obj_Ladder);

    if (in_ladder)
    {
        var go_up = keyboard_check(ord("W"));

        if (go_up)
        {
            v_speed = -10;
        }
    }
}
