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


sight_range   = 900;   // how far it can see the player
keep_distance = 450;   // distance it likes to shoot from
fire_rate     = 75;    // frames between shots
fire_timer    = 0;
bullet_speed  = 8;
enemy_patrol_dir = 1;   // direction used when the player is straight above/below

enemy_commit_dir   = 0;   // direction the enemy has committed to
enemy_commit_timer = 0;   // frames left on that commitment