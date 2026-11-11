/// @description Player Variables
player_health = 100;
player_dps = 10;
player_gears = 0;

// Speed settings
move_speed = 5;        // Horizontal movement speed
jump_force = -12;       // Jump power (negative moves upwards)
grav = 0.4;            // Gravity applied per frame

// Velocity trackers
h_speed = 0;           // Current horizontal velocity
v_speed = 0;           // Current vertical velocity

// Add to obj_Player Create Event
facing_dir = 1; // 1 = right, -1 = left

grenade_charge     = 0;
grenade_charge_max = 60;   // steps to reach full power (1 second at 60 fps)
grenade_min_speed  = 4;    // horizontal speed on a quick tap
grenade_max_speed  = 16;   // horizontal speed at full charge


// Interaction system
interact_distance = 120;
interact_target = noone;


// Sprint and crouch settings
walk_speed = 5;
sprint_speed = 8;
crouch_speed = 2;

// Movement states
is_sprinting = false;
is_crouching = false;

// Temporary crouch appearance
stand_scale = 1;
crouch_scale = 0.65;


// Standing and crouching collision masks
mask_stand = spr_Vector_Mask_Stand;
mask_crouch = spr_Vector_Mask_Crouch;

// Start with the standing collision mask
mask_index = mask_stand;
