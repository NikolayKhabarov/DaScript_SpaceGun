require daslib/media
require menu_variables
require game_manager
require game_params

def draw_gameover_window()
    text_out(get_screen_width() / 2 - 45, 175, "GAME OVER", COLOR_TEXT_DEFAULT)
    text_out(get_screen_width() / 2 - 45, 200, gameManager.player.win ? "YOU WIN" : "YOU LOSE!", COLOR_TEXT_DEFAULT)
    text_out(get_screen_width() / 2 - 45, 225, "YOUR SCORE:    {gameManager.player.score}", COLOR_TEXT_DEFAULT)
    text_out(get_screen_width() / 2 - 45, 250, "YOUR PLAYTIME: {format("%.0f",gameManager.player.playtime / 60.f)}m", COLOR_TEXT_DEFAULT)