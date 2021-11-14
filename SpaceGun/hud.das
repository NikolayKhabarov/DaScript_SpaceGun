require daslib/media
require game_params
require game_manager
require menu_variables

def draw_hud()
    text_out(80, 25, "Camera:              {gameManager.activePointOfInterest == 0 ? "Guidance roket" : gameManager.activePointOfInterest == 1 ? "Active base" : format("Celestial body[%i]", gameManager.indexPointOfInterest)}", COLOR_TEXT_DEFAULT)
    text_out(80, 50, "Game speed:          {gameManager.pause ? "PAUSE" : gameManager.timeSpeed < 0 ? format("x%.2f", pow(2.f, float(gameManager.timeSpeed))) : format("x%.0f", pow(2.f, float(gameManager.timeSpeed)))}", COLOR_TEXT_DEFAULT)

    text_out(80, 75, "Score:               {gameManager.player.score}", COLOR_TEXT_DEFAULT)
    text_out(80, 100, "Money:               {gameManager.player.money}$", COLOR_TEXT_DEFAULT)

    text_out(80, 125, "Danger objects:      {length(gameManager.enemyBullets)}", COLOR_TEXT_DEFAULT)
    text_out(80, 150, "Enemy units/bases:   {length(gameManager.enemyBases)}", COLOR_TEXT_DEFAULT)

    text_out(80, 175, "Weapon:              {gameManager.playerSelectedWeapon == 0 ? "Cannon" : gameManager.playerSelectedWeapon == 1 ? "Cannon with VT Shell" : "Guidance roket"}", COLOR_TEXT_DEFAULT)
    text_out(80, 200, "Weapon aiming angle: {gameManager.playerAllowShot ? format("%.1f",gameManager.player.gunAngle) : "N/a"}",
        gameManager.playerAllowShot && gameManager.player.gunAngle > GUN_ANGLE_WARNING ? COLOR_TEXT_WARNING : COLOR_TEXT_DEFAULT)
    text_out(80, 225, "Weapon muzle energy: {format("%.1f",gameManager.player.gunPower)}%", COLOR_TEXT_DEFAULT)
    text_out(80, 250, "Shell self destruct: {format("%.2f",gameManager.player.shellSelfDestruct)}s", COLOR_TEXT_DEFAULT)
    if gameManager.player.godmode
        text_out(get_screen_width() / 2 - 45, 150, "GOD MODE", COLOR_TEXT_DEFAULT)