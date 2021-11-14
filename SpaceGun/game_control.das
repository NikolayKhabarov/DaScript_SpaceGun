require daslib/media
require game_params
require scene
require game_manager
require menu_variables
require controls_variables

def game_control(dt: float)
    var cameraMove = SCREEN_MOVE_SMALL
    var selfDestructTimeStep = SHELL_SELF_DESTRUCT_STEP_BIG
    var gunPowerStep = GUN_POWER_STEP_BIG

    if get_key(VK_LSHIFT)
        cameraMove = SCREEN_MOVE_BIG
        selfDestructTimeStep = SHELL_SELF_DESTRUCT_STEP_SMALL
        gunPowerStep = GUN_POWER_STEP_SMALL

    scene.scale += get_mouse_scroll_delta() * SCREEN_SCALE_STEP
    if get_key(VK_ADD)
        scene.scale += SCREEN_SCALE_STEP
    if get_key(VK_SUBTRACT)
        scene.scale -= SCREEN_SCALE_STEP
    if get_key(VK_LEFT)
        scene.offset.x += cameraMove
    if get_key(VK_RIGHT)
        scene.offset.x -= cameraMove
    if get_key(VK_UP)
        scene.offset.y += cameraMove
    if get_key(VK_DOWN)
        scene.offset.y -= cameraMove

    if gameManager.player.gunReload <= 0.f
        if get_mouse_button(MB_LEFT) && gameManager.playerAllowShot
            gameManager->player_shot()
            gameManager.player.gunReload = GUN_RELOAD_DEFAULT

    if (gameManager.GuidanceShell) != null  &&  (gameManager.playerSelectedWeapon == 2)
        if get_mouse_button(MB_LEFT)
            gameManager->guidance_correction()
        if get_mouse_button(MB_RIGHT)
            gameManager.GuidanceShell.health = -1

    

    if inputTimeout > 0.f
        inputTimeout -= dt
    else
        if get_key(VK_P)
            inputTimeout = INPUT_TIMEOUT
            gameManager.pause = !gameManager.pause
        if get_key(VK_LBRACKET)
            inputTimeout = INPUT_TIMEOUT
            gameManager.timeSpeed--
        if get_key(VK_RBRACKET)
            inputTimeout = INPUT_TIMEOUT
            gameManager.timeSpeed++
        if get_key(VK_V)
            inputTimeout = INPUT_TIMEOUT
            gameManager->switch_point_of_interest()
            scene.offset = int2(get_screen_width() / 2, get_screen_height() / 2)
        if get_key(VK_Q)
            inputTimeout = INPUT_TIMEOUT
            gameManager.player.gunPower -= gunPowerStep
        if get_key(VK_E)
            inputTimeout = INPUT_TIMEOUT
            gameManager.player.gunPower += gunPowerStep
        if get_key(VK_Z)
            inputTimeout = INPUT_TIMEOUT
            gameManager.player.shellSelfDestruct -= selfDestructTimeStep
        if get_key(VK_X)
            inputTimeout = INPUT_TIMEOUT
            gameManager.player.shellSelfDestruct += selfDestructTimeStep
        if get_key(VK_G)
            inputTimeout = INPUT_TIMEOUT
            gameManager.player.godmode = !gameManager.player.godmode
        if get_key(VK_R)
            inputTimeout = INPUT_TIMEOUT
            gameManager->select_active_base()
        if get_key(VK_W)
            inputTimeout = INPUT_TIMEOUT
            gameManager->select_active_weapon()
        if get_key(VK_B)
            inputTimeout = INPUT_TIMEOUT
            init_menu_variables()
            buyMenu = true
            menuActive = true
            menuOffset = 1
            menuPage = 0
            gameManager.pause = GAME_MENU_AUTO_PAUSE
        if get_key(VK_F1)
            inputTimeout = INPUT_TIMEOUT
            init_menu_variables()
            helpMenu = true
            menuActive = true
            pauseBeforeMenu = gameManager.pause
            gameManager.pause = GAME_MENU_AUTO_PAUSE
        if get_key(VK_ESCAPE)
            inputTimeout = INPUT_TIMEOUT
            init_menu_variables()
            mainMenu = true
            menuActive = true
            menuOffset = 3
            pauseBeforeMenu = gameManager.pause
            gameManager.pause = GAME_MENU_AUTO_PAUSE

    if scene.scale > SCREEN_SCALE_MAX
        scene.scale = SCREEN_SCALE_MAX
    if scene.scale < SCREEN_SCALE_MIN
        scene.scale = SCREEN_SCALE_MIN

    if gameManager.player.shellSelfDestruct > SHELL_SELF_DESTRUCT_MAX
        gameManager.player.shellSelfDestruct = SHELL_SELF_DESTRUCT_MAX
    if gameManager.player.shellSelfDestruct < SHELL_SELF_DESTRUCT_MIN
        gameManager.player.shellSelfDestruct = SHELL_SELF_DESTRUCT_MIN

    if gameManager.timeSpeed > GAME_SPEED_MAX
        gameManager.timeSpeed = GAME_SPEED_MAX
    if gameManager.timeSpeed < GAME_SPEED_MIN
        gameManager.timeSpeed = GAME_SPEED_MIN

    if gameManager.player.gunPower > GUN_POWER_MAX
        gameManager.player.gunPower = GUN_POWER_MAX
    if gameManager.player.gunPower < GUN_POWER_MIN
        gameManager.player.gunPower = GUN_POWER_MIN