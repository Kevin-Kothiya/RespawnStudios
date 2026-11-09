
/// obj_Bullet - Begin Step Event

// Check whether the game is paused
if (global.game_paused)
{
    // Save the bullet's speed only once
    if (!bullet_is_paused)
    {
        bullet_saved_speed = speed;
        speed = 0;
        bullet_is_paused = true;
    }
}
else
{
    // Restore the original speed when resumed
    if (bullet_is_paused)
    {
        speed = bullet_saved_speed;
        bullet_is_paused = false;
    }
}
