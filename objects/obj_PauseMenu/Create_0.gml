/// obj_PauseMenu - Create Event

// Initialize pause state for this gameplay room.
global.game_paused = false;

// Pause menu labels and selection.
pause_labels = ["RESUME", "MAIN MENU", "QUIT GAME"];
pause_selected = 0;

// Button layout (GUI pixels).
pause_btn_w = 350;
pause_btn_h = 58;
pause_btn_gap = 18;

// Mouse navigation.
last_mouse_x = -10000;
last_mouse_y = -10000;

// Centralized pause state.
pause_world_frozen = false;
pause_frame = -1; // Captured gameplay surface; -1 means none.

// Appearance.
pause_overlay_alpha = 0.45;
pause_blur_amount = 2.5; // Used by the optional shader version.
