
/// obj_EnemyHeavy - Create Event

// Initialize all shared enemy variables and functions
event_inherited();

// Heavy enemy properties
enemy_health = 200;
enemy_max_health = enemy_health;

enemy_damage = 20;
enemy_move_speed = 0.6;

// Make this enemy physically larger
image_xscale = 0.65;
image_yscale = 0.65;
