require daslib/media
require game_params
require game_manager
require menu_variables
require controls_variables

def draw_main_menu()
    if menuOffset < 0
        menuOffset = 0
    if menuOffset > 3
        menuOffset = 3
    text_out(25, 25,  "Main menu", COLOR_TEXT_DEFAULT)
    text_out(17, 50,  "{menuOffset == 3 ? ">" : " "}Continue", COLOR_TEXT_DEFAULT)
    text_out(17, 75,  "{menuOffset == 2 ? ">" : " "}Help", COLOR_TEXT_DEFAULT)
    text_out(17, 100,  "{menuOffset == 1 ? ">" : " "}Restart", COLOR_TEXT_DEFAULT)
    text_out(17, 125,  "{menuOffset == 0 ? ">" : " "}Exit", COLOR_TEXT_DEFAULT)