
function player_damage()
{
    // Check a small area around the player
    var enemy_hit = collision_rectangle(
        bbox_left - 2,
        bbox_top,
        bbox_right + 2,
        bbox_bottom,
        par_Enemy,
        false,
        true
    );

    if (enemy_hit != noone &&
        alarm[0] < 1 &&
        player_health > 0)
    {
        player_health -= enemy_hit.enemy_damage;
        alarm[0] = 60;
    }
}
