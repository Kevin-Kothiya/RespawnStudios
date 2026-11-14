function player_melee()
{
    // Don't attack while paused
    if (variable_global_exists("game_paused"))
    {
        if (global.game_paused) return;
    }

    // Don't attack during dialogue
    if (variable_global_exists("dialogue_active"))
    {
        if (global.dialogue_active) return;
    }

    // Update attack cooldown
    if (melee_cooldown > 0)
    {
        melee_cooldown--;
    }

    // Update animation timer
    if (melee_attack_timer > 0)
    {
        melee_attack_timer--;
    }

    // Press J to perform a melee attack
    if (keyboard_check_pressed(ord("J"))
        && melee_cooldown <= 0)
    {
        // Start cooldown
        melee_cooldown = melee_cooldown_max;

        // Reserve time for a future attack animation
        melee_attack_timer = 10;

        // Calculate attack area
        var attack_left;
        var attack_right;

        if (facing_dir >= 0)
        {
            // Attack to the right
            attack_left = bbox_right;
            attack_right = bbox_right + melee_range;
        }
        else
        {
            // Attack to the left
            attack_left = bbox_left - melee_range;
            attack_right = bbox_left;
        }

        var attack_top = bbox_top + 6;
        var attack_bottom = bbox_bottom - 6;

        // Find an enemy within melee range
        var target = collision_rectangle(
            attack_left,
            attack_top,
            attack_right,
            attack_bottom,
            par_Enemy,
            false,
            true
        );

        // Damage the enemy
		if (target != noone)
		{
		    // Use the same damage system as bullets
		    target.take_damage(melee_damage);
		}
		else
		{
		    show_debug_message("Melee attack missed!");
		}
    }
}
