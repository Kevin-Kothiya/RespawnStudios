/// @description Player Movement Variables
player_health = 100;

// Speed settings
move_speed = 5;        // Horizontal movement speed
jump_force = -12;       // Jump power (negative moves upwards)
grav = 0.4;            // Gravity applied per frame

// Velocity trackers
h_speed = 0;           // Current horizontal velocity
v_speed = 0;           // Current vertical velocity

// Add to obj_Player Create Event
facing_dir = 1; // 1 = right, -1 = left