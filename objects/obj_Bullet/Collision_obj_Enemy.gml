
/// obj_Bullet - Collision with obj_Enemy

// Don't process collisions while paused
if (variable_global_exists("game_paused"))
{
    if (global.game_paused)
    {
        exit;
    }
}

// 'other' is the enemy hit by this bullet
if (instance_exists(other))
{
    other.take_damage(bullet_damage);
}

// Destroy the bullet after impact
instance_destroy();
