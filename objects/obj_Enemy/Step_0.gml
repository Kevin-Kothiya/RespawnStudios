// Make sure the pause variable exists
if (!variable_global_exists("game_paused"))
{
    global.game_paused = false;
}

// Stop enemy behaviour when paused
if (global.game_paused)
{
    exit;
}


enemy_ai();
enemy_gravity();
enemy_movement();
