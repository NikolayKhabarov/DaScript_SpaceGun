require daslib/media
require menu_variables
require game_params

def draw_help_windows()
    if menuOffset > 0
        menuOffset = 0
    if menuOffset < -10
        menuOffset = -10
    text_out(25, 25 + menuOffset * 25,  "Space gun controls", COLOR_TEXT_DEFAULT)
    text_out(25, 50 + menuOffset * 25,  "Press ESC/F1 to exit form help window", COLOR_TEXT_DEFAULT)
    text_out(25, 75 + menuOffset * 25,  "F1                            - Help", COLOR_TEXT_DEFAULT)
    text_out(25, 100 + menuOffset * 25, "ESC                           - Game menu(restart, help, exit)", COLOR_TEXT_DEFAULT)
    text_out(25, 125 + menuOffset * 25, "UP/DOWN/LEFT/RIGHT/ENTER      - Navigation in menu or window", COLOR_TEXT_DEFAULT)
    text_out(25, 175 + menuOffset * 25, "UP/DOWN/LEFT/RIGHT            - Move camera in game. You can use it in combination SHIFT key to move faster", COLOR_TEXT_DEFAULT)
    text_out(25, 200 + menuOffset * 25, "+/- on NUNPAD or mouse scroll - Change camera zoom", COLOR_TEXT_DEFAULT)
    text_out(25, 225 + menuOffset * 25, "V                             - Select camera", COLOR_TEXT_DEFAULT)
    text_out(25, 250 + menuOffset * 25, "R                             - Select active base", COLOR_TEXT_DEFAULT)
    text_out(25, 275 + menuOffset * 25, "P                             - Togle game pause", COLOR_TEXT_DEFAULT)
    text_out(25, 300 + menuOffset * 25, "[/]                           - Select game speed", COLOR_TEXT_DEFAULT)
    text_out(25, 325 + menuOffset * 25, "G                             - Togle GOD mode", COLOR_TEXT_DEFAULT)
    text_out(25, 350 + menuOffset * 25, "E/Q                           - Change gun power. You can use it in combination SHIFT key to precise selection", COLOR_TEXT_DEFAULT)
    text_out(25, 375 + menuOffset * 25, "Z/X                           - Change shell self destruct time. You can use it in combination SHIFT key to precise selection", COLOR_TEXT_DEFAULT)
    text_out(25, 400 + menuOffset * 25, "LMB                           - Shot from selected weapon", COLOR_TEXT_DEFAULT)
    text_out(25, 425 + menuOffset * 25, "B                             - Shop menu", COLOR_TEXT_DEFAULT)
    text_out(25, 450 + menuOffset * 25, "W                             - Switch weapon", COLOR_TEXT_DEFAULT)
    text_out(25, 475 + menuOffset * 25, "LMB                           - Guidance shell correction", COLOR_TEXT_DEFAULT)
    text_out(25, 500 + menuOffset * 25, "RMB                           - Guidance shell destroy", COLOR_TEXT_DEFAULT)

    text_out(25, 550 + menuOffset * 25, "Colonization base AB321  captain logbook:", COLOR_TEXT_DEFAULT)
    text_out(25, 600 + menuOffset * 25, "22 may 2222 year:", COLOR_TEXT_DEFAULT)
    text_out(25, 625 + menuOffset * 25, "We established a base on the planet Gliese 876d but our opponents managed to land before us.", COLOR_TEXT_DEFAULT)
    text_out(25, 650 + menuOffset * 25, "It's good that, unlike them, we took a weapon with us!", COLOR_TEXT_DEFAULT)
    text_out(25, 675 + menuOffset * 25, "We must not let them create superiority in this planetary system, and we must create superiority ourselves!", COLOR_TEXT_DEFAULT)

    text_out(25, 725 + menuOffset * 25, "For each destroyed base, we will receive additional resources!", COLOR_TEXT_DEFAULT)
    text_out(25, 750 + menuOffset * 25, "We can destroy asteroids that threaten this system and earn resources on this", COLOR_TEXT_DEFAULT)