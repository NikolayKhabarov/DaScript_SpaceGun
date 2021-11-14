require daslib/media
require game_params
require game_manager
require menu_variables
require controls_variables

def menu_control(dt: float)
    if inputTimeout > 0.f
        inputTimeout -= dt
    else
        menuOffset += int(get_mouse_scroll_delta())
        if get_key(VK_UP)
            inputTimeout = INPUT_TIMEOUT
            menuOffset++
        if get_key(VK_DOWN)
            inputTimeout = INPUT_TIMEOUT
            menuOffset--
        if get_key(VK_F1)
            inputTimeout = INPUT_TIMEOUT
            helpMenu = !helpMenu
            if helpMenu
                init_menu_variables()
                menuActive = true
                pauseBeforeMenu = gameManager.pause
                gameManager.pause = true
            else
                menuActive = false
                gameManager.pause = pauseBeforeMenu
        if get_key(VK_ESCAPE) || get_key(VK_RETURN)
            inputTimeout = INPUT_TIMEOUT
            if helpMenu
                menuActive = false
                gameManager.pause = pauseBeforeMenu
        if buyMenu
            if get_key(VK_RIGHT) || get_key(VK_RETURN)
                inputTimeout = INPUT_TIMEOUT
                if menuPage == 0
                    if menuOffset == 0
                        menuPage = 1
                        menuOffset = 1
                    elif menuOffset == 1
                        menuPage = 2
                        menuOffset = 4
                elif menuPage == 1
                    gameManager->buy_weapon(menuOffset)
                elif menuPage == 2
                    gameManager->buy_base(menuOffset)
            if get_key(VK_LEFT) || get_key(VK_BACK) || get_key(VK_ESCAPE)|| get_key(VK_B)
                inputTimeout = INPUT_TIMEOUT
                if menuPage == 0
                    buyMenu = false
                    menuActive = false
                if menuPage == 1 || menuPage == 2
                    menuPage = 0
                    menuOffset = 1
        if mainMenu
            if get_key(VK_LEFT) || get_key(VK_RIGHT) || get_key(VK_RETURN)
                inputTimeout = INPUT_TIMEOUT
                if menuOffset == 0
                    schedule_quit_game()
                elif menuOffset == 1
                    gameManager->restart()
                    mainMenu = false
                    menuActive = false
                elif menuOffset == 2
                    mainMenu = false
                    helpMenu = true
                elif menuOffset == 3
                    mainMenu = false
                    menuActive = false
            if get_key(VK_ESCAPE)
                inputTimeout = INPUT_TIMEOUT
                mainMenu = false
                menuActive = false