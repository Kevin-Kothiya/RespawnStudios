/// obj_MainMenu - Create Event

// Initialize the pause system
global.game_paused = false;


// Button names
labels = ["START", "CONTINUE", "OPTIONS", "CREDITS", "QUIT"];

button_count = array_length(labels);

// Selected button (-1 means none selected)
selected = -1;

// Glow animation for each button
glow = array_create(button_count, 0);

// Menu position and size
// Menu position and spacing
menu_x = room_width * 0.5;
menu_gap = room_height * 0.10;

// Move the entire menu up or down
menu_offset_y = 150;

// Centre buttons, then apply the offset
menu_top = (room_height * 0.5)
         - ((button_count - 1) * menu_gap * 0.5)
         + menu_offset_y;

menu_scale = min(
    0.72,
    (room_height * 0.12) / sprite_get_height(spr_menu_button)
);

// Track mouse movement
last_mouse_x = -100000;
last_mouse_y = -100000;

// 0 = Main Menu
// 1 = Options
// 2 = Credits
// 3 = Continue placeholder
menu_panel = 0;
