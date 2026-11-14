// Damage only the player instance hit by this projectile.
if (variable_global_exists("game_paused") && global.game_paused) exit;

if (instance_exists(other))
{
    other.player_health = max(0, other.player_health - bullet_damage);
}
instance_destroy();
