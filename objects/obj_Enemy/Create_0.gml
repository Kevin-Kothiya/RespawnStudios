/// @description Enemy Properties

enemy_health = 100;
enemy_damange = 10;

// Speed settings
enemy_move_speed = 4;        // Horizontal movement speed
enemy_jump_force = -12;       // Jump power (negative moves upwards)
enemy_grav = 0.4;            // Gravity applied per frame

// Velocity trackers
enemy_h_speed = 0;           // Current horizontal velocity
enemy_v_speed = 0;           // Current vertical velocity

enemy_jump_cooldown = 0;   // frames before the enemy may jump again
enemy_air_dir = 1;         // horizontal direction locked in while airborne