
/// obj_Bullet - Collision with par_Enemy

if (variable_global_exists("game_paused"))
{
    if (global.game_paused)
    {
        exit;
    }
}

if (instance_exists(other))
{
    other.take_damage(bullet_damage);
}

instance_destroy();
