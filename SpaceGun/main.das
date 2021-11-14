require daslib/media
require daslib/random
require game_params
require scene
require object
require planet
require moon
require explosion
require shell
require vtshell
require asteroid
require base
require global
require game_manager
require menu_variables
require menu_help
require menu_buy
require menu_main
require hud
require game_control
require controls_variables
require menu_control
require gameover_window

[export]
def initialize
    scene = new Scene()
    gameManager = new GameManager()
    randomize_seed(seed)
    inputTimeout = 0.f
    init_menu_variables()
    helpMenu = true
    menuActive = true
    pauseBeforeMenu = gameManager.pause
    gameManager.pause = GAME_MENU_AUTO_PAUSE
    set_window_title("Space gun")
    return

[export]
def act(dt: float)
    if menuActive
        menu_control(dt)
    else
        game_control(dt)
    gameManager->update(gameManager.pause ? 0.f : dt * pow(2.f, float(gameManager.timeSpeed)))
    return

[export]
def draw
    gameManager->draw()
    if menuActive
        if buyMenu
            draw_menu_buy()
        elif helpMenu
            draw_help_windows()
        elif mainMenu
            draw_main_menu()
            if gameManager.player.gameover
                draw_gameover_window()
    else
        draw_hud()
        if gameManager.player.gameover
            draw_gameover_window()
    return