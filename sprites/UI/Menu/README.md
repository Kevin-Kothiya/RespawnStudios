# THE INVASION OF VOS — Main Menu Button Kit

## Contents

- `SVG/` — **10 editable SVGs**, each of five labels in OFF and ON states.
- `PNG/` — **10 transparent 480 × 112 PNGs**, ready for GameMaker.
- `Strips/` — **5 transparent 960 × 112 PNG sprite strips**, OFF on the left, ON on the right.
- `GML/` — three GML files containing Create, Step, and Draw event code for `obj_MainMenu`.
- `VOS_buttons_preview.png` — contact sheet of the two button appearances.
- `build_assets.py` — optional Python source that generates the art. Requires CairoSVG and Pillow.

## GameMaker import steps

1. In the GameMaker Asset Browser, create a group `Sprites > UI > Menu` (groups are optional).
2. Create these five sprite resources: `spr_btn_start`, `spr_btn_continue`, `spr_btn_options`, `spr_btn_credits`, `spr_btn_quit`.
3. Each sprite needs exactly **2 subimages** (frames): **frame 0 OFF** and **frame 1 ON**. Import the matching two PNG files from `PNG/` in that order. Alternatively, import the matching `_strip2.png` as a two-frame horizontal image strip, splitting at 480 pixels. Some GameMaker import workflows do not automatically split strips, so check the frame count in the Sprite Editor.
4. Set **Origin = Middle Centre (240, 56)** for each sprite. Keep frame dimensions **480 × 112**. Use one animation speed setting for all sprites; the code chooses the frame explicitly.
5. Create an object named **`obj_MainMenu`**, with **no sprite assigned**. Add **Create**, **Step**, and **Draw** events. Paste the code from the three `.gml` files into the corresponding events.
6. Open the `Main_Menu` room, **delete the old `obj_Start` instance** from the Instances layer (you may keep its resource in the project), and place **one instance of `obj_MainMenu`** instead. Otherwise the old START button may overlap the new menu.
7. Ensure `Main_Menu` is the first room in Room Order. Press **F5** to test.

## Controls

- **Move the mouse** over a button to highlight it. Moving away turns it OFF again.
- **Up/Down arrows** or **W/S** select buttons, wrapping around the list.
- **Enter / Space** activates the selected button.
- **Left-click** activates the button under the cursor.
- **Escape** closes temporary panels; **F** toggles fullscreen while Options is open.
- All buttons begin **OFF** unless the mouse moves over them.
- Hover and selection smoothly crossfade OFF → ON and enlarge by up to 3.5%.

## Important notes

- GameMaker works most reliably with the **PNG assets**. The SVG files are editable masters and are not required at runtime.
- `START` changes to the existing `Test_Room` shown in the project screenshot. Change `room_goto(Test_Room);` if your level room has a different resource name.
- `CONTINUE` intentionally shows a **no saved game** message until a save/load system is implemented. It does not pretend to load a save.
- `OPTIONS` currently provides a fullscreen toggle; expand this when you build settings.
- `CREDITS` currently shows a basic placeholder. Add your team member credits later.
- `QUIT` calls `game_end()`.
- The controller uses the **regular Draw event**, and `mouse_x/mouse_y` in room coordinates. If you later add a moving camera to the menu, switch the menu drawing and hit testing together to GUI coordinates.
- If the game is scaled, keep pixel texture interpolation off for crisp artwork.

## Visual design

The UI follows the game's military science-fiction style: dark worn gunmetal, cyan circuit illumination, amber armour bevels, recessed bolt heads, and crisp block-pixel typography. Every SVG has transparent surroundings and uses vector pixel lettering rather than a font dependency.
