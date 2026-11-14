/// @description Enemy Properties

enemy_health = 100;
enemy_damage = 10;

// Speed settings
enemy_move_speed = 1;        // Horizontal movement speed
enemy_jump_force = -12;       // Jump power (negative moves upwards)
enemy_grav = 0.4;            // Gravity applied per frame

// Velocity trackers
enemy_h_speed = 0;           // Current horizontal velocity
enemy_v_speed = 0;           // Current vertical velocity

// Shared AI state (required by Pierre's ranged/jumping enemy AI)
enemy_jump_cooldown = 0;
enemy_air_dir = 1;
sight_range = 900;
keep_distance = 450;
fire_rate = 75;
fire_timer = 0;
bullet_speed = 8;
enemy_patrol_dir = 1;
enemy_commit_dir = 0;
enemy_commit_timer = 0;


// ========================================
// CENTRALIZED ENEMY DAMAGE AND DEATH
// ========================================

// Prevent an enemy from dying more than once
enemy_dead = false;

// Store maximum health for future health bars
enemy_max_health = enemy_health;


// FUNCTION: Take damage from any weapon
take_damage = function(_amount)
{
    // Ignore damage if already defeated
    if (enemy_dead)
    {
        return;
    }

    // Prevent negative damage or healing by accident
    var damage = max(0, _amount);

    if (damage <= 0)
    {
        return;
    }

    // Reduce this enemy's health
    enemy_health = max(0, enemy_health - damage);

    show_debug_message(
        "Enemy " + string(id)
        + " took " + string(damage)
        + " damage. HP: " + string(enemy_health)
    );

    // Check for death
    if (enemy_health <= 0)
    {
        die();
    }
};


// FUNCTION: Enemy death
die = function()
{
    // Prevent duplicate death processing
    if (enemy_dead)
    {
        return;
    }

    enemy_dead = true;

    show_debug_message(
        "Enemy " + string(id) + " defeated!"
    );

    // FUTURE FEATURES:
    // Play death animation
    // Drop weapon or ammunition
    // Award experience or currency

    // Remove the enemy
    instance_destroy();
};
