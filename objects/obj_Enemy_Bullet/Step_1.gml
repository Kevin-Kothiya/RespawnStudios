/// obj_Enemy_Bullet - Begin Step (pause/resume movement)
if (variable_global_exists("game_paused") && global.game_paused)
{
    if (!bullet_is_paused)
    {
        bullet_saved_speed = speed;
        speed = 0;
        bullet_is_paused = true;
    }
}
else if (bullet_is_paused)
{
    speed = bullet_saved_speed;
    bullet_is_paused = false;
}
