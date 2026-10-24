// Script: PlayerFunctions
function player_movment(){
	// 1. READ INPUTS (WASD + Arrow Keys)
	var move_right = keyboard_check(vk_right) || keyboard_check(ord("D"));
	var move_left  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
	var jump_key   = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));

	// 2. HORIZONTAL MOVEMENT
	var move_dir = move_right - move_left;
	h_speed = move_dir * move_speed;

	// 3. GRAVITY & JUMPING
	// Check if player is standing on the ground (1 pixel below)
	var is_grounded = place_meeting(x, y + 1, obj_Platform); 

	if (!is_grounded) {
	    v_speed += grav; // Apply gravity when in the air
	} else {
	    v_speed = 0;     // Reset vertical speed on ground
    
	    if (jump_key) {
	        v_speed = jump_force; // Perform jump
	    }
	}

	// 4. HORIZONTAL COLLISION (Walls)
	if (place_meeting(x + h_speed, y, obj_Platform)) {
	    // Move pixel-by-pixel until touching the wall perfectly
	    while (!place_meeting(x + sign(h_speed), y, obj_Platform)) {
	        x += sign(h_speed);
	    }
	    h_speed = 0; // Stop horizontal speed
	}
	x += h_speed; // Apply horizontal movement

	// 5. VERTICAL COLLISION (Floors/Ceilings)
	if (place_meeting(x, y + v_speed, obj_Platform)) {
	    // Move pixel-by-pixel until touching the floor/ceiling perfectly
	    while (!place_meeting(x, y + sign(v_speed), obj_Platform)) {
	        y += sign(v_speed);
	    }
	    v_speed = 0; // Stop vertical speed
	}
	y += v_speed; // Apply vertical movement
}
