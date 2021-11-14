require daslib/media
require game_params
require game_manager
require menu_variables

def draw_menu_buy()
    if menuOffset < 0
        menuOffset = 0
    if menuPage == 0
        if menuOffset > 1
            menuOffset = 1
        text_out(25, 25,  "Shop menu, balance:{gameManager.player.money}$", COLOR_TEXT_DEFAULT)
        text_out(17, 50,  "{menuOffset == 1 ? ">" : " "}Bases", COLOR_TEXT_DEFAULT)
        text_out(17, 75,  "{menuOffset == 0 ? ">" : " "}Weapons", COLOR_TEXT_DEFAULT)
    elif menuPage == 2
        if menuOffset > 4
            menuOffset = 4
        var check_player_base = gameManager->check_active_player_base()
        var repair_unnecessary = check_player_base ? gameManager.playerBases[gameManager.activePlayerBase].health == BASE_HEALTH_DEFAULT : true
        var shield_unnecessary = check_player_base ? gameManager.playerBases[gameManager.activePlayerBase].shieldEnable : true
        text_out(25, 25,  "Shop menu -> Bases, balance:{gameManager.player.money}$", COLOR_TEXT_DEFAULT)
        text_out(17, 50,  "{menuOffset == 4 ? ">" : " "}Repair active base: { !check_player_base ? "N/a" : repair_unnecessary ? "Unnecessary" : format("%i$",MONEY_REPAIR_BASE)}",
            gameManager.player.money > MONEY_REPAIR_BASE ? COLOR_TEXT_GOOD : COLOR_TEXT_WARNING )
        text_out(17, 75,  "{menuOffset == 3 ? ">" : " "}Buy shield to active base: { !check_player_base ? "N/a" : shield_unnecessary ? "Purchased" : format("%i$",MONEY_BUY_SHIELD)}",
            gameManager.player.money > MONEY_BUY_SHIELD ? COLOR_TEXT_GOOD : COLOR_TEXT_WARNING )
        text_out(17, 100,  "{menuOffset == 2 ? ">" : " "}Buy addition base at planet: {MONEY_BUY_BASE_PLANET}$",
            gameManager.player.money > MONEY_BUY_BASE_PLANET ? COLOR_TEXT_GOOD : COLOR_TEXT_WARNING )
        text_out(17, 125,  "{menuOffset == 1 ? ">" : " "}Buy addition base at big moon: {MONEY_BUY_BASE_MOON_BIG}$",
            gameManager.player.money > MONEY_BUY_BASE_MOON_BIG ? COLOR_TEXT_GOOD : COLOR_TEXT_WARNING )
        text_out(17, 150,  "{menuOffset == 0 ? ">" : " "}Buy addition base at small moon: {MONEY_BUY_BASE_MOON_SMALL}$",
            gameManager.player.money > MONEY_BUY_BASE_MOON_SMALL ? COLOR_TEXT_GOOD : COLOR_TEXT_WARNING )
    elif menuPage == 1
        if menuOffset > 1
            menuOffset = 1
        text_out(25, 25,  "Shop menu -> Weapons, balance:{gameManager.player.money}$", COLOR_TEXT_DEFAULT)
        text_out(17, 50,  "{menuOffset == 1 ? ">" : " "}Buy VT shells mod for guns: {gameManager.playerBuyVTShell? "Purchased" : format("%i$",MONEY_BUY_MOD_SHELL_VT)}",
            gameManager.playerBuyVTShell? COLOR_TEXT_GOOD : gameManager.player.money > MONEY_BUY_MOD_SHELL_VT ? COLOR_TEXT_GOOD : COLOR_TEXT_WARNING )
        text_out(17, 75,  "{menuOffset == 0 ? ">" : " "}Buy guidance rocket: {gameManager.playerBuyGuidanceRocket? "Purchased" : format("%i$",MONEY_BUY_MOD_GUIDANCE_ROCKET)}",
            gameManager.playerBuyGuidanceRocket? COLOR_TEXT_GOOD : gameManager.player.money > MONEY_BUY_MOD_GUIDANCE_ROCKET ? COLOR_TEXT_GOOD : COLOR_TEXT_WARNING )