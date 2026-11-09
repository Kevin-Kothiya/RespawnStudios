/// obj_PauseMenu - Clean Up Event

// Restore instances if this object is removed while the world is frozen.
if (pause_world_frozen)
{
    instance_activate_all();
    pause_world_frozen = false;
}

global.game_paused = false;

// Surfaces must be freed to avoid leaking GPU memory.
if (surface_exists(pause_frame))
{
    surface_free(pause_frame);
    pause_frame = -1;
}
