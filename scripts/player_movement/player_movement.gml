
// Script: PlayerFunctions

function player_movement()
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

	var is_grounded = place_meeting(x, y + 1, obj_Platform) || place_meeting(x, y + 1, obj_Enemy);


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
	
	is_grounded = place_meeting(x, y + 1, obj_Platform)
	           || place_meeting(x, y + 1, obj_Enemy);





    // 4. PLAYER ANIMATIONS

    // Get movement direction
    var move_dir = move_right - move_left;

    // Check sprinting
    is_sprinting = sprint_key
                && !is_crouching
                && move_dir != 0;

    // Remember which way Vector is facing
    if (move_dir != 0)
    {
        facing_dir = move_dir;
    }

    // Select the correct animation
    var next_sprite;

    if (is_crouching)
    {
        if (move_dir == 0)
        {
            // Crouching without moving
            next_sprite = spr_Vector_CrouchIdle;
        }
        else
        {
            // Moving while crouching
            next_sprite = spr_Vector_Mask_Crouch;
        }
    }
    else
    {
        if (move_dir == 0)
        {
            // Standing without moving
            next_sprite = spr_Vector_Idle;
        }
        else
        {
            // Walking or sprinting
            next_sprite = spr_Vector_Walk;
        }
    }

    // Only reset the animation when switching sprites
    if (sprite_index != next_sprite)
    {
        sprite_index = next_sprite;
        image_index = 0;
    }

    // Play the selected animation
    image_speed = 1;

    // Keep Vector facing the correct direction
    image_xscale = facing_dir * player_scale;
    image_yscale = player_scale;


	
	
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


    // 7. HORIZONTAL COLLISION (Walls and Enemies)

	if (h_speed != 0 &&
	    (place_meeting(x + h_speed, y, obj_Platform) ||
	     place_meeting(x + h_speed, y, obj_Enemy)))
	{
	    while (!place_meeting(x + sign(h_speed), y, obj_Platform)
	        && !place_meeting(x + sign(h_speed), y, obj_Enemy))
	    {
	        x += sign(h_speed);
	    }

	    h_speed = 0;
	}

	x += h_speed;




	// 8. VERTICAL COLLISION
	// Check platforms and enemies

	var remaining = abs(v_speed);
	var vertical_dir = sign(v_speed);

	// Move in small steps to avoid passing through objects
	while (remaining > 0)
	{
	    var move_y = min(1, remaining) * vertical_dir;

	    var hit_platform = place_meeting(
	        x, y + move_y, obj_Platform
	    );

	    var hit_enemy = place_meeting(
	        x, y + move_y, obj_Enemy
	    );

	    if (hit_platform || hit_enemy)
	    {
	        // Stop when touching a platform or enemy
	        v_speed = 0;
	        break;
	    }

	    y += move_y;
	    remaining -= abs(move_y);
	}


	// JUMP ANIMATION

	// Check if Vector is on the ground after moving
	var grounded_after_move =
	    place_meeting(x, y + 1, obj_Platform)
	    || place_meeting(x, y + 1, obj_Enemy);

	// Play the jump animation while airborne
	if (!grounded_after_move)
	{
	    if (sprite_index != spr_Vector_Jump)
	    {
	        sprite_index = spr_Vector_Jump;
	    }

	    // Control the frames manually
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
	        image_index = 3; // Near the top
	    }
	    else if (v_speed < 2)
	    {
	        image_index = 4; // Highest point
	    }
	    else
	    {
	        image_index = 5; // Falling
	    }
	}
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
