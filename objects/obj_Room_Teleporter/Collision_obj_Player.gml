// Tutorial exit: use the new room's player instance, not the old one.
if (other.tutorial && target_room != noone)
{
    global.vos_spawn_pending = true;
    global.vos_spawn_x = target_x;
    global.vos_spawn_y = target_y;
    room_goto(target_room);
}
